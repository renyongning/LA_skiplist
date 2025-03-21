#include <iostream>
#include<cmath>
#include<cstring>
#include "LA_skiplist.h"
#include<vector>
#include<utility>
#include<ctime>
using namespace std;
static int initialsize=1000;
static double alaph=1.1;
#define SHOW 1
#define SEARCH 0
#define BULKLOAD 0
#define INSERT  1
int main(int argc,char *argv[]) {
    SkipList<int,int> s;
    vector<pair<pair<int,int>,double>> blukdata(initialsize);
    double cumsum =0;
    for(int i=0;i<initialsize;i++)
    {
        blukdata[i] = pair<pair<int,int>,double>(pair<int,int>(i,i),1/pow(initialsize-i,alaph));
        cumsum+=blukdata[i].second;
    }
    for(int i=0;i<initialsize;i++)
    {
        blukdata[i].second /=cumsum;
    }
    if(INSERT)
    {
        for(int i=0;i<initialsize;i++)
        {
            s.insert2(blukdata[i].first.first,blukdata[i].first.second,blukdata[i].second);
        }
    }
    if(BULKLOAD)
        s.bulkload(blukdata);
    if(SHOW)
        s.display_list();
    if(SEARCH)
    {
        for(int i=0;i<initialsize;i++)
        {
            int res =s.search(i);
            if(res)
                cout<<"value:"<<res<<endl;
        }
    }
    cout<<"finish"<<endl;

}