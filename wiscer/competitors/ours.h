#ifdef OURS

#include <cstdio>
#include <cstdlib>
#include <stdlib.h>
#include <time.h>
#include <iostream>
#include <cmath>
#include <string.h>
#include <sys/time.h>
#include <sys/types.h>
#include "../metrics.h"
#include "../dependency/LA_skiplist.h"
#include <unordered_map>
extern std::unordered_map<ulong, ulong> accessCounter; 
extern ulong totalAccess; 
extern std::vector<std::unordered_map<ulong, double>> probs;
extern std::vector<ulong> changeTimes; 
extern std::vector<std::vector<std::pair<ulong, double>>> sortedProbs;
using namespace std;

#define FETCH_REQ 0
#define INSERT_REQ 1
#define DELETE_REQ 2

typedef struct HashmapReq {
    ulong key;
    ulong value;
    uint8_t reqType;
} HashmapReq;

class LAskiplist {
private:
    long cardinality;
    ulong numReqs = 0;
    ulong displacement;
    struct timespec startTime, endTime;
    SkipList<ulong, ulong> skiplist;
    int phase=0;
   
public:
    LAskiplist();
    void initHashpower(int);
    void bulkLoad(ulong*, ulong);
    Metrics processRequests(HashmapReq*, ulong);
    void rehash();
    void free();

    // helper functions
    ulong _random();
    void _fetch(HashmapReq*);
    void _insert(HashmapReq*);
    void _delete(HashmapReq*);
    ulong _getTimeDiff(struct timespec, struct timespec);
};

typedef LAskiplist Hashmap;

#endif // OURS
