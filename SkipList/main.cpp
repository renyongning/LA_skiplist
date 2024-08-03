#include <iostream>
//#include "Skiplist2.h"
#include "LA_skiplist.h"
#include<vector>
#include<utility>
using namespace std;

int main() {
    SkipList<int,int> s;
    vector<pair<pair<int,int>,double>> blukdata;
    for(int i=0;i<1000;i++)
    {
        blukdata.push_back(pair<pair<int,int>,double>(pair<int,int>(i,i),i/1000.0));
        //s.insert(i,i,1.0/10000);
    }
    s.bulkload(blukdata);
    for(int i=1001;i<2000;i++)
    {
        //s.insert(i,i,1.0/1000);
    }
    s.display_list();
    //for(int i=0;i<1001;i++)
    //{
        //int res =s.search(i);
        //if(res)
            //cout<<"value:"<<res<<endl;
    //}
    cout<<"finish";
}