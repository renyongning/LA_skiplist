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
static uint32_t MAX_LEVEL;
//std::mutex mtx;  //代表互斥锁 ，保持线程同步
std::string delimiter=":";  //存放到STORE_FILE中时，将delimiter也存入进文件中，用于get_key_value_from_string的key与value区分
template<typename K,typename V>
class SkipList;
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
    int node_level;//所在的层次
private:
     K key;
     V value;
     double p;
    friend class SkipList<K,V>;
};
template<typename K,typename V>
Node<K,V>::Node(const K k, const V v, int level,double p)
{
    this->key=k;
    this->value=v;
    this->p =p;
    this->node_level=level;
    this->forward=new Node<K,V> *[MAX_LEVEL+1];//level从0开始，+1得到储存包
    memset(this->forward,0,sizeof(Node<K,V>*)*(MAX_LEVEL+1));
};
template<typename  K,typename V>
Node<K,V>::~Node()
{
    delete []forward;
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
    SkipList(int =63);
    ~SkipList();
    int get_random_level(double p);
    Node<K,V>*create_node(K,V,int,double);
    int insert(K,V,double);
    int insert2(K,V,double);//与get_random_level2构成第二种插入方案
    int get_random_level2(double p);
    void display_list();
    void delete_element(K);
    V search(K);
    void dump_file();
    void load_file();
    void rehash(std::vector<std::pair<std::pair<K,V>,double>>);//根据新的概率分布重构
    void rehash();//针对当前的分布重构
    int size();
    std::pair<int,int> size_of_skiplists()
    {
        return std::pair<int,int>(this->first_skiplist_number,this->second_skiplist_number);
    }//返回两个链表的数量
    bool is_empty()
    {
        if(this->_element_count==0) return false;
        return true;
    }
    bool bulkload(std::vector<std::pair<std::pair<K,V>,double>>);
private:
    void get_key_value_from_string(const std::string &str,std::string*key,std::string *value);
    bool is_valid_string(const std::string &str);
    uint64_t findTableSizeof2(const uint64_t target);//得到一个数向下舍入后的二的平方数
private:
    int _max_level;              //跳表的最大层级，从0开始
    int _skip_list_level;        //当前跳表的有效层级
    int second_skip_list_level;//第二个跳表的有效层级
    Node<K,V> *_header;          //表示跳表的头节点
    Node<K,V>* second_header;//第二个普通跳表的头节点
    std::ofstream _file_writer;  //默认以输入(writer)方式打开文件。
    std::ifstream _file_reader;  //默认以输出(reader)方式打开文件。
    uint64_t _element_count;          //表示跳表中元素的数量
    uint64_t first_skiplist_numnber;//第一个跳表中的元素数量
    uint64_t second_skiplsit_number;//第二个跳表中的元素数
    friend class Node<K,V>;
    
};

//create_node函数：根据给定的键、值和层级创建一个新节点，并返回该节点的指针
template<typename K,typename V>
Node<K,V> *SkipList<K,V>::create_node(const K k, const V v, int level,double p)
{
    Node<K,V>*n=new Node<K,V>(k,v,level,p);
    return n;
}

//insert_element 函数：插入一个新的键值对到跳表中。通过遍历跳表，找到插入位置，并根据随机层级创建节点。
//如果键已存在，则返回 1，表示插入失败；否则，插入成功，返回 0。
template<typename K,typename V>
int SkipList<K,V>::insert(const K key,const  V value,double p)
{
    //mtx.lock();
    Node<K,V> *update[_max_level];
    Node<K,V> *current;
    Node<K,V>*header;
    uint64_t *num;
    int* skip_list_level;
    if(p>=1/(double)((uint64_t(1)<<this->_max_level)))
    {
        current =this->_header;
        header =this->_header;
        num =&first_skiplist_numnber;
        skip_list_level =&_skip_list_level;
    }
    else
    {
        current = this->second_header;
        header =this->second_header;
        num =&second_skiplsit_number;
        skip_list_level =&second_skip_list_level;
    }//选择插入哪一个跳表
    memset(update,0,sizeof(Node<K,V>*)*(_max_level));
    //99-113行-为查找key是否在跳表中出现，也可以直接调用search_element(K key)
    for(int i=*skip_list_level;i>=0;i--)
    {
        while(current->forward[i]!=NULL&&current->forward[i]->get_key()<=key)//同一层级的下一个指针不为空并且值小于查询值
        {
            current=current->forward[i];
        }
        update[i]=current;   //update是存储每一层需要插入点节点的位置
    }
    if(current!=NULL&&current->get_key()==key)
    {
        //std::cout<<"key:"<<key<<",exists"<<std::endl;
        //mtx.unlock();
        return 1;
    }

    //添加的值没有在跳表中
    if(current==NULL||current->get_key()!=key)
    {
        int random_level=get_random_level(p);
        if(random_level>*skip_list_level)
        {
            for(int i=*skip_list_level+1;i<random_level+1;i++)
            {
                update[i]=header;
            }
            *skip_list_level=random_level;
        }
        Node<K,V>*inserted_node= create_node(key,value,random_level,p);
        for(int i=0;i<random_level;i++)
        {
            inserted_node->forward[i]=update[i]->forward[i];  //跟链表的插入元素操作一样
            update[i]->forward[i]=inserted_node;
        }
        //std::cout<<"Successfully inserted key:"<<key<<",value:"<<value<<std::endl;
        _element_count++;
        (*num)++;
    }
    //mtx.unlock();
    return 0;
}
//insert2:实现第二种动态插入的方法(这个策略对于多线程不友好)
template<typename K,typename V>
int SkipList<K,V>::insert2(K key,V value,double p)
{
    Node<K,V> *update[_max_level];
    Node<K,V> *current;
    Node<K,V>*header;
    uint64_t *num;
    int* skip_list_level;
    if(p>=0)
    {
        current =this->_header;
        header =this->_header;
        num =&first_skiplist_numnber;
        skip_list_level =&_skip_list_level;
    }
    else
    {
        current = this->second_header;
        header =this->second_header;
        num =&second_skiplsit_number;
        skip_list_level =&second_skip_list_level;
    }//选择插入哪一个跳表(目前来看这两种方法都无法正常在insert中实现A2方法)
    memset(update,0,sizeof(Node<K,V>*)*(_max_level));
    //99-113行-为查找key是否在跳表中出现，也可以直接调用search_element(K key)
    for(int i=*skip_list_level;i>=0;i--)
    {
        while(current->forward[i]!=NULL&&current->forward[i]->get_key()<=key)//同一层级的下一个指针不为空并且值小于查询值
        {
            current=current->forward[i];
        }
        update[i]=current;   //update是存储每一层需要插入点节点的位置
    }
    if(current!=NULL&&current->get_key()==key)
    {
        //std::cout<<"key:"<<key<<",exists"<<std::endl;
        //mtx.unlock();
        return 1;
    }
    this->_element_count++;//先增加数量
    if(!(this->_element_count&(this->_element_count-1)))//如果增加数量后达到二的n次方，则将跳表中现有的元素全部层数+1
    {
        Node<K,V>** record = new Node<K,V>*[this->_max_level+1];//用于记录第i层目前遍历到的最新节点
        init_vec(&record,header,this->_max_level+1);//初始化为头指针
        while(record[0])
        {
            if(record[0]->node_level<_max_level)
            {
                record[0]->node_level++;//增加节点层数
                if(record[0]->node_level>*skip_list_level)
                {
                    *skip_list_level = record[0]->node_level;
                }
                //当前节点的新增加层是目前追踪的这个层次节点的下一个
                record[0]->forward[record[0]->node_level] =record[record[0]->node_level]->forward[record[0]->node_level];
                //当前层次追踪的节点的下一个更新为当前节点
                record[record[0]->node_level]->forward[record[0]->node_level] = record[0];
                //更新record中node_level~1的位置为当前节点,record0为下一个节点
                for(int j=record[0]->node_level;j>0;j--)
                {
                    record[j] =record[0];
                }
                record[0] =record[0]->forward[0];               
            }//如果目前层次小于最高层则进行提升
            else
            {
                record[0] =record[0]->forward[0];
            }//如果层次已经占满则更新record0为下一个节点
        }//顺序遍历所有节点(包括头节点)并作出提升操作
        delete[] record;
        //接下来需要实现更新update的方法(目前就是再search一遍，但是可以优化？)
        if(p>=0)
        {
            current =this->_header;
        }
        else
        {
            current = this->second_header;
        }//选择插入哪一个跳表(目前来看这两种方法都无法正常在insert中实现A2方法)
        memset(update,0,sizeof(Node<K,V>*)*(_max_level));
        //99-113行-为查找key是否在跳表中出现，也可以直接调用search_element(K key)
        for(int i=*skip_list_level;i>=0;i--)
        {
            while(current->forward[i]!=NULL&&current->forward[i]->get_key()<=key)//同一层级的下一个指针不为空并且值小于查询值
            {
                current=current->forward[i];
            }
            update[i]=current;   //update是存储每一层需要插入点节点的位置
        }
    }
    //执行正常的插入操作
    if(current==NULL||current->get_key()!=key)
    {
        int random_level=get_random_level2(p);
        if(random_level>*skip_list_level)
        {
            for(int i=*skip_list_level+1;i<random_level+1;i++)
            {
                update[i]=header;
            }
            *skip_list_level=random_level;
        }
        Node<K,V>*inserted_node= create_node(key,value,random_level,p);
        for(int i=0;i<=random_level;i++)
        {
            inserted_node->forward[i]=update[i]->forward[i];  //跟链表的插入元素操作一样
            update[i]->forward[i]=inserted_node;
        }
        //std::cout<<"Successfully inserted key:"<<key<<",value:"<<value<<std::endl;
        (*num)++;
    }
    return 0;
}
//display_list函数：输出跳表包含的内容、循环_skip_list_level(有效层级)、从_header头节点开始、结束后指向下一节点
template<typename K,typename V>
void SkipList<K,V>::display_list()
{
    std::cout<<"\n*****FIRST SkipList*****"<<"\n";
    for(int i=0;i<=_skip_list_level;i++)
    {
        Node<K,V>*node=this->_header->forward[i];
        std::cout<<"Level"<<i<<":";
        while(node!=NULL)
        {
            std::cout<<node->get_key()<<":"<<node->get_value()<<";";
            node=node->forward[i];
        }
        std::cout<<std::endl;
    }
    std::cout<<"\n********normal skiplist/n";
    for(int i=0;i<=second_skip_list_level;i++)
    {
        Node<K,V>*node=this->second_header->forward[i];
        while(node!=NULL)
        {
            std::cout<<node->get_key()<<":"<<node->get_value()<<";";
            node=node->forward[i];
        }
        std::cout<<std::endl;
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
    memset(update,0,sizeof(Node<K,V>*)*(_max_level+1));
    for(int i=_skip_list_level;i>=0;i--)
    {
        while(current->forward[i]!=NULL&&current->forward[i]->get_key()<key)
        {
            current=current->forward[i];
        }
        update[i]=current;
    }
    current=current->forward[0];
    if(current!=NULL&&current->get_key()==key)
    {
        for(int i=0;i<=_skip_list_level;i++) {
            if (update[i]->forward[i] != current) {
                break;
            }
            update[i]->forward[i] = current->forward[i];
        }
            while(_skip_list_level>0&&_header->forward[_skip_list_level]==0)
            {
                _skip_list_level--;
            }
            std::cout<<"Successfully deleted key"<<key<<std::endl;
            _element_count--;
    }
    //mtx.unlock();
    return ;
}

//遍历每一层，从顶层开始，找到每层对应的位置，然后进入下一层开始查找，直到查找到对应的key
//如果找到return true 输出Found  否则 return false ，输出Not Found
template<typename K,typename V>
V SkipList<K,V>::search(K key)
{
    //std::cout<<"search_element------------"<<std::endl;
    //首先在第一层跳表中寻找
    Node<K,V> *current=_header;
    for(int i=_skip_list_level;i>=0;i--)
    {
        while(current->forward[i]&&current->forward[i]->get_key()<=key)
        {
            if(current->forward[i]->key==key)
            {
                return current->forward[i]->value;
            }//找到目标节点后立刻退出
            current=current->forward[i];
        }
    }
    //如果没有则在第二层跳表中寻找
    current = second_header;
    for (int i = second_skip_list_level; i >= 0; i--)
    {
        while (current->forward[i] && current->forward[i]->get_key() <= key)
        {
            if(current->forward[i]->value==key)
            {
                return current->forward[i]->value;
            }//找到目标节点后立刻退出
            current = current->forward[i];
        }
    }
    return NULL;//没有找到
}
template<typename K,typename V>
void init_vec(Node<K,V>*** nodevc,Node<K,V>* source,int length)
{
    for(int k=0;k<length;k++)
    {
        (*nodevc)[k] =source;
    }
}
template<typename K,typename V>
/*
    装载函数
*/
bool SkipList<K,V>::bulkload(std::vector<std::pair<std::pair<K,V>,double>> vec)
{
    if(is_empty()) return false;
    std::srand(time(NULL));
    this->_element_count =vec.size();
    Node<K,V>** _level_current =new Node<K,V>*[_max_level+1];//得到每一层当前的最后一个元素(初始为header)
    Node<K,V>** _second_list_level_curent = new Node<K,V>*[_max_level+1];//第二个跳表的levelcurrent
    init_vec(&_level_current,this->_header,_max_level+1);
    init_vec(&_second_list_level_curent,this->second_header,_max_level+1);//初始化为头指针
    Node<K,V>* new_node;
    int random_level;
    int* skip_list_level;
    Node<K,V>*** level_current;//对_level_current或者_second_list_level_current的pointer
    for(int i=0;i<this->_element_count;i++)
    {
        
        if(vec[i].second>=double(1)/this->_element_count)
        {
            level_current =&_level_current;
            skip_list_level =&_skip_list_level;
        }
        else
        {
            level_current =&_second_list_level_curent;
            skip_list_level =&second_skip_list_level;
        }//选择插入哪一个跳表
        random_level =get_random_level(vec[i].second);
        new_node =new Node<K,V>(vec[i].first.first,vec[i].first.second,random_level,vec[i].second);
        //memset(new_node->forward,0,sizeof(Node<K, V>**)*(random_level+1));
        if(*skip_list_level<random_level)
        {
            *skip_list_level=random_level;
        }//如果最大高度更大则新增层
        for(int j =0;j<=random_level;j++)
        {
            (*level_current)[j]->forward[j] = new_node;//更新插入层最后一个节点的后继
            (*level_current)[j] = new_node;//更新最后一个节点的记录
        }
    }
    delete[] _level_current;
    delete[] _second_list_level_curent;
    return true;
}
template<typename K,typename V>

SkipList<K,V>::SkipList(int max_level)
{
    this->_max_level=max_level;
    MAX_LEVEL =max_level;
    this->_skip_list_level=0;
    this->second_skip_list_level =0;
    this->_element_count=0;
    K k;
    V v;
    this->_header=new Node<K,V>(k,v,_max_level,0);//头节点在最高层级
    this->second_header =new Node<K,V>(k,v,_max_level,0);//下方普通链表的头节点
    std::srand(time(NULL));
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
        current =next;
        next =current->forward[0];
        delete current;
    }
    current = second_header;
    next = second_header->forward[0];
    while (next!=NULL)
    {
        current =next;
        next =current->forward[0];
        delete current;
    }
    delete _header;
    delete second_header;
}
template<typename K,typename V>
uint64_t SkipList<K,V>::findTableSizeof2(const uint64_t target)
{
    uint64_t temp = target -1;
    temp |= temp >> 1;
    temp |= temp >> 2;
    temp |= temp >> 4;
    temp |= temp >> 8;
    temp |= temp >> 16;
    temp |=temp >>32;
    temp+=1;
    return !(target&(target-1))?target:temp>>1;
}
//生成一个随机层级。从第一层开始，每一层以 50% 的概率加入
template<typename K,typename V>
int SkipList<K,V>::get_random_level(double p)
{
    int level = 1;
    uint64_t n =uint64_t(1)<<this->_max_level;
    double target = (((uint64_t)1<<(level-1))/double(n));
    while ((std::rand()%2||(p>=target)) && level < _max_level)
    {
        level += 1;
        target =((((uint64_t)1<<level)-1)/double(n));
    }
        
    level=(level<_max_level)?level:_max_level;
    return level;
}
template<typename K,typename V>
int SkipList<K,V>::get_random_level2(double p)
{
    int level =1;
    uint64_t n =findTableSizeof2(_element_count);//得到向下舍入的二的平方数
    double target = (((uint64_t)1<<(level-1))/double(_element_count));
    while ((std::rand()%2||(p>=target)) && level < _max_level)
    {
        level += 1;
        target =((((uint64_t)1<<level)-1)/double(n));
    }
        
    level=(level<_max_level)?level:_max_level;
    return level;
}
#endif