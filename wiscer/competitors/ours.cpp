#ifdef OURS
#include "ours.h"

LAskiplist::LAskiplist() {
    this->cardinality = 0;
    std::cout << "Data Structure: Our Learning-Augmented Skiplist" << std::endl;
}

void LAskiplist::initHashpower(int hashpower) {
    return;
}

void LAskiplist::bulkLoad(ulong *keys, ulong num_keys) {
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
    for(int i=0;i<num_keys;i++)
    {
        skiplist.insert2(blukdata[i].first.first,blukdata[i].first.second,blukdata[i].second);
    }
    //skiplist.bulkload(blukdata);
    this->cardinality = num_keys;
    //skiplist.display_list();
}
void LAskiplist::printlist()
{
    this->skiplist.display_list();
}
Metrics LAskiplist::processRequests(HashmapReq *reqs, ulong count) {
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

void LAskiplist::rehash() {
    return;
}

void LAskiplist::free() {
    accessCounter.clear();
}

inline ulong LAskiplist::_random() {
    ulong r = (ulong)random();
    r = r<<31;
    r = r + (ulong)random();
    return r;
}

inline void LAskiplist::_fetch(HashmapReq *r) {
    ulong res =skiplist.search(r->key);
// #if _COUNT_DISP_
//     displacement += tmp;
// #endif
    if(res == NULL) return;

    r->value = res;
    //accessCounter[r->key] += 1;
    //totalAccess += 1;
    numReqs += 1;
}

inline void LAskiplist::_insert(HashmapReq *r) {
    //get the frequency
    /*float f;
    if(accessCounter.find(r->key) != accessCounter.end())
    f = 1.0*accessCounter[r->key] / totalAccess;
    else
    f = 0;*/
    float f = static_cast<float>(probs[phase][r->key]);
    
    skiplist.insert(r->key, r->value, f);
    cardinality += 1;
    numReqs += 1;
}

inline void LAskiplist::_delete(HashmapReq *r) {
    return;
}

inline ulong LAskiplist::_getTimeDiff(struct timespec startTime, struct timespec endTime) {
    return (ulong)((endTime.tv_sec - startTime.tv_sec)*1000000 +
        double(endTime.tv_nsec - startTime.tv_nsec)/1000);
}

#endif // OURS
