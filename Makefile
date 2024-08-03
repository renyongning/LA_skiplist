CC=g++ -O3 -march=native
DEFAULT=-DDEFAULT
BTREE=-DBTREE
SKIPLIST=-DSKIPLIST
SKIPLIST_BASE=-DSKIPLIST_BASE
VIP=-DVIP
BTREE_VIP=-DBTREE_VIP
STORE=-DSTORE

default: main.cpp workload.cpp workload.h metrics.cpp metrics.h chained.cpp chained.h storage_engine.cpp
	$(CC) $(DEFAULT) -o benchmark.out main.cpp

btree: main.cpp workload.cpp workload.h metrics.cpp metrics.h chained_btree.cpp chained_btree.h storage_engine.cpp
	$(CC) $(BTREE) -o benchmark.out main.cpp

skiplist: main.cpp workload.cpp workload.h metrics.cpp metrics.h chained_skiplist.cpp chained_skiplist.h storage_engine.cpp
	$(CC) $(SKIPLIST) -o benchmark.out main.cpp

skiplist_base: main.cpp workload.cpp workload.h metrics.cpp metrics.h chained_base.cpp chained_base.h storage_engine.cpp
	$(CC) $(SKIPLIST_BASE) -o benchmark.out main.cpp

vip: main.cpp workload.cpp workload.h metrics.cpp metrics.h chained_adaptive.cpp chained_adaptive.h storage_engine.cpp
	$(CC) $(VIP) -o benchmark.out main.cpp

btree_vip: main.cpp workload.cpp workload.h metrics.cpp metrics.h chained_adaptive_btree.cpp chained_adaptive_btree.h storage_engine.cpp
	$(CC) $(BTREE_VIP) -o benchmark.out main.cpp

store: main.cpp workload.cpp workload.h metrics.cpp metrics.h store_workload.cpp store_workload.h storage_engine.cpp
	$(CC) $(STORE) -o benchmark.out main.cpp

clean:
	rm -f *.o
	rm -f *.out
	rm -f *.gch
