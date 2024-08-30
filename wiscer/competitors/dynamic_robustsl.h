#define DNROBUSTSL
#ifdef DNROBUSTSL

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
#include "../dependency/DynamicRobustSL.h"
#include <unordered_map>
#include <vector>
#include <algorithm>
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

class RobustSL {
private:
    long cardinality;
    ulong numReqs = 0;
    ulong displacement;
    struct timespec startTime, endTime;
    SkipList<ulong, ulong> skiplist;
    int phase=0;
   
public:
    RobustSL();
    void initHashpower(int);
    void bulkLoad(ulong*, ulong);
    Metrics processRequests(HashmapReq*, ulong);
    void rehash();
    void free();

    void show()
    {
        skiplist.display_list();
        skiplist.traverse_cll();
    }

    // helper functions
    ulong _random();
    void _fetch(HashmapReq*);
    void _insert(HashmapReq*);
    void _delete(HashmapReq*);
    ulong _getTimeDiff(struct timespec, struct timespec);
};

typedef RobustSL Hashmap;

#endif // DNROBUSTSL