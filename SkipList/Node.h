//
// Created by Wang Allen on 2018/2/5.
//

#ifndef SKIPLISTPRO_NODE_H
#define SKIPLISTPRO_NODE_H

//forward declaration
template<typename K, typename V>
class SkipList;

template<typename K, typename V>//键与值的类型
class Node {

    friend class SkipList<K, V>;

public:

    Node() {}

    Node(K k, V v,float p,int nodeLevel,Node<K,V>* right=NULL,Node<K,V>*down =NULL);

    K getKey() const;

    V getValue() const;

private:
    K key;
    V value;
    float p;
    Node<K, V> *right;//查找右侧节点
    Node<K,V>* down;//查找下方节点
    int nodeLevel;//所在的层次0-(maxlevel-1)
};

template<typename K, typename V>
Node<K, V>::Node(const K k, const V v,float p,int nodeLevel,Node<K,V>* right,Node<K,V>*down) {
    key = k;
    value = v;
    this->p =p;
    this->nodeLevel =nodeLevel;
    this->right =right;
    this->down =down;
};

template<typename K, typename V>
K Node<K, V>::getKey() const {
    return key;
}

template<typename K, typename V>
V Node<K, V>::getValue() const {
    return value;
}

#endif