#ifndef SKIPLISTPRO_SKIPLIST_H
#define SKIPLISTPRO_SKIPLIST_H
#include<iostream>
#include<cmath>
#include<cstring>
#include<mutex>
#include<fstream>
#include<vector>
#include<utility>
#include<random>
#include<time.h>
#define STORE_FILE "store/dumpFile"

//std::mutex mtx;  //代表互斥锁 ，保持线程同步
std::string delimiter=":";  //存放到STORE_FILE中时，将delimiter也存入进文件中，用于get_key_value_from_string的key与value区分
std::mt19937 generator(std::random_device{}());
std::uniform_int_distribution<int> distribution(0, 99);

template<typename K,typename V>
class Block;

template<typename K,typename V>
class Node{
public:
    Node(){}
    Node(K k,V v,int,double);
    ~Node();
    K get_key() const;
    V get_value() const;
    double get_p();
    void set_value(V);
    void set_p(double);
    Node <K,V> **forward;  //forward是指针数组，用于指向下一层 例如  forward[0]是指向第一层，forward[1]指向上一层
    Block <K,V> ** forward_blocks; //forward_blocks[0]代表第一层中由该node打头的Block,以此类推,范围为 0 ~ node_level-2,即不包含本层的Block信息
    int node_level;//所在的层次
private:
     K key;
     V value;
     double p;
};

template<typename K,typename V>
class Block
{
    public:
    std::vector<Node<K,V> *> nodes;
    std::vector<K> keys;

    Block *next; // Pointer to the next block at the same level
    int block_level;//block所在的层次
    Block(Node<K,V> *nodet, Block *next)
    {
        nodes.push_back(nodet);
        keys.push_back(nodet->get_key());
        this->next = next;
    }
    Block(Node<K,V> *node,int level ,Block *next)
    {
        nodes.push_back(node);
        keys.push_back(node->get_key());

        this->block_level=level;
        this->next = next;
    }
    Block(std::vector<Node<K,V> *> vector, Block *next)
    {
        this->nodes = vector;
        // vector.resize(3); // minimum size of each block
        std::vector<K> tmp;
        for(auto it:vector)
        {
            tmp.push_back(it->get_key());
        }
        this->keys=tmp;
        this->next = next;
    }
    Block(size_t size) {
        keys.reserve(size);
        nodes.reserve(size);
    }
    void print()
    {
        for (unsigned int i = 0; i < nodes.size(); i++)
        {
            std::cout << nodes[i]->get_value();
            if (nodes[i]->node_level)
                std::cout << "(" << nodes[i]->node_level << ")";
            std::cout << " ";
        }
        std::cout << "| ";
    }
};
template<typename K,typename V>
Node<K,V>::Node(const K k, const V v, int level,double p)
{
    this->key=k;
    this->value=v;
    this->p =p;
    this->node_level=level;
    this->forward=new Node<K,V> *[level+1];//level从0开始，+1得到储存包
    memset(this->forward,0,sizeof(Node<K,V>*)*(level+1));
    this->forward_blocks=new Block<K,V> *[level+1];
    memset(this->forward_blocks,0,sizeof(Block<K,V>*)*(level+1));
};
template<typename  K,typename V>
Node<K,V>::~Node()
{
    delete []forward;
    delete []forward_blocks;
};
template<typename K,typename V>
K Node<K,V>::get_key() const {
    return key;
};
template<typename K,typename V>
V Node<K,V>::get_value() const {
    return value;
};
template<typename K,typename V>
double Node<K,V>::get_p()
{
    return p;
}
template<typename K,typename V>
void Node<K,V>::set_value(V value)
{
    this->value=value;
};
template<typename K,typename V>
void Node<K,V>::set_p(double p)
{
    this->p =p;
}
template<typename K,typename V>
class SkipList{
public:
    SkipList(int =31);
    
    // 第二个构造函数，委托调用第一个构造函数，然后在函数体内初始化其他成员
    SkipList(int maxlevel=31, int k_of_thresholds=1, int k_of_getlevel=2);
    ~SkipList();
    int get_random_level(double p);
    Node<K,V>*create_node(K,V,int,double);
    int insert(K,V,double);
    void display_list();
    void block_info();
    void display_blocks();
    void delete_element(K);
    V search(K);
    V search2(K);
    void dump_file();
    void load_file();
    void rehash(std::vector<std::pair<std::pair<K,V>,double>>);//根据新的概率分布重构
    void rehash();//针对当前的分布重构
    int size();
    void bulkload(std::vector<std::pair<std::pair<K,V>,double>>);
private:
    void get_key_value_from_string(const std::string &str,std::string*key,std::string *value);
    bool is_valid_string(const std::string &str);
private:
    int _max_level;              //跳表的最大层级，从0开始
    int _skip_list_level;        //当前跳表的有效层级
    Node<K,V> *_header;          //表示跳表的头节点
    //Block<K,V> *_block_header;   //表示block的头节点，初始仅包含_header
    std::ofstream _file_writer;  //默认以输入(writer)方式打开文件。
    std::ifstream _file_reader;  //默认以输出(reader)方式打开文件。
    int _element_count;          //表示跳表中元素的数量
    int key_of_thresholds;
    int key_of_getlevel;

    std::vector<double> p_thresholds; // p_thresholds[i]表示将一个节点提升至level_i的阈值
};

//create_node函数：根据给定的键、值和层级创建一个新节点，并返回该节点的指针
template<typename K,typename V>
Node<K,V> *SkipList<K,V>::create_node(const K k, const V v, int level,double p)
{
    Node<K,V>*n=new Node<K,V>(k,v,level,p);
    return n;
}
// 插入节点并分割 Block
template<typename K,typename V>
Block<K, V> *insert_and_divide(Block<K, V> *target, Node<K, V> *inserted_node) {
        std::vector<Node<K, V> *> left_nodes;
        std::vector<Node<K, V> *> right_nodes;
        std::vector<K> left_keys;
        std::vector<K> right_keys;

        // 遍历 target 的 nodes，将其分为两部分
        for (auto node : target->nodes) {
            if (node->get_key() < inserted_node->get_key()) {
                left_nodes.push_back(node);
                left_keys.push_back(node->get_key());
            } else
            {
                right_nodes.push_back(node);
                right_keys.push_back(node->get_key());
            }
        }

        right_nodes.insert(right_nodes.begin(), inserted_node);
        right_keys.insert(right_keys.begin(), inserted_node->get_key());
        // 将 left_nodes 赋值给 target 的 nodes
        target->nodes = left_nodes;
        target->keys = left_keys;

        // 创建一个新的 Block，将 right_nodes 赋值给新的 Block，并返回
        Block<K, V> *new_block = new Block<K, V>(right_nodes, target->next);

        // 更新 target 的 next 指针
        target->next = new_block;
        new_block->block_level=target->block_level;
        return new_block;
}
//insert_element 函数：插入一个新的键值对到跳表中。通过遍历跳表，找到插入位置，并根据随机层级创建节点。
//如果键已存在，则返回 1，表示插入失败；否则，插入成功，返回 0。
template<typename K,typename V>
int SkipList<K,V>::insert(const K key,const  V value,double p)
{
    //mtx.lock();
    std::srand(time(NULL));
    Node<K,V> *update[_max_level];
    Block<K,V> *update_blocks[_max_level];
    Node<K,V> *current=this->_header;
    memset(update,0,sizeof(Node<K,V>*)*(_max_level+1));
    memset(update_blocks,0,sizeof(Block<K,V>*)*(_max_level+1));
    //99-113行-为查找key是否在跳表中出现，也可以直接调用search_element(K key)
    update_blocks[_skip_list_level]=_header->forward_blocks[_skip_list_level];
    for(int i=_skip_list_level;i>=0;i--)
    {
        while(current->forward[i]!=NULL&&current->forward[i]->get_key()<key)//同一层级的下一个指针不为空并且值小于查询值
        {
            current=current->forward[i];
        }
        update[i]=current;   //update是存储每一层需要插入点节点的位置

        if(i>0)
        {
            update_blocks[i-1]=current->forward_blocks[i-1];
        }
    }
    current=current->forward[0];
    if(current!=NULL&&current->get_key()==key)
    {
        std::cout<<"key:"<<key<<",exists"<<std::endl;
        //mtx.unlock();
        return 1;
    }

    //添加的值没有在跳表中
    if(current==NULL||current->get_key()!=key)
    {
        int random_level=get_random_level(p)+1;
        //int random_level=1;
        if(random_level>_skip_list_level)
        {
            for(int i=_skip_list_level+1;i<random_level+1;i++)
            {
                update[i]=_header;
                update_blocks[i]=_header->forward_blocks[i];
            }
            _skip_list_level=random_level;
            //random_level=_skip_list_level;
        }
        Node<K,V>*inserted_node= create_node(key,value,random_level,p);
        for(int i=0;i<random_level;i++)
        {
            inserted_node->forward[i]=update[i]->forward[i];  //跟链表的插入元素操作一样
            update[i]->forward[i]=inserted_node;

            if(i<random_level-1)
            {
                inserted_node->forward_blocks[i]=insert_and_divide(update_blocks[i],inserted_node);
            }
            else if(i==random_level-1)
            {
                // 在最高层级（random_level-1），将节点插入到 nodes 中,不用分裂
               
                auto it = update_blocks[i]->nodes.begin();
                auto itkey = update_blocks[i]->keys.begin();
                while (itkey != update_blocks[i]->keys.end() && (*itkey) < inserted_node->get_key()) {
                    ++it;
                    ++itkey;
                }
                // 使用迭代器插入节点
                update_blocks[i]->nodes.insert(it, inserted_node);
                update_blocks[i]->keys.insert(itkey, inserted_node->get_key());
                
            }
        }
        //std::cout<<"Successfully inserted key:"<<key<<",value:"<<value<<std::endl;
        _element_count++;
    }
    //mtx.unlock();
    return 0;
}
//display_list函数：输出跳表包含的内容、循环_skip_list_level(有效层级)、从_header头节点开始、结束后指向下一节点
template<typename K,typename V>
void SkipList<K,V>::display_list()
{
    std::cout<<"\n*****SkipList*****"<<"\n";
    for(int i=0;i<=_skip_list_level;i++)
    {
        Node<K,V>*node=this->_header->forward[i];
        std::cout<<"Level"<<i<<":   ";
        while(node!=NULL)
        {
            //std::cout<<node->get_key()<<":"<<node->get_value()<<";";
            std::cout<<node->get_key()<<";";
            node=node->forward[i];
        }
        std::cout<<std::endl;
    }
}
template<typename K, typename V>
void SkipList<K, V>::block_info()
{
    std::cout << "\n*****Block Info of SkipList*****\n";
    for (int i = 0; i <= _skip_list_level; i++) {
        int total_nodes = 0;
        int block_count = 0;

        // 获取level i的第一个block
        Block<K, V> *block = this->_header->forward_blocks[i];

        while (block != nullptr) {
            total_nodes += block->nodes.size();
            block_count += 1;

            // 移动到下一个block
            block = block->next;
        }

        double average = block_count > 0 ? static_cast<double>(total_nodes) / block_count : 0.0;

        std::cout << "Level " << i << ": Average nodes per block = " << average << std::endl;
    }
}

template<typename K, typename V>
void SkipList<K, V>::display_blocks()
{
    std::cout << "\n*****Block Structure of SkipList*****\n";
    for (int i = 0; i <= _skip_list_level; i++) {
        std::cout << "Level " << i << ":   ";
        
        // 获取level i的第一个block
        Block<K, V> *block = this->_header->forward_blocks[i];

        while (block != nullptr) {
            std::cout << "[";
            for (size_t j = 0; j < block->nodes.size(); j++) {
                std::cout << block->nodes[j]->get_key();
                if (j < block->nodes.size() - 1) {
                    std::cout << ", "; // 分隔每个节点的key
                }
            }
            std::cout << "]";
            
            // 移动到下一个block
            block = block->next;

            if (block != nullptr) {
                std::cout << " -> "; // 分隔每个block
            }
        }
        std::cout << std::endl;
    }
}

//dump_file 函数：将跳跃表的内容持久化到文件中。遍历跳跃表的每个节点，将键值对写入文件。
//其主要作用就是将跳表中的信息存储到STORE_FILE文件中，node指向forward[0]，每一次结束后再将node指向node.forward[0]。
template<typename K,typename V>
void SkipList<K,V>::dump_file()
{
    std::cout<<"dump_file-----------"<<std::endl;
    _file_writer.open(STORE_FILE);
    Node<K,V>*node=this->_header->forward[0];
    while(node!=NULL)
    {
        _file_writer<<node->get_key()<<":"<<node->get_value()<<"\n";
        std::cout<<node->get_key()<<":"<<node->get_value()<<"\n";
        node=node->forward[0];
    }
    _file_writer.flush();  //设置写入文件缓冲区函数
    _file_writer.close();
    return ;
}

//将文件中的内容转到跳表中、每一行对应的是一组数据，数据中有：分隔，还需要get_key_value_from_string(line,key,value)将key和value分开。
//直到key和value为空时结束，每组数据分开key、value后通过insert_element()存到跳表中来
template<typename K,typename V>
void SkipList<K,V>::load_file()
{
    _file_reader.open(STORE_FILE);
    std::cout<<"load_file----------"<<std::endl;
    std::string line;
    std::string *key=new std::string();
    std::string *value=new std::string();
    while(getline(_file_reader,line))
    {
        get_key_value_from_string(line,key,value);
        if(key->empty()||value->empty())
        {
            continue;
        }
        int target=0;
        std::string str_key=*key;   //当时定义的key为int类型，所以将得到的string类型的 key转成int
        for(int i=0;i<str_key.size();i++)
        {
            target=target*10+str_key[i]-'0';
        }
        int Yes_No=insert(target,*value);
        std::cout<<"key:"<<*key<<"value:"<<*value<<std::endl;
    }
    _file_reader.close();
}

//表示跳表中元素的数量
template<typename K,typename V>
int SkipList<K,V>::size() {
    return _element_count;
}

//从STORE_FILE文件读取时，每一行将key和value用 ：分开，此函数将每行的key和value分割存入跳表中
template<typename K,typename V>
void SkipList<K,V>::get_key_value_from_string(const std::string &str, std::string *key, std::string *value)
{
    if(!is_valid_string(str)) return ;
    *key=str.substr(0,str.find(delimiter));
    *value=str.substr(str.find(delimiter)+1,str.length());
}

//判断从get_key_value_from_string函数中分割的字符串是否正确
template<typename K,typename V>
bool SkipList<K,V>::is_valid_string(const std::string &str)
{
    if(str.empty())
    {
        return false;
    }
    if(str.find(delimiter)==std::string::npos)
    {
        return false;
    }
    return true;
}

//遍历跳表找到每一层需要删除的节点，将前驱指针往前更新，遍历每一层时，都需要找到对应的位置
//前驱指针更新完，还需要将全为0的层删除
template<typename K,typename V>
void SkipList<K,V>::delete_element(K key)
{
    //mtx.lock();
    Node<K,V>*current=this->_header;

    Node<K,V>*update[_max_level+1];
    Block<K,V>* update_blocks[_max_level+1];
    memset(update,0,sizeof(Node<K,V>*)*(_max_level+1));
    memset(update,0,sizeof(Block<K,V>*)*(_max_level+1));
    update_blocks[_skip_list_level]=this->_header->forward_blocks[_skip_list_level];


    for(int i=_skip_list_level;i>=0;i--)
    {
        while(current->forward[i]!=NULL&&current->forward[i]->get_key()<key)
        {
            current=current->forward[i];
        }
        update[i]=current;
        if(i) update_blocks[i-1]=current->forward_blocks[i-1];
    }
    current=current->forward[0];

    int level=_skip_list_level;
    if(current!=NULL&&current->get_key()==key)
    {
        for(int i=0;i<=_skip_list_level;i++) {
            if (update[i]->forward[i]==0||update[i]->forward[i] != current) {
                level=i-1;
                break;
            }
            update[i]->forward[i] = current->forward[i];
        }
        //在这里实现从block中删除node，对于update_blocks[level],，从block的keys和nodes中删去需要被删除的key和node
        if (update_blocks[level] != nullptr) {
            update_blocks[level]->remove_by_key(key);  // 删除最高层的 Block 中的 key 和 node
        }
        //对于update_blocks[0,1,...,level-1]->next,删去这些block的keys数组和nodes数组开头的current节点
        //剩余节点并入上一个block即update_blocks[0,1,...,level-1]，如果删除后为空无需进行并入
        for (int i = level - 1; i >= 0; i--) {
            Block<K, V>* current_block = update_blocks[i]->next;
            Block<K, V>* previous_block = update_blocks[i];
            if (current_block->remove_by_key(key)) {
                // 如果删除后块为空，直接跳过该块
                if (current_block->keys.empty()) {
                    previous_block->next = current_block->next;  // 删除空块
                } else {
                    // 将 current_block 的剩余部分合并到 previous_block
                    previous_block->keys.insert(previous_block->keys.end(), current_block->keys.begin(), current_block->keys.end());
                    previous_block->nodes.insert(previous_block->nodes.end(),current_block->nodes.begin(),current_block->nodes.end());
                    // 更新链接，跳过 current_block
                    previous_block->next = current_block->next;
                }
            }
        }
        
        while(_skip_list_level>0&&_header->forward[_skip_list_level]==0)
        {
            _skip_list_level--;
        }
        _element_count--;
    }
    //mtx.unlock();
    return ;
}


//遍历每一层，从顶层开始，找到每层对应的位置，然后进入下一层开始查找，直到查找到对应的key
//如果找到return true 输出Found  否则 return false ，输出Not Found
/*template<typename K,typename V>
V SkipList<K,V>::search(K key)
{
    //std::cout<<"search_element------------"<<std::endl;
    Node<K,V> *current=_header;
    for (int i = _skip_list_level; i >= 0; i--) {
        while (current->forward[i] && current->forward[i]->get_key() <= key) {
            if (current->forward[i]->get_key() == key)
                return current->forward[i]->get_value();
            current = current->forward[i];
        }
    }

    std::cout<<"not find key="<<key<<std::endl;
    return NULL;
}*/
template<typename K, typename V>
V SkipList<K, V>::search(K key) {
    Node<K, V>* current = _header;

    for (int i = _skip_list_level; i >= 0; i--) {
        Block<K, V>* block = current->forward_blocks[i];

        int index = 0;int bsize=block->keys.size();
        while(index<bsize&&block->keys[index]<=key) index++;
        index--;

        current = block->nodes[index];
        if (block->keys[index] == key) {
            return current->get_value();
        }  
        // 否则，进入下一层继续查找
    }
    std::cout << "not find key=" << key << std::endl;
    return V(); // 返回默认值
}

template<typename K, typename V>
V SkipList<K, V>::search2(K key) {
    Node<K, V>* current = _header;
    
    for (int i = _skip_list_level; i >= 0; i--) {
        Block<K, V>* block = current->forward_blocks[i];

           // 使用二分搜索查找 key 的位置
        auto it = std::upper_bound(block->keys.begin(), block->keys.end(), key);
        int index = it - block->keys.begin() - 1;

        current = block->nodes[index];
        if (block->keys[index] == key) {
            return current->get_value();
        }  
        // 否则，进入下一层继续查找
    }
    std::cout << "not find key=" << key << std::endl;
    return V(); // 返回默认值
}
template<typename K,typename V>
void init_vec(Node<K,V>*** nodevc,Node<K,V>* source,int length)
{
    for(int k=0;k<length;k++)
    {
        (*nodevc)[k] =source;
    }
}

/*template<typename K,typename V>
void init_block(Block<K,V>*** nodevc,Block<K,V>* source,int length)
{
    for(int k=0;k<length;k++)
    {
        (*nodevc)[k] =source;
    }
}*/

template<typename K,typename V>
/*
    装载函数
*/
void SkipList<K,V>::bulkload(std::vector<std::pair<std::pair<K,V>,double>> vec)
{
    std::srand(time(NULL));
    this->_element_count =vec.size();

    for (int i = 0; i <= _max_level; i ++)
    {
        double p_threshold = ((1ul << i*key_of_thresholds) - 1.0) / _element_count;
        p_thresholds.push_back(p_threshold);
        // std::cout << i << " : " << p_threshold << std::endl;
    }

    Node<K,V>** level_current =new Node<K,V>*[_max_level+1];//得到每一层当前的最后一个元素(初始为header)
    Block<K,V>** current_blocks=new Block<K,V>*[_max_level+1];
    int i=0;
    Node<K,V>* new_node;
    Block<K,V>* new_block;
    int random_level;
    init_vec(&level_current,this->_header,_max_level+1);
    //init_block(&current_blocks,this->_block_header,_max_level+1);
    for(int i=0;i<=_max_level;i++) current_blocks[i]=_header->forward_blocks[i];


    for(int i=0;i<this->_element_count;i++)
    {
        random_level =get_random_level(vec[i].second);
        new_node =new Node<K,V>(vec[i].first.first,vec[i].first.second,random_level,vec[i].second);
        memset(new_node->forward,0,sizeof(Node<K, V>**)*(random_level+1));
        memset(new_node->forward_blocks,0,sizeof(Block<K, V>**)*(random_level+1));
        if(this->_skip_list_level<random_level)
        {
            _skip_list_level=random_level;
        }//如果最大高度更大则新增层
        for(int j =0;j<=random_level;j++)
        {
            level_current[j]->forward[j] = new_node;//更新插入层最后一个节点的后继
            level_current[j] = new_node;//更新最后一个节点的记录
            if(j==random_level) 
            {
                current_blocks[j]->nodes.push_back(new_node);
                current_blocks[j]->keys.push_back(new_node->get_key());
            }
            if(j>0)
            {
                new_block=new Block<K,V>(new_node,j-1,nullptr);
                current_blocks[j-1]->next=new_block;
                current_blocks[j-1]=new_block;
                new_node->forward_blocks[j-1]=current_blocks[j-1];
            }
        }
    }
    //_header->forward_blocks[_skip_list_level]=current_blocks[_skip_list_level];
    delete[] level_current;

    std::cout<<"bulk load end"<<std::endl;
    this->block_info();
}
template<typename K,typename V>

SkipList<K,V>::SkipList(int max_level)
{
    this->_max_level=max_level;
    this->_skip_list_level=0;
    this->_element_count=0;
    K k=0;
    V v;
    this->_header=new Node<K,V>(k,v,_max_level,0);//头节点在最高层级
    //this->_block_header=new Block<K,V> (this->_header,_max_level,nullptr);
    // 初始化 _header 的 forward_blocks
    for (int i = 0; i <= _max_level; i++) {
        this->_header->forward_blocks[i] = new Block<K, V>(this->_header, i, nullptr);
    }
};
template<typename K,typename V>

SkipList<K,V>::SkipList(int maxlevel, int k_of_thresholds, int k_of_getlevel)
{
    this->_max_level=maxlevel;
    this->key_of_thresholds=k_of_thresholds;
    this->key_of_getlevel=k_of_getlevel;
    this->_skip_list_level=0;
    this->_element_count=0;
    K k=0;
    V v;
    this->_header=new Node<K,V>(k,v,_max_level,0);//头节点在最高层级
    //this->_block_header=new Block<K,V> (this->_header,_max_level,nullptr);
    // 初始化 _header 的 forward_blocks
    for (int i = 0; i <= _max_level; i++) {
        this->_header->forward_blocks[i] = new Block<K, V>(this->_header, i, nullptr);
    }
    std::cout<<this->_max_level<<" "<<this->key_of_thresholds<<" "<<this->key_of_getlevel<<std::endl;
};
//释放内存，关闭_file_writer  _file_reader
template<typename K,typename V>
SkipList<K,V>::~SkipList()
{
    if(_file_writer.is_open())
    {
        _file_writer.close();
    }
    if(_file_reader.is_open())
    {
        _file_reader.close();
    }
    //删除内部节点
    Node<K,V>* current =_header;
    Node<K,V>* next = _header->forward[0];
    while (next!=NULL)
    {
        delete current;
        current =next;
        next =next->forward[0];
    }
}
//生成一个随机层级。从第一层开始，每一层以 50% 的概率加入
template<typename K,typename V>
int SkipList<K,V>::get_random_level(double p)
{
    int level = 0;
    for (int i = 1; i <= _max_level; i ++)
    {
        if (p >= p_thresholds[level + 1] || !(std::rand() % key_of_getlevel) )
            level ++;
        else
            break;
    }
    return level;
};
#endif