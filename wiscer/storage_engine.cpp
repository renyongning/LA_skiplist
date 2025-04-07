#ifdef CHAINEDHASH
#include "chainedhash.cpp"
#endif

#ifdef VIPHASH
#include "viphash.cpp"
#endif

#ifdef STORE
#include "store_workload.cpp"
#endif

#ifdef STDMAP
#include "stdmap.cpp"
#endif

#ifdef SKIPLIST
#include "skiplist.cpp"
#endif

#ifdef BSKIPLIST
#include "bskiplist.cpp"
#endif

#ifdef OURS
#include "ours.cpp"
#endif

#ifdef LEVELDBSKIPLIST
#include "leveldb_skiplist.cpp"
#endif

#ifdef BTREE
#include "btree.cpp"
#endif

#ifdef ROBUSTSL
#include "robustsl.cpp"
#endif

#ifdef DNROBUSTSL
#include "dynamic_robustsl.cpp"
#endif