#ifdef SKIPLIST

#include "chained_skiplist.h"

ChainedHashmap::ChainedHashmap() {
    this->cardinality = 0;
}

void ChainedHashmap::initHashpower(int hashpower) {
    return;
}

void ChainedHashmap::bulkLoad(ulong *keys, ulong num_keys) {
    vector<pair<pair<ulong,ulong>,double>> blukdata;
    for(int i=0;i<num_keys;i++)
    {
        blukdata.push_back(pair<pair<ulong,ulong>,double>(pair<ulong,ulong>(keys[i],_random()),1.0/num_keys));
        accessCounter[keys[i]] = 1;
    }
    totalAccess += num_keys;
    skiplist.bulkload(blukdata);
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
    return;
}

void ChainedHashmap::free() {
    accessCounter.clear();
}

inline ulong ChainedHashmap::_random() {
    ulong r = (ulong)random();
    r = r<<31;
    r = r + (ulong)random();
    return r;
}

inline void ChainedHashmap::_fetch(HashmapReq *r) {
    ulong res =skiplist.search(r->key);
// #if _COUNT_DISP_
//     displacement += tmp;
// #endif
    if(res == NULL) return;

    r->value = res;
    accessCounter[r->key] += 1;
    totalAccess += 1;
    numReqs += 1;
}

inline void ChainedHashmap::_insert(HashmapReq *r) {
    //get the frequency
    float f;
    if(accessCounter.find(r->key) != accessCounter.end())
    f = 1.0*accessCounter[r->key] / totalAccess;
    else
    f = 0;

    skiplist.insert(r->key, r->value, f);
    cardinality += 1;
    numReqs += 1;
}

inline void ChainedHashmap::_delete(HashmapReq *r) {
    return;
}

inline ulong ChainedHashmap::_getTimeDiff(struct timespec startTime, struct timespec endTime) {
    return (ulong)((endTime.tv_sec - startTime.tv_sec)*1000000 +
        double(endTime.tv_nsec - startTime.tv_nsec)/1000);
}

#endif // SKIPLIST
