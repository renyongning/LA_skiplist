#include <iostream>
#include <random>
#include <time.h>
using namespace std;
template<typename K,typename V>
class test;
template<typename K,typename V>
class node
{
private:
  int maxlevel =64;
  friend class test<K,V>;
};
template<typename K,typename V>
class test
{
public:
    int level;
public:
    test(){this->level =test::maxlevel};
};
int main()
{
   test<int,int> a;
    cout<<a.level;    

}