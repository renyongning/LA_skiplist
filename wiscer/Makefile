CC=g++ -O3 -march=native -std=c++17
USUAL=-w -Icompetitors -o benchmark.out main.cpp

chainedhash: main.cpp workload.cpp workload.h metrics.cpp metrics.h competitors/chainedhash.cpp competitors/chainedhash.h storage_engine.cpp
	$(CC) -DCHAINEDHASH $(USUAL)

viphash: main.cpp workload.cpp workload.h metrics.cpp metrics.h competitors/viphash.cpp competitors/viphash.h storage_engine.cpp
	$(CC) -DVIPHASH $(USUAL)

store: main.cpp workload.cpp workload.h metrics.cpp metrics.h competitors/store_workload.cpp competitors/store_workload.h storage_engine.cpp
	$(CC) -DSTORE $(USUAL)

stdmap: main.cpp workload.cpp workload.h metrics.cpp metrics.h competitors/stdmap.cpp competitors/stdmap.h storage_engine.cpp
	$(CC) -DSTDMAP $(USUAL)

skiplist: main.cpp workload.cpp workload.h metrics.cpp metrics.h competitors/skiplist.cpp competitors/skiplist.h storage_engine.cpp
	$(CC) -DSKIPLIST $(USUAL)

bskiplist: main.cpp workload.cpp workload.h metrics.cpp metrics.h competitors/bskiplist.cpp competitors/bskiplist.h storage_engine.cpp
	$(CC) -DBSKIPLIST $(USUAL)

ours: main.cpp workload.cpp workload.h metrics.cpp metrics.h competitors/ours.cpp competitors/ours.h storage_engine.cpp
	$(CC) -DOURS $(USUAL)

leveldb_skiplist: main.cpp workload.cpp workload.h metrics.cpp metrics.h competitors/leveldb_skiplist.cpp competitors/leveldb_skiplist.h storage_engine.cpp
	$(CC) -DLEVELDBSKIPLIST $(USUAL) dependency/leveldb_skiplist/arena.cc

btree: main.cpp workload.cpp workload.h metrics.cpp metrics.h competitors/btree.cpp competitors/btree.h storage_engine.cpp
	$(CC) -DBTREE $(USUAL)

robustsl: main.cpp workload.cpp workload.h metrics.cpp metrics.h competitors/robustsl.cpp competitors/robustsl.h storage_engine.cpp
	$(CC) -DROBUSTSL $(USUAL)

dnrobustsl: main.cpp workload.cpp workload.h metrics.cpp metrics.h competitors/dynamic_robustsl.cpp competitors/dynamic_robustsl.h storage_engine.cpp
	$(CC) -DDNROBUSTSL $(USUAL)

new: main.cpp workload.cpp workload.h metrics.cpp metrics.h competitors/bskiplist_pla.cpp competitors/bskiplist_pla.h storage_engine.cpp
	$(CC) -DBSKIPLIST_PLA $(USUAL)

new_debug:
	g++ -g -O0 -march=native -std=c++17 -DDEBUG -DBSKIPLIST_PLA -Icompetitors -o debug main.cpp

clean:
	rm -f *.o
	rm -f *.out
	rm -f *.gch
