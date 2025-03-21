#ifdef SKIPLIST_BASE

#include "chained_base.h"
#include<unordered_map>
ChainedHashmap::ChainedHashmap():skiplist(32) {
    this->cardinality = 0;
}

void ChainedHashmap::initHashpower(int hashpower) {
    return;
}

void ChainedHashmap::bulkLoad(ulong *keys, ulong num_keys) {
    vector<pair<ulong,ulong>> blukdata;
    for(int i=0;i<num_keys;i++)
    {
        blukdata.push_back(pair<ulong,ulong>(keys[i],_random()));
        //accessCounter[keys[i]] = 1;
    }
    //totalAccess += num_keys;
    //skiplist.bulkload(blukdata);
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
    //accessCounter.clear();
}

inline ulong ChainedHashmap::_random() {
    ulong r = (ulong)random();
    r = r<<31;
    r = r + (ulong)random();
    return r;
}

inline void ChainedHashmap::_fetch(HashmapReq *r) {
    ulong result =skiplist.search_element(r->key);
// #if _COUNT_DISP_
//     displacement += tmp;
// #endif
    if(result == NULL) return;

    r->value = result;
    //accessCounter[r->key] += 1;
    //totalAccess += 1;
    numReqs += 1;
}

inline void ChainedHashmap::_insert(HashmapReq *r) {
    //get the frequency
    // float f;
    // if(accessCounter.find(r->key) != accessCounter.end())
    // f = 1.0*accessCounter[r->key] / totalAccess;
    // else
    // f = 0;

    skiplist.insert_element(r->key, r->value);
    cardinality += 1;
    numReqs += 1;
}

inline void ChainedHashmap::_delete(HashmapReq *r) {
    ulong key = r->key;
    skiplist.delete_element(key);
    cardinality -= 1;
    numReqs += 1;
}

inline ulong ChainedHashmap::_getTimeDiff(struct timespec startTime, struct timespec endTime) {
    return (ulong)((endTime.tv_sec - startTime.tv_sec)*1000000 +
        double(endTime.tv_nsec - startTime.tv_nsec)/1000);
}

#endif // SKIPLIST
