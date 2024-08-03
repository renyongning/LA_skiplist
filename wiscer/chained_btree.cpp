#ifdef BTREE

#include "chained_btree.h"
#include<unordered_map>
ChainedHashmap::ChainedHashmap() {
    this->cardinality = 0;
}

void ChainedHashmap::initHashpower(int hashpower) {
    return;
}


void ChainedHashmap::bulkLoad(ulong *keys, ulong num_keys) {
    //generate key-value pairs
    std::vector<std::pair<ulong, ulong>> pairs;
    for(ulong i=0; i<num_keys; i++)
    {
        pairs.push_back(std::make_pair(keys[i], _random()));
    }
    
    btree.bulk_load(pairs.begin(), pairs.end());
    this->cardinality = num_keys;
}

Metrics ChainedHashmap::processRequests(HashmapReq *reqs, ulong count) {
    Metrics m;
    m.displacement = displacement;
    getMetricsStart(m);
    for (ulong i=0; i<count; i++) {
        switch (reqs[i].reqType) {
            case FETCH_REQ:
                _fetch(&reqs[i]);
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
    m.displacement = displacement - m.displacement;
    return m;
}

void ChainedHashmap::rehash() {
    if (cardinality < 1.5*btree.size() && cardinality > 0.5*btree.size()) {
        return;
    }
    return;
}

void ChainedHashmap::free() {
    btree.clear();
}

inline ulong ChainedHashmap::_random() {
    ulong r = (ulong)random();
    r = r<<31;
    r = r + (ulong)random();
    return r;
}

inline void ChainedHashmap::_fetch(HashmapReq *r)
{
    ulong tmp=0;
    auto it = btree.find(r->key, tmp);
#if _COUNT_DISP_
    displacement += tmp;
#endif
    if(it == btree.end()) return;

    r->value = it->second;
    numReqs += 1;
}

inline void ChainedHashmap::_insert(HashmapReq *r) {
    btree.insert2(r->key, r->value);
    cardinality += 1;
    numReqs += 1;
}

inline void ChainedHashmap::_delete(HashmapReq *r) {
    ulong tmp = 0;
    auto it = btree.find(r->key, tmp);
    if (it != btree.end()) {
        btree.erase(it);
        cardinality -= 1; 
    }
    numReqs += 1;
}

inline ulong ChainedHashmap::_getTimeDiff(struct timespec startTime, struct timespec endTime) {
    return (ulong)((endTime.tv_sec - startTime.tv_sec)*1000000 +
        double(endTime.tv_nsec - startTime.tv_nsec)/1000);
}

#endif // BTREE
