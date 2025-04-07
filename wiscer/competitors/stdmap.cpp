#ifdef STDMAP

#include "stdmap.h"

StdMap::StdMap() {
    this->cardinality = 0;
    std::cout << "Data Structure: C++ std::map (Red-black tree)" << std::endl;
}

void StdMap::initHashpower(int hashpower) {
    return;
}

void StdMap::bulkLoad(ulong *keys, ulong num_keys) {

    this->cardinality = num_keys;

    for (ulong i = 0; i < num_keys; i ++)
    {
        this->m[keys[i]] = keys[i];
    }
}

Metrics StdMap::processRequests(HashmapReq *reqs, ulong count) {
    Metrics m;
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
    return m;
}

void StdMap::rehash() {
    return;
}

void StdMap::free() {
    this->m.clear();
}

inline void StdMap::_fetch(HashmapReq *r) {
    r->value = m[r->key];
    return;
}

inline void StdMap::_insert(HashmapReq *r) {
    this->m.insert({r->key, r->value});
}

inline void StdMap::_delete(HashmapReq *r) {
    this->m.erase(r->key);
}

#endif // STDMAP
