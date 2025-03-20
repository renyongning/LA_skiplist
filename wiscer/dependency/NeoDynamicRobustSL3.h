// 基于 https://github.com/youngyangyang04/Skiplist-CPP

#include <iostream> 
#include <cstdlib>
#include <cmath>
#include <cstring>
#include <fstream>
#include <random>
#include <limits>
#include <unistd.h>

#define CLASS_LIMIT 8
#define RANDOM_ENGINE_SEED 5489
#define CEILING 32

#define POINTER_SIZE 8

#define MAX_NODE_COUNT 2000000

// #define MAX_DISTANCE 4

//Class template to implement node
template<typename K, typename V> 
struct Node {
    
    Node() {} 

    Node(K k, V v, int level); 

    ~Node();
    
    Node<K, V>** forward;

    K key;
    V value;

    // 计数器
    float counter;

    // 该节点在跳表的_heap[node_class]堆当中的位置
    uint32_t heap_index;

    unsigned char node_level;

    // 节点的类别
    unsigned char node_class;
};

template<typename K, typename V> 
Node<K, V>::Node(const K k, const V v, int level):
    key(k),
    value(v),
    node_level(level),
    node_class(0),
    counter(0),
    heap_index(0)
{
    // level为n的节点，forward数组大小为n+1
    forward = (Node<K, V>**)malloc((level + 1) * POINTER_SIZE);
};

template<typename K, typename V> 
Node<K, V>::~Node() {
    free(forward);
};

template<typename K, typename V>
class MinHeap
{
public:

    MinHeap(int32_t max_size): heap_size(0) 
    {
        array = (Node<K, V>**)malloc(max_size * POINTER_SIZE);
    }

    ~MinHeap() {delete array;}

    uint32_t size()
    {
        return heap_size;
    }

    void push_new(Node<K, V>* n);

    // 返回是否经过调整
    int heapify_up(uint32_t index);

    void heapify_down(uint32_t index);

    // 用node指向的节点代替当前堆中编号为index的节点，并维护小顶堆
    void replace(Node<K, V>* node, uint32_t index);

    Node<K, V>* get_node(uint32_t index)
    {
        return array[index];
    }

    void print()
    {
        int tmp = 1;
        int j = 0;

        while (1)
        {
            for (int i = 0; i < tmp; i ++)
            {
                if (j >= heap_size)
                {
                    std::cout << std::endl;
                    return;
                }
                std::cout << array[j]->counter << " ";
                j ++;
            }
            tmp *= 2;
            std::cout << std::endl;
        }
    }

private:
    Node<K, V>** array;
    uint32_t heap_size;
};

template<typename K, typename V>
void MinHeap<K, V>::push_new(Node<K, V>* node)
{
    array[heap_size] = node;
    node->heap_index = heap_size;
    heap_size ++;
}

template<typename K, typename V>
int MinHeap<K, V>::heapify_up(uint32_t index)
{
    int flag = 0;
    while (index > 0)
    {
        uint32_t parent = (index - 1) / 2;
        if (array[index]->counter < array[parent]->counter)
        {
            std::swap(array[index], array[parent]);
            std::swap(array[index]->heap_index, array[parent]->heap_index);
            index = parent;
            flag = 1;
        }
        else
        {
            break;
        }
    }
    return flag;
}

template<typename K, typename V>
void MinHeap<K, V>::heapify_down(uint32_t index)
{
    uint32_t left_child = 2 * index + 1;
    uint32_t smallest = index;

    while (left_child < heap_size)
    {
        if (array[left_child]->counter < array[smallest]->counter)
        {
            smallest = left_child;
        }
        uint32_t right_child = left_child + 1;
        if (right_child < heap_size && array[right_child]->counter < array[smallest]->counter)
        {
            smallest = right_child;
        }
        if (smallest != index)
        {
            std::swap(array[index], array[smallest]);
            std::swap(array[index]->heap_index, array[smallest]->heap_index);
            index = smallest;
            left_child = 2 * index + 1;
        }
        else
        {
            break;
        }
    }
}

// 用node指向的节点代替当前堆中编号为index的节点，并维护小顶堆
template<typename K, typename V>
void MinHeap<K, V>::replace(Node<K, V>* node, uint32_t index)
{
    array[index] = node;
    node->heap_index = index;
    if (index == 0)
    {
        heapify_down(0);
    }
    else
    {
        if (!heapify_up(index))
            heapify_down(index);
    }
}

// Class template for Skip list
template <typename K, typename V> 
class SkipList {

public: 
    SkipList(double theta = 0.3, double p = 0.5);
    ~SkipList();
    int get_random_level();
    Node<K, V>* create_node(K, V, int);
    int insert_element(K, V);
    void display_list();
    V search_element(K);
    void delete_element(K);
    void clear(Node<K,V>*);
    int size();

    // 向下拉伸一层，同时给_update数组“拖影”，返回向下伸展的深度
    int stretch();

    // 交换两个节点的层级
    void swap_level(Node<K, V>*, Node<K, V>*);

    // 某个节点的计数器自增
    void node_counter_increment(Node<K, V>*);

    void print_heap()
    {
        std::cout << "----------------------------------------" << std::endl;
        std::cout << "----------------------------------------" << std::endl;
        for (int i = 0; i <= _max_class; i ++)
        {
            _heaps[i]->print();
            std::cout << "----------------------------------------" << std::endl;
        }
        std::cout << "----------------------------------------" << std::endl;
    }

private:

    double _theta;
    double _p;

    // 当前跳表高度， 最小为0
    int _skip_list_level;

    // 当前跳表中最大的class，同时也是跳表的级别，最小为0
    int _max_class;

    // pointer to header node 
    Node<K, V> *_header;

    // 跳表中键的数量
    int _n;

    // 随机数生成器
    std::mt19937 _random_engine;

    // 几何分布对象
    std::geometric_distribution<> _geom_dist;

    int _D[CLASS_LIMIT];

    // _n_threshold[i]表示_max_class为i的跳表所能容纳的最多元素个数
    unsigned _n_threshold[CLASS_LIMIT];

    // 临时用
    Node<K, V>* _update[128];

    // 小顶堆
    MinHeap<K, V>* _heaps[CLASS_LIMIT];

    // 总查询次数
    int32_t _total_query_count;

    float _f_hat_thresholds[CLASS_LIMIT];
};

// 向下拉伸一阶，返回向下伸展的长度
template<typename K, typename V>
int SkipList<K, V>::stretch()
{
    // 计算需要向下伸展的长度
    int stretch_length = _D[_max_class + 1] - _D[_max_class];

    _max_class ++;

    Node<K, V> *current = this->_header;

    do
    {
        // forward数组原先的长度
        int origin_length = current->node_level + 1;

        // 获取需要重复的指针
        Node<K, V>* bottom_pointer = current->forward[0];

        // 重新分配内存
        Node<K, V>** new_forward = (Node<K, V>**)malloc((origin_length + stretch_length) * POINTER_SIZE);
        
        // 批量填充
        std::fill_n(new_forward, stretch_length, bottom_pointer);

        // 将forward当中的指针移动到new_forward当中
        memcpy(new_forward + stretch_length, current->forward, origin_length * POINTER_SIZE);

        // 释放原先的空间
        free(current->forward);

        // 更新forward
        current->forward = new_forward;

        // 更新node_level
        current->node_level += stretch_length;

        // 更新指针
        current = bottom_pointer;

    } while (current != nullptr);

    _skip_list_level += stretch_length;

    return stretch_length;
}

template<typename K, typename V>
void SkipList<K, V>::swap_level(Node<K, V>* n1, Node<K, V>* n2)
{

    // 如果二者depth相同，不用交换
    if (n1->node_level == n2->node_level)
    {
        std::swap(n1->node_class, n2->node_class);
        return;
    }

    // 确保n1是需要升级的那个，n2是需要降级的那个
    if (n1->node_level > n2->node_level)
        std::swap(n1, n2);

    Node<K, V>* current = _header;

    // 先处理其它节点连接到n2多出部分的问题
    for (int i = _skip_list_level; i > n1->node_level; i --)
    {
        while (current->forward[i] != nullptr && current->forward[i]->key < n2->key)
        {
            current = current->forward[i];
        }
        if (i <= n2->node_level)
        {
            current->forward[i] = n2->forward[i];
        }
    }

    // 再处理如何抬升n1的问题
    current = _header;
    for (int i = _skip_list_level; i > n1->node_level; i --)
    {
        while (current->forward[i] != nullptr && current->forward[i]->key < n1->key)
        {
            current = current->forward[i];
        }
        if (i <= n2->node_level)
        {
            // 将属于的n1指针存储在n2的空间，因为后续这片内存空间会交换给n1
            n2->forward[i] = current->forward[i];

            // 将要连接到n1的抬升部分的指针
            current->forward[i] = n1;
        }
    }

    size_t byte_num = (n1->node_level + 1) * POINTER_SIZE;

    memcpy(_update, n1->forward, byte_num);
    memcpy(n1->forward, n2->forward, byte_num);
    memcpy(n2->forward, _update, byte_num);

    // 最后交换forward, node_class, depth
    std::swap(n1->forward, n2->forward);
    std::swap(n1->node_class, n2->node_class);
    std::swap(n1->node_level, n2->node_level);

    return;
}

// create new node 
template<typename K, typename V>
Node<K, V>* SkipList<K, V>::create_node(const K k, const V v, int level) {
    Node<K, V> *n = new Node<K, V>(k, v, level);
    return n;
}

// Insert given key and value in skip list 
// return 1 means element exists  
// return 0 means insert successfully
template<typename K, typename V>
int SkipList<K, V>::insert_element(const K key, const V value) {

    // 如果当前_n达到阈值，向下扩展跳表
    if (_n == _n_threshold[_max_class])
    {
        int stretch_length = stretch();
    
        // 并且创建新的类别对应的堆
        if (_n_threshold[_max_class] - _n < MAX_NODE_COUNT)
        {
            _heaps[_max_class] = new MinHeap<K, V>(_n_threshold[_max_class] - _n);
        }
        else
        {
            _heaps[_max_class] = new MinHeap<K, V>(MAX_NODE_COUNT);
        }
   }

    Node<K, V> *current = this->_header;

    for (int i = _skip_list_level; i >= 0; i --)
    {
        while(current->forward[i] != nullptr && current->forward[i]->key < key) {
            current = current->forward[i]; 
        }
        _update[i] = current;
    }

    // reached level 0 and forward pointer to right node, which is desired to insert key.
    current = current->forward[0];

    // 判断要插入的键是否已经存在
    if (current != nullptr && current->key == key) {
        std::cout << "key: " << key << ", exists" << std::endl;
        return 1;
    }


    // if current is NULL that means we have reached to end of the level 
    // if current's key is not equal to key that means we have to insert node between update[0] and current node 
    if (current == NULL || current->key != key ) { // 这行或许可以不用？

        // 获取随机level
        int random_level = get_random_level();

        // 若获取的随机level超过了跳表的level，需要对_update数组做处理
        if (random_level > _skip_list_level) {
            for (int i = _skip_list_level + 1; i <= random_level; i ++) {
                _update[i] = _header;
            }
            _skip_list_level = random_level;
        }

        // create new node with random length generated
        // std::cout << "rdlv= " << random_level << "k= " << key << std::endl;
        Node<K, V>* inserted_node = create_node(key, value, random_level);
        inserted_node->node_class = _max_class;

        // insert node 
        for (int i = random_level; i >= 0; i --)
        {
            inserted_node->forward[i] = _update[i]->forward[i];
            _update[i]->forward[i] = inserted_node;
        }

        // 将新节点压入_max_class对应的堆内
        _heaps[_max_class]->push_new(inserted_node);

        // 元素个数增加
        _n ++;
    }
    return 0;
}

// Display skip list 
template<typename K, typename V> 
void SkipList<K, V>::display_list() {

    std::cout << "\n***** Skip List *****"<<"\n"; 

    for (int i = _skip_list_level; i >= 0; i --) {
        Node<K, V> *node = _header->forward[i];
        std::cout << "Level " << i << ": ";
        while (node != nullptr) {
            // std::cout << node->key << ": " << node->value << ", ";
            std::cout << node->key << ", ";
            node = node->forward[i];
        }
        std::cout << std::endl;
    }
    std::cout << std::endl;
}

// Get current SkipList size
template<typename K, typename V> 
int SkipList<K, V>::size() { 
    return _n;
}

// Delete element from skip list 
template<typename K, typename V> 
void SkipList<K, V>::delete_element(K key) {
}

template<typename K, typename V>
void SkipList<K, V>::node_counter_increment(Node<K, V>* current)
{
    current->counter ++;

    // 若概率支持升级，且不为0类的节点
    if (current->node_class > 0 && 1.0 * current->counter / _total_query_count > _f_hat_thresholds[current->node_class - 1])
    {

        Node<K, V>* to_replace = _heaps[current->node_class - 1]->get_node(0);

        // 用上一类的堆顶节点替换当前节点
        _heaps[current->node_class]->replace(to_replace, current->heap_index);
        // 用当前节点替换上一类的堆顶节点
        _heaps[current->node_class - 1]->replace(current, 0);

        // 交换两个节点的层级
        swap_level(current, to_replace);
    }
    // 若不支持升级，则只需考虑在当前类别的堆当中向下调整位置
    else
    {
        if (current->node_class != _max_class)
            _heaps[current->node_class]->heapify_down(current->heap_index);
    }
}

// Search for element in skip list 
template<typename K, typename V> 
V SkipList<K, V>::search_element(K key) {

    Node<K, V> *current = _header;

    for (int i = _skip_list_level; i >= 0; i --) 
    {
        while (current->forward[i] && current->forward[i]->key <= key)
        {
            current = current->forward[i];
        }

        if (current->key == key)
        {
            
            // 跳表总访问次数加一
            _total_query_count ++;

            // 节点访问次数加一
            node_counter_increment(current);

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
    _skip_list_level(0),
    _max_class(0),
    _random_engine(RANDOM_ENGINE_SEED),
    _geom_dist(1 - p),
    _total_query_count(0)
{
    K k = std::numeric_limits<K>::max();
    V v;

    _header = new Node<K, V>(k, v, CEILING);
    _header->node_class = 0;
    _header->counter = 0xffffffff;

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

    // 在跳表的构造阶段即计算并储存_f_hat_thresholds
    for (int i = 0; i < CLASS_LIMIT; i ++)
    {
        _f_hat_thresholds[i] = std::pow(_theta, 1u << i);
        std::cout << "_f_hat_thresholds[" << i << "]= " << _f_hat_thresholds[i] << std::endl;
    }

    memset(_heaps, 0, sizeof(_heaps));
    _heaps[0] = new MinHeap<K, V>(_n_threshold[0]);
};

template<typename K, typename V> 
SkipList<K, V>::~SkipList() {

    //递归删除跳表链条
    if(_header->forward[0]!=nullptr){
        clear(_header->forward[0]);
    }
    delete(_header);

    for (int i = 0; i <= _max_class; i ++)
    {
        if (_heaps[i])
            delete _heaps[i];
    }
}

template <typename K, typename V>
void SkipList<K, V>::clear(Node<K, V> * cur)
{
    if(cur->forward[0]!=nullptr){
        clear(cur->forward[0]);
    }
    delete(cur);
}

// 返回的最小值为0
template<typename K, typename V>
int SkipList<K, V>::get_random_level(){
    int r = _geom_dist(_random_engine);
    return r;
};