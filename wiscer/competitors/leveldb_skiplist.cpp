#define LEVELDBSKIPLIST
#ifdef LEVELDBSKIPLIST

#include "leveldb_skiplist.h"

SkipList::SkipList(): leveldb_skiplist(cmp, &arena) {
    this->cardinality = 0;
    // Comparator cmp;
    // leveldb::Arena arena;
    // leveldb::SkipList<uint64_t, Comparator> leveldb_skiplist(cmp, &arena);
    std::cout << "Data Structure: LevelDB Skiplist" << std::endl;
}

void SkipList::initHashpower(int hashpower) {
    return;
}

void SkipList::bulkLoad(ulong *keys, ulong num_keys) {
    // 对keys进行排序
    std::sort(keys, keys + num_keys);
    for (ulong i=0; i<num_keys; i++) {
        leveldb_skiplist.Insert(keys[i]);
    }
    this->cardinality = num_keys;
}

Metrics SkipList::processRequests(HashmapReq *reqs, ulong count) {
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

void SkipList::rehash() {
    return;
}

void SkipList::free() {
    return;
}

inline void SkipList::_fetch(HashmapReq *r) {
    auto ret = leveldb_skiplist.Contains(r->key);
    if (ret == 0)
        std::cout << "fetch err!" << std::endl;
    return;
}

inline void SkipList::_insert(HashmapReq *r) {
    std::cout << "LevelDB Skiplist 暂时不支持测插入和删除" << std::endl;
    return;
}

inline void SkipList::_delete(HashmapReq *r) {
    std::cout << "LevelDB Skiplist 暂时不支持测插入和删除" << std::endl;
    return;
}

#endif // LEVELDBSKIPLIST
