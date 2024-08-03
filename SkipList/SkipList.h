//
// Created by Wang Allen on 2018/2/6.
//

#ifndef SKIPLISTPRO_SKIPLIST_H
#define SKIPLISTPRO_SKIPLIST_H

#include <cstddef>
#include <cassert>
#include <ctime>
#include<vector>
#include<random>
#include<utility>
#include "Node.h"

using namespace std;

#define DEBUG
mt19937 generator(std::random_device{}());
uniform_int_distribution<int> distribution(0, 99);
template<typename K, typename V>
class SkipList {

public:
    SkipList(int C=32) :MAX_LEVEL(C),nodeCount(0){
        header =vector<Node<K,V>>(MAX_LEVEL);
        //建立包含maxleval个头指针的数组，用于索引每一层的节点
        for(int i=MAX_LEVEL-1;i>0;i--)
        {
            header[i].right =NULL;
            header[i].down =&header[i-1];
            header[i].nodeLevel =i;
        }//初始化头指针组
        header[0].right =NULL;
        header[0].down =NULL;
        header[0].nodeLevel =0;
    }//可以调整超参数C的值

    ~SkipList() {
        freeList();
    }

    //注意:这里要声明成Node<K,V>而不是Node,否则编译器会把它当成普通的类
    Node<K, V> *search(K key) const;//查找
    bool bulkload(vector<pair<pair<K,V>,float>>& blukdata);//bulkload
    bool insert(K key, V value,float p);//插入

    //bool remove(K key, V &value);//删除

    int size() {
        return nodeCount;
    }
    void print_level(int level)
    {
        Node<K,V>* current =header[level].right;
        while (current!=NULL)
        {
            cout<<"key="<<current->key<<"--"<<"value="<<current->value<<endl;
            current =current->right;
        }
        
    }//输出第level层的数据
    void print_list()
    {
        Node<K,V>* current =header[MAX_LEVEL-1].right;
        for(int i=0;i<MAX_LEVEL;i++)
        {
            current =header[i].right;
            cout<<"IN LEVEL:"<<i<<"-----------------"<<endl;
            while (current!=NULL)
            {
                cout<<"key="<<current->key<<"--"<<"value="<<current->value<<endl;
                current =current->right;
            }
            
        }
    }

private:
    //释放表
    void freeList();

    //随机生成一个level
    int getRandomLevel(float p);

private:
    int MAX_LEVEL = 16;//最大层次
    vector<Node<K, V>> header;//头指针数组
    size_t nodeCount;//底层链表的元素数
};

template<typename K, typename V>
void SkipList<K, V>::freeList() {

    for(int i=0;i<MAX_LEVEL;i++)
    {
        Node<K,V>* current =header[i].right;
        Node<K,V>* next =NULL;
        while (current!=NULL)
        {
            next =current->right;
            delete current;
            current =next;
        }
    }//先清空所有非头结点
}

template<typename K,typename V>
bool SkipList<K,V>::bulkload(vector<pair<pair<K,V>,float>>& blukdata)
{
    nodeCount =blukdata.size();
    MAX_LEVEL =2+(int)log2(nodeCount);
    header.resize(MAX_LEVEL);
    for(int i=MAX_LEVEL-1;i>0;i--)
    {
        header[i].right =NULL;
        header[i].down =&header[i-1];
        header[i].nodeLevel =i;
    }//更新header
    header[0].down =NULL;
    Node<K,V>* new_node =NULL;
    vector<Node<K,V>*> level_current(MAX_LEVEL,NULL);//记录每一层的当前指针
    for(int i=0;i<MAX_LEVEL;i++)
    {
        level_current[i] =&header[i];
    }
    vector<Node<K,V>*> pointer_vec(MAX_LEVEL,NULL);
    for(int i=0;i<nodeCount;i++)
    {
        int target_level =getRandomLevel(blukdata[i].second);
        for(int j=0;j<=target_level;j++)
        {
            pointer_vec[j] =new Node<K,V>(blukdata[i].first.first,blukdata[i].first.second,blukdata[i].second,j);
        }//根据预测的层数得到所有地址
        for(int j =target_level;j>0;j--)
        {
            level_current[j]->right =pointer_vec[j];
            pointer_vec[j]->down =pointer_vec[j-1];
            level_current[j] =pointer_vec[j];
        }
        level_current[0]->right =pointer_vec[0];
        pointer_vec[0]->down =NULL;
        level_current[0] =pointer_vec[0];
    }//装载
    return 1;
}//装载需要先保证数据存放在有序数组中切调表中无初始数据,由于链表局部性交叉，因此对论文中伪代码做了部分修改


template<typename K, typename V>
Node<K, V> *SkipList<K, V>::search(const K key) const {
    int now_level;
    for(now_level=MAX_LEVEL-1;now_level>=0&&header[now_level].right==NULL;now_level--)
    {

    }
    if(now_level<0) return NULL;//表明调表为空
    Node<K,V>* pre = const_cast<Node<K,V>*>(&header[now_level]);//从第一个节点开始
    for (int i = now_level; i >= 0; --i) {
        while (pre->right!=NULL&&pre->right->key<=key)
        {
            pre =pre->right;
        }
        if(pre->key==key) return pre;
        pre =pre->down;
    }
    return NULL;
};

template<typename K, typename V>
bool SkipList<K, V>::insert(K key, V value,float p) {
    this->nodeCount++;
    if((int)log2(nodeCount)>MAX_LEVEL)
    {
        MAX_LEVEL =(int)log2(nodeCount);
        header.resize(MAX_LEVEL);
        for(int i=MAX_LEVEL-1;i>0;i--)
        {
            header[i].right =NULL;
            header[i].down =&header[i-1];
            header[i].nodeLevel =i;
        }
    }//如果目前所需要的层数超过了最大层数则需要进行扩张层次
    Node<K, V> *update[MAX_LEVEL];//记录搜索路径
    Node<K, V> *node = &header[MAX_LEVEL-1];//头指针位置

    for (int i = MAX_LEVEL-1; i >= 0; --i) {
        while (node->right!=NULL&& (node->right)->key < key) {
            node = node->right;
        }
        update[i] = node;
        node =node->down;
    }
    //如果key已存在，则直接返回false
    if (update[0]->key == key) {
        return false;
    }

    int nodeLevel = getRandomLevel(p);
    //创建新结点
    vector<Node<K,V>*> newnode(MAX_LEVEL);
    for(int i=0;i<=nodeLevel;i++)
    {
        newnode[i] =new Node<K,V>(key,value,p,i);
    }
    //调整forward指针
    for (int i = nodeLevel; i >0; --i) {
        node = update[i];
        newnode[i]->right =node->right;
        newnode[i]->down =newnode[i-1];
        node->right =newnode[i];
    }
    newnode[0]->right =update[0]->right;
    newnode[0]->down =NULL;
    update[0]->right =newnode[0];
    return true;
};
/*
template<typename K, typename V>
bool SkipList<K, V>::remove(K key, V &value) {
    Node<K, V> *update[MAX_LEVEL];
    Node<K, V> *node = header;
    for (int i = level; i >= 0; --i) {
        while ((node->forward[i])->key < key) {
            node = node->forward[i];
        }
        update[i] = node;
    }
    node = node->forward[0];
    //如果结点不存在就返回false
    if (node->key != key) {
        return false;
    }

    value = node->value;
    for (int i = 0; i <= level; ++i) {
        if (update[i]->forward[i] != node) {
            break;
        }
        update[i]->forward[i] = node->forward[i];
    }

    //释放结点
    delete node;

    //更新level的值，因为有可能在移除一个结点之后，level值会发生变化，及时移除可避免造成空间浪费
    while (level > 0 && header->forward[level] == footer) {
        --level;
    }

    --nodeCount;

#ifdef DEBUG
    dumpAllNodes();
#endif

    return true;
};
*/
template<typename K, typename V>
int SkipList<K, V>::getRandomLevel(float p) {
    int level = 0;
    while ((distribution(generator)%2||(p>=(((uint64_t)1>>level)-1)/float(nodeCount))) && level < MAX_LEVEL-1)
        level += 1;
    return level;
}
#endif //SKIPLISTPRO_SKIPLIST_H
