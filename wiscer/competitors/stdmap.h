#ifdef STDMAP

#include <map>
#include "../metrics.h"

using namespace std;

#define FETCH_REQ 0
#define INSERT_REQ 1
#define DELETE_REQ 2

typedef struct HashmapReq {
    ulong key;
    ulong value;
    uint8_t reqType;
} HashmapReq;

class StdMap {
protected:
    std::map<ulong, ulong> m;
    long cardinality;

public:
    StdMap();
    void initHashpower(int);
    void bulkLoad(ulong*, ulong);
    Metrics processRequests(HashmapReq*, ulong);
    void rehash();
    void free();

    void _fetch(HashmapReq*);
    void _insert(HashmapReq*);
    void _delete(HashmapReq*);
};

typedef StdMap Hashmap;

#endif // STDMAP

