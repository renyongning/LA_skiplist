#ifdef BTREE

#include <cstdio>
#include <cstdlib>
#include <stdlib.h>
#include <time.h>
#include <iostream>
#include <cmath>
#include <string.h>
#include <sys/time.h>
#include <sys/types.h>
#include "metrics.h"
#include <stx/btree_multimap.h>

using namespace std;

#define FETCH_REQ 0
#define INSERT_REQ 1
#define DELETE_REQ 2

typedef stx::btree_multimap<ulong, ulong> btree_type;

typedef struct HashmapReq {
    ulong key;
    ulong value;
    uint8_t reqType;
} HashmapReq;

class ChainedHashmap {
private:
    long cardinality;
    ulong numReqs = 0;
    ulong displacement;
    struct timespec startTime, endTime;

    btree_type btree;
    //SkipList<ulong, ulong> skiplist;

public:
    ChainedHashmap();
    void initHashpower(int);
    void bulkLoad(ulong*, ulong);
    Metrics processRequests(HashmapReq*, ulong);
    void free();
    void rehash();

    // helper functions
    ulong _random();
    void _fetch(HashmapReq*);
    void _insert(HashmapReq*);
    void _delete(HashmapReq*);
    ulong _getTimeDiff(struct timespec, struct timespec);
};

typedef ChainedHashmap Hashmap;

#endif // BTREE
