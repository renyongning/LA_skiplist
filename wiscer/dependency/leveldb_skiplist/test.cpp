#include <iostream>
#include "skiplist.h"

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

int main()
{
    leveldb::Arena arena;
    Comparator cmp;

    leveldb::SkipList<uint64_t, Comparator> sl(cmp, &arena);

    for (uint64_t i = 0; i < 100000; i += 4)
    {
        sl.Insert(i);
    }

    std::cout << sl.Contains(40000) << std::endl;
    std::cout << sl.Contains(50004) << std::endl;
    std::cout << sl.Contains(10008) << std::endl;
    std::cout << sl.Contains(40001) << std::endl;
    std::cout << sl.Contains(40002) << std::endl;
    std::cout << sl.Contains(40003) << std::endl;

    return 0;
}