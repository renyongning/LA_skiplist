// easytest.cpp
//对 bulkload insert delete search的简单测试
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

// Include the b_skiplist header
#include "b_skiplist.h"
// Define ulong for compatibility
typedef unsigned long ulong;

using namespace std;
int main()
{
    int num=20;
    int num2=5;
    SkipList <ulong,ulong> skiplist(32, 31, 2); //一个普通bskiplist
    ulong * keys=(ulong*)malloc(sizeof(ulong)*num);
    for (int i=0;i<num;i++)
    {
        keys[i]=(i+1)*5;
    }

    vector<pair<pair<ulong,ulong>,double>> blukdata;
    for(int i=0;i<num;i++)
    {

        blukdata.push_back(pair<pair<ulong,ulong>,double>(pair<ulong,ulong>(keys[i],i),0));

    }

    skiplist.bulkload(blukdata);
    for(int i=0;i<num2;i++)
    {
        skiplist.insert(5*i+3,i,0);
    }
    skiplist.insert(37,37,0.5);
    for(int i=0;i<num2;i++)
    {
        skiplist.search2(5*i+3);
    }
    for(int i=0;i<num;i++)
    {
        skiplist.search2((i+1)*5);
    }
    skiplist.display_list();
    skiplist.display_blocks();
    skiplist.delete_element(ulong(37));
    skiplist.delete_element(ulong(35));
    skiplist.display_list();
    skiplist.display_blocks();
    return 0;

}
