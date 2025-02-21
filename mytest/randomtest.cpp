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

// Include the b_skiplist header
#include "b_skiplist.h"

// Define ulong for compatibility
typedef unsigned long ulong;
ulong _random() {
    ulong r = (ulong)random();
    r = r<<31;
    r = r + (ulong)random();
    return r;
}
class Btree {
public:
    Btree() : cardinality(0) {}

    void bulkLoad(ulong* keys, ulong num_keys) {
        // Generate key-value pairs
        std::sort(keys, keys + num_keys);
        std::vector<std::pair<ulong, ulong>> pairs;
        for (ulong i = 0; i < num_keys; ++i) {
            pairs.push_back(std::make_pair(keys[i], keys[i] * 10)); // Example value
        }

        btree.bulk_load(pairs.begin(), pairs.end());
        cardinality = num_keys;
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

// ***************************
// BskipList Implementation using b_skiplist.h
// ***************************

class BskipList {
public:
    BskipList()
        : skiplist(4, 31, 16) // Parameters as per your code
    {
        this->cardinality = 0;
        std::cout << "Data Structure: B-Skiplist " << std::endl;
    }

    void bulkLoad(ulong* keys, ulong num_keys) {
        // Sort keys
        std::sort(keys, keys + num_keys);

        // Prepare data for bulkload
        std::vector<std::pair<std::pair<ulong, ulong>, double>> bulkdata;
        for (ulong i = 0; i < num_keys; ++i) {
            // Use uniform probability for simplicity
            double prob = 0;
            bulkdata.push_back(std::make_pair(std::make_pair(keys[i], keys[i] * 10), prob));
        }

        skiplist.bulkload(bulkdata);
        this->cardinality = num_keys;
    }

    ulong search(ulong key) {
        return skiplist.search0(key);
    }

    ulong cardinality;
    SkipList<ulong, ulong> skiplist;
};

// ***************************
// Main Function for Testing
// ***************************
int main() {
    using key_type = ulong;
    using value_type = ulong;

    const size_t num_keys = 1048576;     // 1e6 keys
    const size_t num_searches = 50000000; // Adjust as needed

    // Generate keys
    std::vector<key_type> keys(num_keys);
    for (size_t i = 0; i < num_keys; ++i) {
        keys[i] = _random();
        //keys[i] = i;
        
    }

    // Build B-tree
    Btree btree;
    btree.bulkLoad(keys.data(), num_keys);

    // Build BskipList
    BskipList bskiplist;
    bskiplist.bulkLoad(keys.data(), num_keys);
    //bskiplist.skiplist.display_node_counts();
    // Generate random search keys
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<key_type> dist(0, static_cast<key_type>(num_keys - 1));

    std::vector<key_type> search_keys(num_searches);
    for (size_t i = 0; i < num_searches; ++i) {
        search_keys[i] = keys[dist(gen)];
    }

    // Test B-tree search
    auto btree_start = std::chrono::high_resolution_clock::now();

    for (const auto& key : search_keys) {
        value_type res = btree.find(key);
        volatile value_type value = res; 
    }

    auto btree_end = std::chrono::high_resolution_clock::now();
    auto btree_duration = std::chrono::duration_cast<std::chrono::milliseconds>(btree_end - btree_start).count();
    std::cout << "B-tree search time: " << btree_duration << " ms" << std::endl;
    // Average time per search
    double btree_avg_time = static_cast<double>(btree_duration) / num_searches;
    std::cout << "Average time per search (B-tree): " << btree_avg_time << " ms" << std::endl;

    std::cout << "ave shift down = " << double(btree.btree.tree.shift_down_in)/num_searches << " ave shift = " <<double(btree.btree.tree.shift_in)/num_searches<< std::endl;
    
    // Test BskipList search
    auto bskiplist_start = std::chrono::high_resolution_clock::now();

    for (const auto& key : search_keys) {
        value_type res = bskiplist.search(key);
        volatile value_type value = res; 
    }

    auto bskiplist_end = std::chrono::high_resolution_clock::now();
    auto bskiplist_duration = std::chrono::duration_cast<std::chrono::milliseconds>(bskiplist_end - bskiplist_start).count();
    std::cout << "BskipList search time: " << bskiplist_duration << " ms" << std::endl;
    double bskiplist_avg_time = static_cast<double>(bskiplist_duration) / num_searches;
     

    std::cout << "Average time per search (BskipList): " << bskiplist_avg_time << " ms" << std::endl;
    std::cout << "ave shift down = " << double(bskiplist.skiplist.shift_down)/num_searches << " ave shift = " <<double(bskiplist.skiplist.shift)/num_searches<< std::endl;

    
    
    return 0;
}