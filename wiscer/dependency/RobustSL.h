// 基于https://github.com/youngyangyang04/Skiplist-CPP

#include <iostream> 
#include <cstdlib>
#include <cmath>
#include <cstring>
#include <mutex>
#include <fstream>

#define STORE_FILE "store/dumpFile"

std::mutex mtx;     // mutex for critical section
std::string delimiter = ":";

//Class template to implement node
template<typename K, typename V> 
class Node {

public:
    
    Node() {} 

    Node(K k, V v, int); 

    ~Node();

    K get_key() const;

    V get_value() const;

    void set_value(V);
    
    // Linear array to hold pointers to next node of different level
    Node<K, V> **forward;

    int node_level;

private:
    K key;
    V value;
};

template<typename K, typename V> 
Node<K, V>::Node(const K k, const V v, int level) {
    this->key = k;
    this->value = v;
    this->node_level = level; 

    // level + 1, because array index is from 0 - level
    this->forward = new Node<K, V>*[level+1];
    
	// Fill forward array with 0(NULL) 
    memset(this->forward, 0, sizeof(Node<K, V>*)*(level+1));
};

template<typename K, typename V> 
Node<K, V>::~Node() {
    delete []forward;
};

template<typename K, typename V> 
K Node<K, V>::get_key() const {
    return key;
};

template<typename K, typename V> 
V Node<K, V>::get_value() const {
    return value;
};
template<typename K, typename V> 
void Node<K, V>::set_value(V value) {
    this->value=value;
};

// Class template for Skip list
template <typename K, typename V> 
class SkipList {

public: 
    SkipList(int=32, double=0.5, double=0.3);
    ~SkipList();
    int get_random_level(double);
    Node<K, V>* create_node(K, V, int);
    int insert_element(K, V, double);
    void initialize(int);
    void display_list();
    void display_list_loose_style();
    V search_element(K);
    void delete_element(K);
    void dump_file();
    void load_file();
    //递归删除节点
    void clear(Node<K,V>*);
    int size();

private:
    void get_key_value_from_string(const std::string& str, std::string* key, std::string* value);
    bool is_valid_string(const std::string& str);
    int get_class(double);

private:    
    // Maximum level of the skip list 
    int _max_level;

    // current level of skip list 
    int _skip_list_level;

    // pointer to header node 
    Node<K, V> *_header;

    // file operator
    std::ofstream _file_writer;
    std::ifstream _file_reader;

    // skiplist current element count
    int _element_count;

    // 论文3.3所述的n，而上面的_element_count即论文3.3所述的n_t
    int _n;

    double _theta;
    double _p;

    // _f_hat_thresholds[i] = _theta^(2^i)   32位已经足够大
    double _f_hat_thresholds[32];

    // 即 n^(log(p)/2)
    double _min_effective_f_hat;

    int _D[32];

    int _K;
};

template<typename K, typename V>
void SkipList<K, V>::initialize(int n)
{
    _n = n;

    _min_effective_f_hat = std::pow(_n, std::log2(_p) / 2);
    // std::cout << "_min_effective_f_hat= " << _min_effective_f_hat << std::endl;

    _K = std::ceil(std::log2(std::log2(_n)) - std::log2(2 * std::log2(_theta) / std::log2(_p)));
    // std::cout << "_K= " << _K << std::endl;
}

// 计算一个预测概率f_hat对应的分类
template<typename K, typename V>
int SkipList<K, V>::get_class(double f_hat)
{
    f_hat = f_hat > _min_effective_f_hat ? f_hat : _min_effective_f_hat;
    
    int c = 0;

    // 这个循环造成了一定额外开销，或许有优化空间
    for (int i = 0; i < 31; i ++)
    {
        if (f_hat < _f_hat_thresholds[i])
            c ++;
        else
            break;
    }

    return c;
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
int SkipList<K, V>::insert_element(const K key, const V value, double f_hat) {
    
    mtx.lock();
    Node<K, V> *current = this->_header;

    // create update array and initialize it 
    // update is array which put node that the node->forward[i] should be operated later
    Node<K, V> *update[_max_level+1];
    memset(update, 0, sizeof(Node<K, V>*)*(_max_level+1));  

    // start form highest level of skip list 
    for(int i = _skip_list_level; i >= 0; i--) {
        while(current->forward[i] != NULL && current->forward[i]->get_key() < key) {
            current = current->forward[i]; 
        }
        update[i] = current;
    }

    // reached level 0 and forward pointer to right node, which is desired to insert key.
    current = current->forward[0];

    // if current node have key equal to searched key, we get it
    if (current != NULL && current->get_key() == key) {
        std::cout << "key: " << key << ", exists" << std::endl;
        mtx.unlock();
        return 1;
    }

    // if current is NULL that means we have reached to end of the level 
    // if current's key is not equal to key that means we have to insert node between update[0] and current node 
    if (current == NULL || current->get_key() != key ) {
        
        // Generate a random level for node
        int random_level = get_random_level(f_hat);

        // If random level is greater thar skip list's current level, initialize update value with pointer to header
        if (random_level > _skip_list_level) {
            for (int i = _skip_list_level+1; i < random_level+1; i++) {
                update[i] = _header;
            }
            _skip_list_level = random_level;
        }

        // create new node with random level generated 
        Node<K, V>* inserted_node = create_node(key, value, random_level);
        
        // insert node 
        for (int i = 0; i <= random_level; i++) {
            inserted_node->forward[i] = update[i]->forward[i];
            update[i]->forward[i] = inserted_node;
        }
        // std::cout << "Successfully inserted key:" << key << ", value:" << value << std::endl;
        _element_count ++;
    }
    mtx.unlock();
    return 0;
}

// Display skip list 
template<typename K, typename V> 
void SkipList<K, V>::display_list() {

    std::cout << "\n*****Skip List*****"<<"\n"; 
    for (int i = 0; i <= _skip_list_level; i++) {
        Node<K, V> *node = this->_header->forward[i]; 
        std::cout << "Level " << i << ": ";
        while (node != NULL) {
            std::cout << node->get_key() << ":" << node->get_value() << ";";
            node = node->forward[i];
        }
        std::cout << std::endl;
    }
}

// Display skip list (层间空行、只打印键不打印值)
template<typename K, typename V> 
void SkipList<K, V>::display_list_loose_style() {

    std::cout << "\n*****Skip List*****"<<"\n\n"; 
    for (int i = 0; i <= _skip_list_level; i++) {
        Node<K, V> *node = this->_header->forward[i]; 
        std::cout << "Level " << i << ": ";
        while (node != NULL) {
            std::cout << node->get_key() << ", ";
            node = node->forward[i];
        }
        std::cout << "\n" << std::endl;
    }
}

// Dump data in memory to file 
template<typename K, typename V> 
void SkipList<K, V>::dump_file() {

    std::cout << "dump_file-----------------" << std::endl;
    _file_writer.open(STORE_FILE);
    Node<K, V> *node = this->_header->forward[0]; 

    while (node != NULL) {
        _file_writer << node->get_key() << ":" << node->get_value() << "\n";
        std::cout << node->get_key() << ":" << node->get_value() << ";\n";
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
    return _element_count;
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

    mtx.lock();
    Node<K, V> *current = this->_header; 
    Node<K, V> *update[_max_level+1];
    memset(update, 0, sizeof(Node<K, V>*)*(_max_level+1));

    // start from highest level of skip list
    for (int i = _skip_list_level; i >= 0; i--) {
        while (current->forward[i] !=NULL && current->forward[i]->get_key() < key) {
            current = current->forward[i];
        }
        update[i] = current;
    }

    current = current->forward[0];
    if (current != NULL && current->get_key() == key) {
       
        // start for lowest level and delete the current node of each level
        for (int i = 0; i <= _skip_list_level; i++) {

            // if at level i, next node is not target node, break the loop.
            if (update[i]->forward[i] != current) 
                break;

            update[i]->forward[i] = current->forward[i];
        }

        // Remove levels which have no elements
        while (_skip_list_level > 0 && _header->forward[_skip_list_level] == 0) {
            _skip_list_level --; 
        }

        std::cout << "Successfully deleted key "<< key << std::endl;
        delete current;
        _element_count --;
    }
    mtx.unlock();
    return;
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

    // std::cout << "search_element-----------------" << std::endl;
    Node<K, V> *current = _header;

    // start from highest level of skip list
    for (int i = _skip_list_level; i >= 0; i--) {
        while (current->forward[i] && current->forward[i]->get_key() <= key) {
            current = current->forward[i];
        }
        V current_key = current->get_key();
        if (current_key == key)
            return current_key;
    }

    // //reached level 0 and advance pointer to right node, which we search
    // current = current->forward[0];

    // // if current node have key equal to searched key, we get it
    // if (current and current->get_key() == key) {
    //     // std::cout << "Found key: " << key << ", value: " << current->get_value() << std::endl;
    //     return current->get_value();
    // }

    std::cout << "Not Found Key:" << key << std::endl;
    return 0;
}

// construct skip list
template<typename K, typename V> 
SkipList<K, V>::SkipList(int max_level, double theta, double p) {

    this->_max_level = max_level;
    this->_skip_list_level = 0;
    this->_element_count = 0;

    // create header node and initialize key and value to null
    K k;
    V v;
    this->_header = new Node<K, V>(k, v, _max_level);

    // 如论文3.3所述，n初始化为4
    _n = 4;
    _theta = theta;
    _p = p;

    // 在跳表的构造阶段即计算并储存_f_hat_thresholds和_min_effective_f_hat，减少插入操作的额外开销(_min_effective_f_hat后续更新的开销无法避免)
    for (int i = 0; i < 32; i ++)
    {
        _f_hat_thresholds[i] = std::pow(_theta, 1u << i);
        // std::cout << "_f_hat_thresholds[" << i << "]= " << _f_hat_thresholds[i] << std::endl;
    }
    _min_effective_f_hat = std::pow(_n, std::log2(_p) / 2);
    // std::cout << "_min_effective_f_hat= " << _min_effective_f_hat << std::endl;

    double log_theta_divided_by_log_p = std::log2(_theta) / std::log2(_p);

    // 此处暂时不能保证极端情况的正确性
    _D[0] = std::ceil(log_theta_divided_by_log_p);
    // std::cout << "_D[0]= " << _D[0] << std::endl;
    for (int i = 1; i < 32; i ++)
    {
        double tmp = std::ceil(log_theta_divided_by_log_p * (1u << i));
        _D[i] = tmp < _max_level ? tmp : _max_level;
        // std::cout << "_D[" << i << "]= " << _D[i] << std::endl;
    }

    _K = std::ceil(std::log2(std::log2(_n)) - std::log2(2 * std::log2(_theta) / std::log2(_p)));
    // std::cout << "_K= " << _K << std::endl;
};

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

template<typename K, typename V>
int SkipList<K, V>::get_random_level(double f_hat)
{
    // 生成 [0, 1) 之间的随机数
    double u = static_cast<double>(rand()) / RAND_MAX;

    // 几何分布的逆累积分布函数
    int X = static_cast<int>(std::log(1 - u) / std::log(_p));

    // 根据f_hat得到类别
    int c = get_class(f_hat);
    int level = _D[_K] - _D[c] + X;

    return level;
};
