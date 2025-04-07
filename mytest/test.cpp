// test.cpp

#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <algorithm>
#include <chrono>
#include <random>
#include <utility>
#include <ctime>
#include <valgrind/callgrind.h>
// Include the stx::btree_multimap header
#include "stx/btree_multimap.h"
#include "PGM-index/include/pgm/pgm_index.hpp"
// Include the b_skiplist header
#include "b_skiplist.h"
#include "LA_skiplist.h"
// Define ulong for compatibility
typedef unsigned long ulong;

// ***************************
// B-tree Implementation using stx::btree_multimap
// ***************************
ulong _random() {
    ulong r = (ulong)random();
    r = r<<31;
    r = r + (ulong)random();
    return r;
}

void loadKeysFromCSV(const std::string& filename, std::vector<ulong>& keys, std::vector<double>& frequencies) {
    std::ifstream file(filename);
    std::string line;

    if (!file.is_open()) {
        std::cerr << "Failed to open " << filename << std::endl;
        return;
    }

    std::getline(file, line);  // Skip header line ("Key,Frequency")
    while (std::getline(file, line)) {
        std::istringstream ss(line);
        ulong key;
        double freq;

        char comma; // to consume the comma between key and frequency
        ss >> key >> comma >> freq;

        keys.push_back(key);
        frequencies.push_back(freq);
    }
    file.close();
}

void loadSearchKeys(const std::string& filename, std::vector<ulong>& search_keys) {
    std::ifstream file(filename);
    std::string line;

    if (!file.is_open()) {
        std::cerr << "Failed to open " << filename << std::endl;
        return;
    }

    while (std::getline(file, line)) {
        std::istringstream ss(line);
        ulong key;
        while (ss >> key) {
            search_keys.push_back(key);
        }
    }
    file.close();
}
class Btree {
public:
    Btree() : cardinality(0) {}

    void bulkLoad(const std::vector<ulong>& keys, const std::vector<double>& frequencies) {
        // Generate key-value pairs using the frequencies
        std::vector<std::pair<ulong, ulong>> pairs;
        for (size_t i = 0; i < keys.size(); ++i) {
            // Use the key and frequency (multiplied by 10 to simulate values)
            pairs.push_back(std::make_pair(keys[i], keys[i] )); // Example value: key * 10
        }

        std::sort(pairs.begin(), pairs.end());  // Sort the pairs
        btree.bulk_load(pairs.begin(), pairs.end());
        cardinality = keys.size();
    }

    // Fetch function
    ulong find(ulong key) {
        ulong tmp=0;
        auto it = btree.find(key, tmp);
        if(it == btree.end()) return 0;
        return it->second;
    }


    ulong cardinality;
    stx::btree_multimap<ulong, ulong> btree;
};
class LAskiplist {
    public:
        LAskiplist() : cardinality(0),la_skiplist(32) {}
    
        void bulkLoad(const std::vector<ulong>& keys, const std::vector<double>& frequencies) {
            // Prepare data for bulkload using the frequencies for prob
            std::vector<std::pair<std::pair<ulong, ulong>, double>> bulkdata;
            for (size_t i = 0; i < keys.size(); ++i) {
                double prob = frequencies[i]; // Use frequency as prob
                bulkdata.push_back(std::make_pair(std::make_pair(keys[i], keys[i]), prob));
            }
    
            std::sort(bulkdata.begin(), bulkdata.end());  // Sort the bulk data by key
            la_skiplist.bulkload(bulkdata);
            cardinality = keys.size();
        }
    
        // Fetch function
        ulong search(ulong key) {
            return la_skiplist.search(key);
        }
    
    
        ulong cardinality;
        LA::SkipList<ulong,ulong> la_skiplist;
};

// ***************************
// BskipList Implementation using b_skiplist.h
// ***************************

class BskipList {
public:
    BskipList()
        : skiplist(3, 4, 64) // Parameters as per your code
    {
        this->cardinality = 0;
        std::cout << "Data Structure: B-Skiplist " << std::endl;
    }

    void bulkLoad(const std::vector<ulong>& keys, const std::vector<double>& frequencies) {
        // Prepare data for bulkload using the frequencies for prob
        std::vector<std::pair<std::pair<ulong, ulong>, double>> bulkdata;
        for (size_t i = 0; i < keys.size(); ++i) {
            double prob = frequencies[i]; // Use frequency as prob
            bulkdata.push_back(std::make_pair(std::make_pair(keys[i], keys[i]), prob));
        }

        std::sort(bulkdata.begin(), bulkdata.end());  // Sort the bulk data by key
        skiplist.bulkload(bulkdata);
        cardinality = keys.size();
    }

    ulong search(ulong key) {
        return skiplist.search1(key);//使用learned——index搜索
    }
    ulong search0(ulong key) {
        return skiplist.search0(key);
    }

    ulong cardinality;
    BS::SkipList<ulong, ulong> skiplist;
};

// ***************************
// Main Function for Testing
// ***************************
int main() {
    using key_type = ulong;
    using value_type = ulong;

    // Read keys and frequencies from keys.csv
    std::vector<key_type> keys;
    std::vector<double> frequencies;
    loadKeysFromCSV("/root/workspace/works/LA_skiplist/outputs/keys.csv", keys, frequencies);

    // Read search keys from reqs.txt
    std::vector<key_type> search_keys;
    loadSearchKeys("/root/workspace/works/LA_skiplist/outputs/reqs.txt", search_keys);

    // Build B-tree
    Btree btree;
    btree.bulkLoad(keys, frequencies);

    // Build BskipList
    BskipList bskiplist;
    bskiplist.bulkLoad(keys, frequencies);

    LAskiplist laskiplist;
    laskiplist.bulkLoad(keys, frequencies);

    ulong num_searches=search_keys.size();
    // Test la search
    auto la_start = std::chrono::high_resolution_clock::now();

    for (const auto& key : search_keys) {
        value_type res = laskiplist.search(key);
        volatile value_type value = res; // Prevent optimization
    }

    auto la_end = std::chrono::high_resolution_clock::now();
    auto la_duration = std::chrono::duration_cast<std::chrono::milliseconds>(la_end - la_start).count();
    std::cout << "la_skiplist search time: " << la_duration << " ms" << std::endl;
    // Average time per search
    double la_avg_time = static_cast<double>(la_duration) / num_searches;
    std::cout << "Average time per search (laskiplist): " << la_avg_time << " ms" << std::endl;


    // Test B-tree search
    auto btree_start = std::chrono::high_resolution_clock::now();

    for (const auto& key : search_keys) {
        value_type res = btree.find(key);
        volatile value_type value = res; // Prevent optimization
    }

    auto btree_end = std::chrono::high_resolution_clock::now();
    auto btree_duration = std::chrono::duration_cast<std::chrono::milliseconds>(btree_end - btree_start).count();
    std::cout << "B-tree search time: " << btree_duration << " ms" << std::endl;
    // Average time per search
    double btree_avg_time = static_cast<double>(btree_duration) / num_searches;
    std::cout << "Average time per search (B-tree): " << btree_avg_time << " ms" << std::endl;

    //std::cout << "ave shift down = " << double(btree.btree.tree.shift_down_in)/num_searches << " ave shift = " <<double(btree.btree.tree.shift_in)/num_searches<< std::endl;

    
    // Test BskipList0 search
    auto bskiplist0_start = std::chrono::high_resolution_clock::now();

    for (const auto& key : search_keys) {
        value_type res = bskiplist.search0(key);
        volatile value_type value = res; // Prevent optimization
    }

    auto bskiplist0_end = std::chrono::high_resolution_clock::now();
    auto bskiplist0_duration = std::chrono::duration_cast<std::chrono::milliseconds>(bskiplist0_end - bskiplist0_start).count();
    std::cout << "BskipList search time: " << bskiplist0_duration << " ms" << std::endl;
    double bskiplist0_avg_time = static_cast<double>(bskiplist0_duration) / num_searches;
     

    std::cout << "Average time per search (BskipList without study): " << bskiplist0_avg_time << " ms" << std::endl;
   // std::cout << "ave shift down = " << double(bskiplist.skiplist.shift_down)/num_searches << " ave shift = " <<double(bskiplist.skiplist.shift)/num_searches<< std::endl;


    // Test BskipList search
    auto bskiplist_start = std::chrono::high_resolution_clock::now();

    for (const auto& key : search_keys) {
        value_type res = bskiplist.search(key);
        volatile value_type value = res; // Prevent optimization
    }

    auto bskiplist_end = std::chrono::high_resolution_clock::now();
    auto bskiplist_duration = std::chrono::duration_cast<std::chrono::milliseconds>(bskiplist_end - bskiplist_start).count();
    std::cout << "BskipList search time: " << bskiplist_duration << " ms" << std::endl;
    double bskiplist_avg_time = static_cast<double>(bskiplist_duration) / num_searches;
     

    std::cout << "Average time per search (BskipList with study): " << bskiplist_avg_time << " ms" << std::endl;
    //std::cout << "ave shift down = " << double(bskiplist.skiplist.shift_down)/num_searches << " ave shift = " <<double(bskiplist.skiplist.shift)/num_searches<< std::endl;

    // ----------------------
    // 3) 测试 PGM Index
    // ----------------------
    {
        // 先将 keys 排序给 PGM 构造使用
        std::vector<key_type> sorted_keys = keys;
        std::sort(sorted_keys.begin(), sorted_keys.end());

        // 构建 PGM 索引 (epsilon 参数可调整)
        const int epsilon = 8;
        pgm::PGMIndex<key_type, epsilon> pgmIndex(sorted_keys);
        pgmIndex.print_index_structure();
        auto pgm_start = std::chrono::high_resolution_clock::now();
        for (const auto& key : search_keys) {
            // 用 PGM 索引找到候选区间
            auto range = pgmIndex.search(key);
            auto lo_it = sorted_keys.begin() + range.lo;
            auto hi_it = sorted_keys.begin() + range.hi;

            // 再用 lower_bound 做精确定位
            auto found_it = std::lower_bound(lo_it, hi_it, key);

            volatile bool found = (found_it != hi_it && found_it != sorted_keys.end() && *found_it == key);
            (void)found; // 防止编译器优化
        }
        auto pgm_end = std::chrono::high_resolution_clock::now();
        auto pgm_duration = std::chrono::duration_cast<std::chrono::milliseconds>(pgm_end - pgm_start).count();
        std::cout << "PGMIndex search time: " << pgm_duration << " ms" << std::endl;
        double pgm_avg_time = static_cast<double>(pgm_duration) / num_searches;
        std::cout << "Average time per search (PGMIndex): " << pgm_avg_time << " ms" << std::endl;
    }
    
    return 0;
}

