#ifdef BSKIPLIST
#include "bskiplist.h"
#include <unordered_map>


BskipList::BskipList()
    : skiplist(3,4, 64)  // 分别为 maxlevel；key_of_thresholds; key_of_getlevel; 3 4 64 是目前测出来较好的参数
{
    this->cardinality = 0;
    std::cout << "Data Structure: B-Skiplist " << std::endl;
}


void BskipList::initHashpower(int hashpower) {
    return;
}
void BskipList::bulkLoad(ulong *keys, ulong num_keys) {
    // 对keys进行排序
    std::sort(keys, keys + num_keys);
    vector<pair<pair<ulong,ulong>,double>> blukdata;
    for(int i=0;i<num_keys;i++)
    {
        //现在的版本在bulkload就传入了已知的键的频率
        blukdata.push_back(pair<pair<ulong,ulong>,double>(pair<ulong,ulong>(keys[i],_random()),probs[phase][keys[i]]));
        
        //原来的版本
        //blukdata.push_back(pair<pair<ulong,ulong>,double>(pair<ulong,ulong>(keys[i],_random()),1/num_keys));
        
    }

    skiplist.bulkload(blukdata);
    this->cardinality = num_keys;
}

Metrics BskipList::processRequests(HashmapReq *reqs, ulong count) {
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

void BskipList::rehash() {
    return;
}

void BskipList::free() {
    accessCounter.clear();
}

inline ulong BskipList::_random() {
    ulong r = (ulong)random();
    r = r<<31;
    r = r + (ulong)random();
    return r;
}

inline void BskipList::_fetch(HashmapReq *r) {
    ulong res =skiplist.search0(r->key);
    if(res == NULL) return;
    r->value = res;
    numReqs += 1;
}

inline void BskipList::_insert(HashmapReq *r) {
    //get the frequency
    // float f;
    // if(accessCounter.find(r->key) != accessCounter.end())
    // f = 1.0*accessCounter[r->key] / totalAccess;
    // else
    // f = 0;
    //float f = static_cast<float>(probs[phase][r->key]);
    float f = static_cast<float>(probs[phase][r->key]);
    
    skiplist.insert(r->key, r->value, f);
    cardinality += 1;
    numReqs += 1;
}

inline void BskipList::_delete(HashmapReq *r) {
    return;
}

inline ulong BskipList::_getTimeDiff(struct timespec startTime, struct timespec endTime) {
    return (ulong)((endTime.tv_sec - startTime.tv_sec)*1000000 +
        double(endTime.tv_nsec - startTime.tv_nsec)/1000);
}

#endif // SKIPLIST
