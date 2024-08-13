#include <iostream>
#include<cmath>
#include<cstring>
#include "LA_skiplist.h"
#include<vector>
#include<utility>
using namespace std;
static int initialsize=1000;
static double alaph=1.1;
#define SHOW 1
#define SEARCH 1
int main(int argc,char *argv[]) {
    SkipList<int,int> s;
    vector<pair<pair<int,int>,double>> blukdata(initialsize);
    double cumsum =0;
    for(int i=0;i<initialsize;i++)
    {
        blukdata[i] = pair<pair<int,int>,double>(pair<int,int>(i,i),1/pow(i+1,alaph));
        cumsum+=blukdata[i].second;
    }
    for(int i=0;i<initialsize;i++)
    {
        blukdata[i].second /=cumsum;
    }
    s.bulkload(blukdata);
    if(SHOW)
        s.display_list();
    if(SEARCH)
    {
        for(int i=0;i<1000;i++)
        {
            int res =s.search(i);
            if(res)
                cout<<"value:"<<res<<endl;
        }
    }
    cout<<"finish";
}