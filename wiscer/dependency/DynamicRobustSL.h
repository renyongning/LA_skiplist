// 基于 https://github.com/youngyangyang04/Skiplist-CPP

#include <iostream> 
#include <cstdlib>
#include <cmath>
#include <cstring>
#include <mutex>
#include <fstream>
#include <random>
#include <vector>
#include <algorithm>

#define CLASS_LIMIT 16
#define RANDOM_ENGINE_SEED 5489
#define CEILING 32

#define STORE_FILE "store/dumpFile"

std::mutex mtx;     // mutex for critical section
std::string delimiter = ":";

//Class template to implement node
template<typename K, typename V> 
struct Node 
{
    Node(const K k, const V v, int length, int d): 
        key(k), 
        value(v), 
        depth(d),
        node_class(0),
        counter(0), // 即不把插入看作一次访问
        impression(0),
        forward(length, nullptr), // 用空指针初始化forward向量
        next(nullptr),
        prev(nullptr)
    {}

    ~Node() {}

    K key;
    V value;
    
    // 从天花板到该节点有指针的level的距离
    int depth;

    // 节点的类别
    int node_class;

    // 计数器
    unsigned counter;

    // 计数链表当中prev->counter的印象
    unsigned impression;

    // forward向量当中的指针是倒排的：forward[0]存储指针塔当中最高的指针
    std::vector<Node<K, V>*> forward;

    // 计数链表当中的指针
    Node<K, V>* next;
    Node<K, V>* prev;

    inline Node<K, V>* get_forward(int d)
    {
        return forward[d - depth];
    }

    inline void set_forward(int d, Node<K, V>* p)
    {
        forward[d - depth] = p;
    }
};

// Class template for Skip list
template <typename K, typename V> 
class SkipList {

public: 
    SkipList(double=0.5, double=0.3);
    ~SkipList();
    int get_random_length();
    Node<K, V>* create_node(K, V, int);
    int insert_element(K, V);
    void display_list();
    V search_element(K);
    void delete_element(K);
    void dump_file();
    void load_file();
    //递归删除节点
    void clear(Node<K,V>*);
    int size();

    // 向下拉伸一层，同时给_update数组“拖影”，返回向下伸展的深度
    int stretch_downward();

    // 遍历计数链表
    void traverse_cll();

    // 交换两个节点的层级
    void swap_length(Node<K, V>*, Node<K, V>*);

private:
    void get_key_value_from_string(const std::string& str, std::string* key, std::string* value);
    bool is_valid_string(const std::string& str);

private:    

    double _theta;
    double _p;

    // 跳表中键的数量
    int _n;

    // 跳表中节点的深度在[_min_depth, _max_depth)区间内
    int _min_depth;
    int _max_depth;

    // 当前跳表中最大的class，同时也是跳表的级别，最小为0
    int _max_class;

    // 指向头节点的指针
    Node<K, V> *_header;

    // 计数链表counting link list的尾指针
    // Node<K, V> *_cll_tail;

    // file operator
    std::ofstream _file_writer;
    std::ifstream _file_reader;

    // 随机数生成器
    std::mt19937 random_engine;

    // 几何分布对象
    std::geometric_distribution<> geom_dist;

    int _D[CLASS_LIMIT];

    // _n_threshold[i]表示_max_class为i的跳表所能容纳的最多元素个数
    unsigned _n_threshold[CLASS_LIMIT];

    // 临时用
    Node<K, V>* _update[64];
};

// 向下拉伸一层，同时给_update数组“拖影”，返回向下伸展的深度
template<typename K, typename V>
int SkipList<K, V>::stretch_downward()
{
    // 计算需要向下伸展的深度
    int stretch_depth = _D[_max_class + 1] - _D[_max_class];

    _max_class ++;

    Node<K, V> *current = this->_header;
    do
    {        
        // 预先分配内存，避免多次分配
        current->forward.reserve(current->forward.size() + stretch_depth);

        // 获取需要重复的指针
        Node<K, V>* bottom_pointer = current->forward.back();

        // 批量填充
        std::fill_n(std::back_inserter(current->forward), stretch_depth, bottom_pointer);

        // 更新指针
        current = current->forward.back();

    } while (current != nullptr);

    // std::fill(_update + _max_depth, _update + _max_depth + stretch_depth, _update[_max_depth - 1]);

    // 同时批量填充_update数组
    std::fill_n(_update + _max_depth, stretch_depth, _update[_max_depth - 1]);

    _max_depth += stretch_depth;

    // std::cout << "stretched. " << std::endl;

    return stretch_depth;
}

template<typename K, typename V>
void SkipList<K, V>::traverse_cll()
{
    // std::cout << _header->impression << " | " << _header->counter << std::endl;

    Node<K, V>* current = _header;
    while (current->next != _header)
    {
        current = current->next;
        std::cout << "(" << current->key << ", " << current->counter << ", "<< current->node_class << ") "; 
    }
    std::cout << std::endl;

    // current = _header;
    // while (current->prev != _header)
    // {
    //     current = current->prev;
    //     std::cout << "(" << current->key << ", " << current->counter << ") ";
    // }
    // std::cout << std::endl;
}

template<typename K, typename V>
void SkipList<K, V>::swap_length(Node<K, V>* n1, Node<K, V>* n2)
{
    // 如果二者depth相同，不用交换
    if (n1->depth == n2->depth)
    {
        std::swap(n1->node_class, n2->node_class);
        return;
    }

    // display_list();

    // 确保n1是需要升级的那个，n2是需要降级的那个
    if (n1->depth < n2->depth)
        std::swap(n1, n2);

    Node<K, V>* current = _header;

    // 先处理其它节点连接到n2多出部分的问题
    for (int i = _min_depth; i < n1->depth; i ++)
    {
        while (current->get_forward(i) != nullptr && current->get_forward(i)->key < n2->key)
        {
            current = current->get_forward(i);
        }
        if (i >= n2->depth)
        {
            current->set_forward(i, n2->get_forward(i));
        }
    }

    // 再处理如何抬升n1的问题
    current = _header;
    for (int i = _min_depth; i < n1->depth; i ++)
    {
        while (current->get_forward(i) != nullptr && current->get_forward(i)->key < n1->key)
        {
            current = current->get_forward(i);
        }
        if (i >= n2->depth)
        {
            // 将属于的n1指针存储在n2的空间，因为后续这片内存空间会交换给n1
            n2->set_forward(i, current->get_forward(i));

            current->set_forward(i, n1);
        }
    }

    Node<K, V>** cut_position = n2->forward.data() + (n1->depth - n2->depth);

    size_t byte_num = n1->forward.size() * sizeof(Node<K, V>*);

    memcpy(_update, n1->forward.data(), byte_num);
    memcpy(n1->forward.data(), cut_position, byte_num);
    memcpy(cut_position, _update, byte_num);

    // 最后交换forward, node_class, depth
    std::swap(n1->forward, n2->forward);
    std::swap(n1->node_class, n2->node_class);
    std::swap(n1->depth, n2->depth);

    // std::cout << "swaped. " << n1->key << " : " << n2->key << std::endl; 
    // display_list();

    return;
}

// create new node 
template<typename K, typename V>
Node<K, V>* SkipList<K, V>::create_node(const K k, const V v, int length) {
    Node<K, V> *n = new Node<K, V>(k, v, length, _max_depth - length);
    return n;
}

// Insert given key and value in skip list 
// return 1 means element exists  
// return 0 means insert successfully
/* 
                           +------------+
                           |  insert 50 |
                           +------------+
level 4     +-->1+                                                      100
                 |
                 |                      insert +----+
level 3         1+-------->10+---------------> | 50 |          70       100
                                               |    |
                                               |    |
level 2         1          10         30       | 50 |          70       100
                                               |    |
                                               |    |
level 1         1    4     10         30       | 50 |          70       100
                                               |    |
                                               |    |
level 0         1    4   9 10         30   40  | 50 |  60      70       100
                                               +----+

*/
template<typename K, typename V>
int SkipList<K, V>::insert_element(const K key, const V value) {
    
    // std::cout << "inserting: " << key << std::endl;

    mtx.lock();
    Node<K, V> *current = this->_header;

    for (int i = _min_depth; i < _max_depth; i ++)
    {
        while(current->get_forward(i) != NULL && current->get_forward(i)->key < key) {
            current = current->get_forward(i); 
        }
        _update[i] = current;
    }

    // reached level 0 and forward pointer to right node, which is desired to insert key.
    // current = current->forward[0];
    current = current->get_forward(_max_depth - 1);

    // if current node have key equal to searched key, we get it
    if (current != NULL && current->key == key) {
        std::cout << "key: " << key << ", exists" << std::endl;
        mtx.unlock();
        return 1;
    }

    // if current is NULL that means we have reached to end of the level 
    // if current's key is not equal to key that means we have to insert node between update[0] and current node 
    if (current == NULL || current->key != key ) { // 这行或许可以不用？
        
        // 如果当前_n达到阈值，向下扩展跳表
        if (_n == _n_threshold[_max_class])
        {
            int stretch_depth = this->stretch_downward();
        }

        // Generate a random length for node
        int random_length = get_random_length();

        // If random level is greater thar skip list's current level, initialize update value with pointer to header
        if (random_length > _max_depth - _min_depth) {
            for (int i = _max_depth - random_length; i < _min_depth; i ++) {
                _update[i] = _header;
            }
            _min_depth = _max_depth - random_length;
        }

        // create new node with random length generated 
        Node<K, V>* inserted_node = create_node(key, value, random_length);
        inserted_node->node_class = _max_class;

        // insert node 
        for (int i = _max_depth - random_length; i < _max_depth; i ++) {
            inserted_node->set_forward(i, _update[i]->get_forward(i));
            _update[i]->set_forward(i, inserted_node);
        }

        // 获取计数链表当前尾节点的计数器的印象
        inserted_node->impression = _header->prev->counter;

        // 将新节点接到计数链表尾部
        inserted_node->next = _header;
        inserted_node->prev = _header->prev;

        _header->prev->next = inserted_node;
        _header->prev = inserted_node;

        // 元素个数增加
        _n ++;
    }
    mtx.unlock();
    return 0;
}

// Display skip list 
template<typename K, typename V> 
void SkipList<K, V>::display_list() {

    std::cout << "\n***** Skip List *****"<<"\n"; 
    std::cout << "_min_depth= " << _min_depth << ", _max_depth= " << _max_depth << std::endl;

    for (int i = _min_depth; i < _max_depth; i ++) {
        Node<K, V> *node = _header->get_forward(i);
        std::cout << "Depth " << i << ": ";
        while (node != nullptr) {
            // std::cout << node->key << ": " << node->value << ", ";
            std::cout << node->key << ", ";
            node = node->get_forward(i);
        }
        std::cout << std::endl;
    }
    std::cout << std::endl;
}

// Dump data in memory to file 
template<typename K, typename V> 
void SkipList<K, V>::dump_file() {

    std::cout << "dump_file-----------------" << std::endl;
    _file_writer.open(STORE_FILE);
    Node<K, V> *node = this->_header->forward[0]; 

    while (node != NULL) {
        _file_writer << node->key << ":" << node->value << "\n";
        std::cout << node->key << ":" << node->value << ";\n";
        node = node->forward[0];
    }

    _file_writer.flush();
    _file_writer.close();
    return ;
}

// Load data from disk
template<typename K, typename V> 
void SkipList<K, V>::load_file() {

    _file_reader.open(STORE_FILE);
    std::cout << "load_file-----------------" << std::endl;
    std::string line;
    std::string* key = new std::string();
    std::string* value = new std::string();
    while (getline(_file_reader, line)) {
        get_key_value_from_string(line, key, value);
        if (key->empty() || value->empty()) {
            continue;
        }
        // Define key as int type
        insert_element(stoi(*key), *value);
        std::cout << "key:" << *key << "value:" << *value << std::endl;
    }
    delete key;
    delete value;
    _file_reader.close();
}

// Get current SkipList size
template<typename K, typename V> 
int SkipList<K, V>::size() { 
    return _n;
}

template<typename K, typename V>
void SkipList<K, V>::get_key_value_from_string(const std::string& str, std::string* key, std::string* value) {

    if(!is_valid_string(str)) {
        return;
    }
    *key = str.substr(0, str.find(delimiter));
    *value = str.substr(str.find(delimiter)+1, str.length());
}

template<typename K, typename V>
bool SkipList<K, V>::is_valid_string(const std::string& str) {

    if (str.empty()) {
        return false;
    }
    if (str.find(delimiter) == std::string::npos) {
        return false;
    }
    return true;
}

// Delete element from skip list 
template<typename K, typename V> 
void SkipList<K, V>::delete_element(K key) {

    // mtx.lock();
    // Node<K, V> *current = this->_header; 
    // Node<K, V> *update[_max_level+1];
    // memset(update, 0, sizeof(Node<K, V>*)*(_max_level+1));

    // // start from highest level of skip list
    // for (int i = _skip_list_level; i >= 0; i--) {
    //     while (current->forward[i] !=NULL && current->forward[i]->key < key) {
    //         current = current->forward[i];
    //     }
    //     update[i] = current;
    // }

    // current = current->forward[0];
    // if (current != NULL && current->key == key) {
       
    //     // start for lowest level and delete the current node of each level
    //     for (int i = 0; i <= _skip_list_level; i++) {

    //         // if at level i, next node is not target node, break the loop.
    //         if (update[i]->forward[i] != current) 
    //             break;

    //         update[i]->forward[i] = current->forward[i];
    //     }

    //     // Remove levels which have no elements
    //     while (_skip_list_level > 0 && _header->forward[_skip_list_level] == 0) {
    //         _skip_list_level --; 
    //     }

    //     std::cout << "Successfully deleted key "<< key << std::endl;
    //     delete current;
    //     _n --;
    // }
    // mtx.unlock();
    // return;
}

// Search for element in skip list 
/*
                           +------------+
                           |  select 60 |
                           +------------+
level 4     +-->1+                                                      100
                 |
                 |
level 3         1+-------->10+------------------>50+           70       100
                                                   |
                                                   |
level 2         1          10         30         50|           70       100
                                                   |
                                                   |
level 1         1    4     10         30         50|           70       100
                                                   |
                                                   |
level 0         1    4   9 10         30   40    50+-->60      70       100
*/
template<typename K, typename V> 
V SkipList<K, V>::search_element(K key) {

    Node<K, V> *current = _header;

    for (int i = _min_depth; i < _max_depth; i ++) 
    {
        while (current->get_forward(i) && current->get_forward(i)->key <= key)
        {
            current = current->get_forward(i);
        }

        if (current->key == key)
        {
            // 计数器加一
            current->counter ++;

            // 自增后的计数器与印象比较
            if (current->counter > current->impression)
            {
                Node<K, V>* p = current->prev;
                if (current->counter > p->counter)
                {
                    if (p->node_class < current->node_class)
                        swap_length(current, p);
    
                    // 考虑current之前的多个节点的计数器的值相同的情况
                    while (p->counter == p->prev->counter)
                    {
                        p = p->prev;

                        if (p->node_class < current->node_class)
                            swap_length(current, p);
                    }
                    
                    // 通过以下六个指针操作将current节点移动到p节点之前

                    current->prev->next = current->next;
                    current->next->prev = current->prev;

                    current->prev = p->prev;
                    current->next = p;

                    p->prev->next = current;
                    p->prev = current;

                    // 更新impression
                    current->impression = current->prev->counter;
                    p->impression = current->counter;

                    // 可能需要进行类别的交换
                    // if (current->node_class > p->node_class)
                    // {
                    //     swap_length(current, p);
                    // }
                }
                else
                {
                    current->impression = p->counter;
                }
            }

            // while (p->counter < current->counter)
            return current->value;
        }
    }

    std::cout << "Not Found Key:" << key << std::endl;
    return 0;
}

// construct skip list
template<typename K, typename V> 
SkipList<K, V>::SkipList(double theta, double p): 
    _theta(theta),
    _p(p),
    _n(0),
    _min_depth(CEILING), // _min_depth所在深度有节点
    _max_depth(CEILING), // _max_depth所在深度无节点
    _max_class(0),
    random_engine(RANDOM_ENGINE_SEED),
    geom_dist(1 - p)
{

    K k;
    V v;

    _header = new Node<K, V>(k, v, CEILING, 0);
    _header->node_class = 0;
    _header->counter = 0xffffffff;
    _header->impression = 0xffffffff;

    _header->next = _header;
    _header->prev = _header;

    // 填充_D数组，此处暂时不能保证极端情况的正确性
    double log_theta_divided_by_log_p = std::log2(_theta) / std::log2(_p);
    _D[0] = std::ceil(log_theta_divided_by_log_p);
    std::cout << "_D[0]= " << _D[0] << std::endl;
    for (int i = 1; i < CLASS_LIMIT; i ++)
    {
        double tmp = std::ceil(log_theta_divided_by_log_p * (1u << i));
        _D[i] = _D[i - 1] + tmp < 64 ? _D[i - 1] + tmp : 64;
        std::cout << "_D[" << i << "]= " << _D[i] << std::endl;
    }

    // 填充_n_threshold数组，后部会溢出，以后需要修复
    _n_threshold[0] = 1 / _theta;
    std::cout << "_n_threshold[0]= " << _n_threshold[0] << std::endl;
    for (int i = 1; i < CLASS_LIMIT; i ++)
    {
        unsigned tmp = _n_threshold[i - 1] + std::pow(1 / _theta, 1u << i);
        _n_threshold[i] = tmp < 0xffffffff ? tmp : 0xffffffff;
        std::cout << "_n_threshold[" << i << "]= " << _n_threshold[i] << std::endl;
    }
}

template<typename K, typename V> 
SkipList<K, V>::~SkipList() {

    if (_file_writer.is_open()) {
        _file_writer.close();
    }
    if (_file_reader.is_open()) {
        _file_reader.close();
    }

    //递归删除跳表链条
    if(_header->forward[0]!=nullptr){
        clear(_header->forward[0]);
    }
    delete(_header);
    
}
template <typename K, typename V>
void SkipList<K, V>::clear(Node<K, V> * cur)
{
    if(cur->forward[0]!=nullptr){
        clear(cur->forward[0]);
    }
    delete(cur);
}

// 返回的最小值为1，表示一个节点至少在一层链表当中出现
template<typename K, typename V>
int SkipList<K, V>::get_random_length(){

    int r = geom_dist(random_engine) + 1;

    // std::cout << "random: " << r << std::endl;

    return r;
};
