#include <iostream>
#include <queue>
#include <vector>
#include <unordered_map>

#define K 1000

struct compare{
    bool operator()(const std::pair<ulong,double>& p1, const std::pair<ulong,double>& p2){
        return p1.second > p2.second;
    }
};

class minHeap{
private:
    std::priority_queue<std::pair<ulong,double>, std::vector<std::pair<ulong,double>>, compare> min_heap; // only store the frequency
    std::unordered_map<ulong, double> keyToF;

public: 
    minHeap(){}

    void add(ulong key, double f){
        if(min_heap.size() < K){
            min_heap.push(std::make_pair(key, f));
            keyToF[key] = f;
        }
        else{
            std::pair<ulong,double> tmp = min_heap.top();
            if(tmp.second < f){
                min_heap.pop();
                keyToF.erase(tmp.first);
                min_heap.push(std::make_pair(key, f));
                keyToF[key] = f;
            }
        }
    }

    double getFreq(ulong key){
        if(keyToF.find(key) != keyToF.end())
        return keyToF[key];
        
        return 0;
    }
};

