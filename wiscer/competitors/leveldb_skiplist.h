#define LEVELDBSKIPLIST
#ifdef LEVELDBSKIPLIST

#include <iostream>
#include "../metrics.h"
#include "../dependency/leveldb_skiplist/skiplist.h"

#define FETCH_REQ 0
#define INSERT_REQ 1
#define DELETE_REQ 2

typedef uint64_t Key;

struct Comparator {
  int operator()(const Key& a, const Key& b) const {
    if (a < b) {
      return -1;
    } else if (a > b) {
      return +1;
    } else {
      return 0;
    }
  }
};

typedef struct HashmapReq {
    ulong key;
    ulong value;
    uint8_t reqType;
} HashmapReq;

class SkipList {
private:
    long cardinality;
    Comparator cmp;
    leveldb::Arena arena;
    leveldb::SkipList<uint64_t, Comparator> leveldb_skiplist;

    // leveldb::Arena arena;
    // Comparator cmp;

    // leveldb::SkipList<uint64_t, Comparator> sl(cmp, &arena);

public:
    SkipList();
    void initHashpower(int);
    void bulkLoad(ulong*, ulong);
    Metrics processRequests(HashmapReq*, ulong);
    void rehash();
    void free();

    // helper functions
    void _fetch(HashmapReq*);
    void _insert(HashmapReq*);
    void _delete(HashmapReq*);
};

typedef SkipList Hashmap;

#endif // LEVELDBSKIPLIST
