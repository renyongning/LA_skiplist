#define DNROBUSTSL
#ifdef DNROBUSTSL
#include "dynamic_robustsl.h"

RobustSL::RobustSL() {
    this->cardinality = 0;
    std::cout << "Data Structure: Dynamic RobustSL" << std::endl;
}

void RobustSL::initHashpower(int hashpower) {
    return;
}

void RobustSL::bulkLoad(ulong *keys, ulong num_keys) {
    // 对keys进行排序
    std::sort(keys, keys + num_keys);

    // skiplist.initialize(num_keys);
    for(int i=0;i<num_keys;i++)
    {
        skiplist.insert_element(keys[i], _random());
    }
;
    this->cardinality = num_keys;

    // skiplist.display_list_loose_style();
}

Metrics RobustSL::processRequests(HashmapReq *reqs, ulong count) {
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

void RobustSL::rehash() {
    return;
}

void RobustSL::free() {
    accessCounter.clear();
}

inline ulong RobustSL::_random() {
    ulong r = (ulong)random();
    r = r<<31;
    r = r + (ulong)random();
    return r;
}

inline void RobustSL::_fetch(HashmapReq *r) {

    auto ans = skiplist.search_element(r->key);

    numReqs += 1;
}

inline void RobustSL::_insert(HashmapReq *r) {

    skiplist.insert_element(r->key, r->value);

    return;
}

inline void RobustSL::_delete(HashmapReq *r) {
    return;
}

inline ulong RobustSL::_getTimeDiff(struct timespec startTime, struct timespec endTime) {
    return (ulong)((endTime.tv_sec - startTime.tv_sec)*1000000 +
        double(endTime.tv_nsec - startTime.tv_nsec)/1000);
}

#endif // DNROBUSTSL
