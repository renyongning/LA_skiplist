#include "LA_skiplist.h"

int main()
{
    SkipList<uint64_t, uint64_t> sl;
    std::vector<std::pair<std::pair<uint64_t,uint64_t>,double>> vec;

    std::pair<std::pair<uint64_t,uint64_t>,double> k1({1, 111}, 0.03);
    std::pair<std::pair<uint64_t,uint64_t>,double> k2({2, 111}, 0.03);
    std::pair<std::pair<uint64_t,uint64_t>,double> k3({3, 111}, 0.03);
    std::pair<std::pair<uint64_t,uint64_t>,double> k4({4, 111}, 0.2);
    std::pair<std::pair<uint64_t,uint64_t>,double> k5({5, 111}, 0.03);
    std::pair<std::pair<uint64_t,uint64_t>,double> k6({6, 111}, 0.03);
    std::pair<std::pair<uint64_t,uint64_t>,double> k7({7, 111}, 0.5);
    std::pair<std::pair<uint64_t,uint64_t>,double> k8({8, 111}, 0.03);
    std::pair<std::pair<uint64_t,uint64_t>,double> k9({9, 111}, 0.03);
    std::pair<std::pair<uint64_t,uint64_t>,double> k10({10, 111}, 0.03);
    std::pair<std::pair<uint64_t,uint64_t>,double> k11({11, 111}, 0.03);
    std::pair<std::pair<uint64_t,uint64_t>,double> k12({12, 111}, 0.03);

    vec.push_back(k1);
    vec.push_back(k2);
    vec.push_back(k3);
    vec.push_back(k4);
    vec.push_back(k5);
    vec.push_back(k6);
    vec.push_back(k7);
    vec.push_back(k8);
    vec.push_back(k9);
    vec.push_back(k10);
    vec.push_back(k11);
    vec.push_back(k12);

    sl.bulkload(vec);

    sl.display_list();
}