#ifdef DEFAULT
#include "chained.cpp"
#endif

#ifdef BTREE
#include "chained_btree.cpp"
#endif

#ifdef SKIPLIST
#include "chained_skiplist.cpp"
#endif

#ifdef SKIPLIST_BASE
#include "chained_base.cpp"
#endif

#ifdef VIP
#include "chained_adaptive.cpp"
#endif

#ifdef BTREE_VIP
#include "chained_adaptive_btree.cpp"
#endif

#ifdef STORE
#include "store_workload.cpp"
#endif
