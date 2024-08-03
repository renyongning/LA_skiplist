#ifdef BTREE_VIP

#include "chained_adaptive_btree.h"

ChainedAdaptive::ChainedAdaptive() {
    //this->hashpower = -1; // not initialized
    //this->hmsize = 0;
    this->cardinality = 0;
    this->totalAccess = 0;
    this->u0 = this->v0 = this->w0 = -1;
    this->u1 = this->v1 = this->w1 = -1;
    this->mode = ADAPTIVE;
}

void ChainedAdaptive::initHashpower(int hashpower) {
    //this->hashpower = hashpower;
    //this->hmsize = pow(2, hashpower);
    epochSize = btree.size()*float(epoch_size_factor);
    mode = ADAPTIVE;
    numReqsSlab = epochSize;
    displacement = 0;
    displacement_sq = 0;
    statReqCount = 0;
}

void ChainedAdaptive::bulkLoad(ulong *keys, ulong num_keys) {
    std::vector<std::pair<ulong, ulong>> pairs;
    // generate key-value pairs
    for(ulong i=0; i<num_keys; i++)
    {
        pairs.push_back(std::make_pair(keys[i], _random()));
        if(mode == ADAPTIVE){
            if(accessCounter.find(keys[i]) == accessCounter.end())
            accessCounter[keys[i]] = 0;}
    }
    btree.bulk_load(pairs.begin(), pairs.end());
    this->cardinality = num_keys;
}

// return the access frequency of keys
std::map<ulong, double> ChainedAdaptive::getFreq()
{
    std::map<ulong, double> result;

    for(const auto& pair:accessCounter)
    {
        ulong k = pair.first;
        double f = static_cast<double>(pair.second) / totalAccess;
        result[k] = f;
       // std::cout << "Test Freq of "<< k << ":"<<result[k] <<std::endl;
    }
    return result;
}

Metrics ChainedAdaptive::processRequests(HashmapReq *reqs, ulong count) {
    Metrics m;
    m.displacement = displacementMetric;
    getMetricsStart(m);
    ulong i = 0, j;
    ulong countReal = count;
    // make this a multiple of 10, to avoid inner for loop check for i < count
    count = count - (count % 10);
    while(i < count) {
        if (mode == ADAPTIVE) {
            while (numReqs < numReqsSlab && i<count) {
                for (j=0; j<10; j++,i++) {
                    switch (reqs[i].reqType) {
                        case FETCH_REQ:
                            _fetchAdaptive(&reqs[i]);
                            break;
                        case INSERT_REQ:
                            _insert(&reqs[i]);
                            break;
                        case DELETE_REQ:
                            _delete(&reqs[i]);
                            break;
                        default:
                            break;
                    }
                }
            }
            if (i == count) break;
            numReqsSlab += sample_size;
            _resetAccesses();
            _clearCache();
            mode = BENCHMARKING;
            displacement = 0;
            displacement_sq = 0;
            statReqCount = 0;
        }
        if (mode == BENCHMARKING) {
            while (numReqs < numReqsSlab && i<count) {
                for (j=0; j<10; j++, i++) {
                    switch (reqs[i].reqType) {
                        case FETCH_REQ:
                            _fetchBenchmark(&reqs[i]);
                            break;
                        case INSERT_REQ:
                            _insert(&reqs[i]);
                            break;
                        case DELETE_REQ:
                            _delete(&reqs[i]);
                            break;
                        default:
                            break;
                    }
                }
            }
            if (i == count) break;
            // Calculate u0, v0, w0
            u0 = double(displacement)/double(statReqCount);
            v0 = double(displacement_sq)/double(statReqCount-1) -
                double(displacement*displacement)/(double(statReqCount)*double(statReqCount-1));
            w0 = sqrt(((-1*log(1-confidence_prct))*2*v0)/statReqCount);
            numReqsSlab += epochSize*(periodicity - 1);
            mode = DEFAULT;
        }
        if (mode == DEFAULT) {
            while (numReqs < numReqsSlab && i<count) {
                for (j=0; j<10; j++, i++) {
                    switch (reqs[i].reqType) {
                        case FETCH_REQ:
                            _fetchDefault(&reqs[i]);
                            break;
                        case INSERT_REQ:
                            _insert(&reqs[i]);
                            break;
                        case DELETE_REQ:
                            _delete(&reqs[i]);
                            break;
                        default:
                            break;
                    }
                }
            }
            if (i == count) break;
            numReqsSlab += sample_size;
            mode = SENSING;
            displacement = 0;
            displacement_sq = 0;
            statReqCount = 0;
        }
        if (mode == SENSING) {
            while (numReqs < numReqsSlab && i<count) {
                for (j=0; j<10; j++, i++) {
                    switch (reqs[i].reqType) {
                        case FETCH_REQ:
                            _fetchBenchmark(&reqs[i]);
                            break;
                        case INSERT_REQ:
                            _insert(&reqs[i]);
                            break;
                        case DELETE_REQ:
                            _delete(&reqs[i]);
                            break;
                        default:
                            break;
                    }
                }
            }
            if (i == count) break;
            // calculate u1, v1, w1, and compare to u0, v0, w0
            u1 = double(displacement)/double(statReqCount);
            v1 = double(displacement_sq)/double(statReqCount-1) -
                double(displacement*displacement)/(double(statReqCount)*double(statReqCount-1));
            w1 = sqrt(((-1*log(1-confidence_prct))*2*v1)/statReqCount);
            if (abs(u0-u1) > (w0+w1)) {
                // dist has shifted with 90% probability
                numReqsSlab += epochSize;
                mode = ADAPTIVE;
            } else {
                // dist has not shifted with 90% probability
                numReqsSlab += periodicity*epochSize;
                mode = DEFAULT;
            }
        }
    }
    // Handle the remaining requests countReal - count, should be < 10
    for (; i<countReal; i++) {
        switch (reqs[i].reqType) {
            case FETCH_REQ:
                _fetchDefault(&reqs[i]);
                break;
            case INSERT_REQ:
                _insert(&reqs[i]);
                break;
            case DELETE_REQ:
                _delete(&reqs[i]);
                break;
            default:
                break;
        }
    }
    getMetricsEnd(m);
    m.displacement = displacementMetric - m.displacement;
    return m;
}

void ChainedAdaptive::rehash() {
    if (cardinality < 1.5*btree.size() && cardinality > 0.5*btree.size()) {
        return;
    }
    cout << "Rehashing triggered at numReqs " << this->numReqs << " cardinality: " << this->cardinality <<  endl;
    return;
}

void ChainedAdaptive::free() {
    btree.clear();
    accessCounter.clear();
}

inline int ChainedAdaptive::_getHashpower() {
    int hashpower = 0;
    while (pow(2, hashpower) < this->cardinality/1.5) {
        hashpower += 1;
    }
    return hashpower;
}

inline ulong ChainedAdaptive::_random() {
    ulong r = (ulong)random();
    r = r<<31;
    r = r + (ulong)random();
    return r;
}

inline void ChainedAdaptive::_fetchDefault(HashmapReq *r)
{
    ulong tmp = 0;
    auto it = btree.find(r->key, tmp);
#if _COUNT_DISP_
    displacementMetric += tmp;
#endif

    if(it == btree.end()) return;

    r->value = it->second;
    numReqs += 1;
}

inline void ChainedAdaptive::_fetchBenchmark(HashmapReq *r)
{
    ulong tmp = 0;
    auto it = btree.find(r->key, tmp);
#if _COUNT_DISP_
    displacementMetric += tmp;
#endif
    ulong disp = tmp-1;
    if(it == btree.end()) return;
    r->value = it->second;
    displacement += disp;
    displacement_sq += disp*disp;
    numReqs += 1;
    statReqCount += 1;
}

inline void ChainedAdaptive::_fetchAdaptive(HashmapReq *r)
{
    uint8_t min_access = accessCounter[r->key];
    ulong tmp = 0;
    auto min_iterator = btree.find(r->key, tmp);
    auto keep = min_iterator;
#if _COUNT_DISP_
    displacementMetric += tmp;
#endif
    if(keep == btree.end()) return;

    auto range = btree.equal_range(r->key);
    //iterate the range to look up the min
    for(auto it=range.first; it!=range.second; it++)
    {
        // std::cout<< accessCounter[it->first] <<std::endl;
        if(accessCounter[it->first] < min_access)
        {
            min_access = accessCounter[it->first];
            min_iterator = it;
        }
    }

#if _COUNT_DISP_
    displacementMetric += 1;
#endif
    r->value = keep->second;
    numReqs += 1;
    accessCounter[r->key] += 1;
    totalAccess += 1;

    if(accessCounter[r->key] > min_access)
    {
        // exchange
        std::swap(keep->first, min_iterator->first);
        std::swap(keep->second, min_iterator->second);

        // accesses
        std::swap(accessCounter[keep->first], accessCounter[min_iterator->first]);
    }
}

inline void ChainedAdaptive::_insert(HashmapReq *r) {
    btree.insert2(r->key, r->value);
    cardinality += 1;
    numReqs += 1;

    if(mode == ADAPTIVE){
        if(accessCounter.find(r->key) == accessCounter.end()) //new key
        accessCounter[r->key] = 0;}
}

inline void ChainedAdaptive::_delete(HashmapReq *r) {
    ulong tmp = 0;
    auto it = btree.find(r->key, tmp);
    if (it != btree.end()) {
        btree.erase(it);
        cardinality -= 1; 
    }
    numReqs += 1;

    if(mode == ADAPTIVE)
    {
        if(accessCounter.find(r->key) != accessCounter.end())
        {
            totalAccess -= accessCounter[r->key];
            accessCounter.erase(r->key);
        }
    }
}

// Used only while rehashing, don't use elsewhere
// Inserts at the end of the chain, not at the start
// Only while rehashing we eagerly mirror accessesDict to follow the structure of dict
// inline void ChainedAdaptive::_setFinalEnd(ulong key, ulong value) {
//     entries[entriesOffset].key = key;
//     entries[entriesOffset].value = value;
//     ulong h = _murmurHash(key);
//     KV* ptr = dict[h];
//     Acc* aptr = accessesDict[h];
//     entries[entriesOffset].next = NULL;
//     accesses[accessesOffset].next = NULL;
//     if (ptr == NULL) {
//         dict[h] = &entries[entriesOffset];
//         accessesDict[h] = &accesses[accessesOffset];
//     } else {
//         while (ptr->next != NULL) {
//             ptr = ptr->next;
//             aptr = aptr->next;
//         }
//         ptr->next = &entries[entriesOffset];
//         aptr->next = &accesses[accessesOffset];
//     }
//     entriesOffset += 1;
//     accessesOffset += 1;
// }

inline ulong ChainedAdaptive::_getTimeDiff(struct timespec startTime, struct timespec endTime) {
    return (ulong)((endTime.tv_sec - startTime.tv_sec)*1000000 +
        double(endTime.tv_nsec - startTime.tv_nsec)/1000);
}

inline void ChainedAdaptive::_resetAccesses() {
    accessCounter.clear();
    totalAccess = 0;
}

inline void ChainedAdaptive::_clearCache() {
#if _INTEL_INTRINSICS_
    for (auto& pair : accessCounter) { //clear cache line in accessCounter
        _mm_clflushopt(&pair);
    }
#else
    return;
#endif
}

#endif // VIP
