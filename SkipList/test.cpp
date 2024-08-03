#include <iostream>
#include <random>
#include <time.h>
using namespace std;
int main()
{

    srand(time(NULL));
    for (int j = 0; j < 5; j++)
    {
        cout <<((uint64_t)1>>j) << endl;
    }
}