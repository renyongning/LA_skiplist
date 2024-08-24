#include <iostream>
#include <vector>
#include <stack>
#include <random>
#include <limits.h>
#include <time.h>
#include <chrono>
#include <numeric>   // For std::accumulate
#include <algorithm> // For std::min_element and std::max_element
using namespace std;
class Block;

class Node
{
public:
    ulong key;
    ulong value;
    Block *down; // Pointer to lower level block contains same value
    Node(ulong key, ulong value, Block *down)
    {
        this->key = key;
        this->value = value;
        this->down = down;
    }
};

class Block
{
public:
    std::vector<Node*> vector;
    Block *next; // Pointer to the next block at the same level
    Block(Node* node, Block *next)
    {
        vector.push_back(node);
        // vector.resize(3); // minimum size of each block
        this->next = next;
    }

    Block(std::vector<Node*> vector, Block *next)
    {
        this->vector = vector;
        // vector.resize(3); // minimum size of each block
        this->next = next;
    }

    void print()
    {
        for (unsigned int i = 0; i < vector.size(); i++)
        {
            std::cout << vector[i]->key;
            if (vector[i]->down)
                std::cout << "(" << vector[i]->down->vector[0]->key << ")";
            std::cout << " ";
        }
        std::cout << "| ";
    }
};

class BSkipList
{
private:
    int max_level;
    int element_count;
    std::vector<double> p_thresholds;
    std::vector<Block *> levels; // Vector of head blocks from each level
    std::stack<Block *> getBlockStack(ulong key)
    {
        int lvl = levels.size() - 1;
        Block *current = levels[levels.size() - 1]; // starting from first block in higest level
        std::stack<Block *> blocks;                 // store the path
        Block *block = current;                     // keep track the place for value
        Node *prev;
        while (current)
        {
            bool found = false;
            // find a value greater than insert value
            for (unsigned int i = 0; i < current->vector.size(); i++)
            {
                if (key > current->vector[i]->key)
                { // go to next node
                    prev = current->vector[i];
                }
                else
                { // find the place
                    blocks.push((block));
                    current = prev->down;
                    lvl--;
                    block = current;
                    found = true;
                    break;
                }
            }

            if (!found)
            {
                // keep looking in next block
                if (current->next)
                {
                    current = current->next;
                    // last in current block
                    if (key < current->vector[0]->key)
                    {
                        blocks.push(block);
                        current = prev->down;
                    }
                }
                else // last in this level
                    blocks.push(current);
                current = prev->down;
            }
            block = current;
        }
        return blocks;
    }

public:
    int r = 1;
    const float P_FACTOR = 0.25;
   
    // const int MAX_LEVEL = 32;
    // const float P_FACTOR = 0.25;
    // static std::random_device rd; // obtain a random number from hardware
    // static std::mt19937 gen(rand()); // seed the generator
    // static std::uniform_real_distribution<> distr(0, 1); // define the range
    BSkipList(int max_level = 31)
    {
        this->max_level = max_level;
        this->element_count = 0;
        Block *block = new Block(new Node(0, 0, nullptr), nullptr); // negative infinity block
        levels.push_back(block);
    }

    ~BSkipList()
    {
        // Destructor to free memory
        // ... (cleanup logic here)
    }

    void insert(ulong key, ulong value)
    {
        srand(time(NULL)); // initialize random seed
        std::stack<Block *> blocks = getBlockStack(key);
        Block *lower = nullptr;
        // building block from botton
        while (!blocks.empty())
        {
            bool inserted = false;
            Block *block = blocks.top();
            blocks.pop();
            for (unsigned int i = 0; i < block->vector.size(); i++)
            {
                if (block->vector[i]->key > key)
                { // in the middle of the vector
                    // (static_cast<float>(rand()) / RAND_MAX) < P_FACTOR)
                    if (r % 2 != 0)
                    { // tail
                        r = r + rand();
                        block->vector.insert(block->vector.begin() + i, new Node(key, value, lower));
                        return;
                    }
                    else
                    { // head
                        r++;
                        // split and shrink block
                        std::vector<Node *> right;
                        right.push_back(new Node(key, value, lower));
                        for (unsigned int j = i; j < block->vector.size(); j++)
                            right.push_back(block->vector[j]);
                        block->vector.resize(i);
                        Block *rightBlock = new Block(right, block->next);
                        block->next = rightBlock;
                        // new level
                        if (blocks.empty())
                        {
                            Block *up = new Block(new Node(0, 0, block), nullptr);
                            up->vector.push_back(new Node(key, value, block->next));
                            levels.push_back(up);
                        }
                        inserted = true;
                        lower = block->next;
                        break;
                    }
                }
            }
            if (!inserted)
            {
                // at the end of the vector
                if (r % 2 != 0)
                { // tail
                    r = r + 1;
                    block->vector.push_back(new Node(key, value, lower));
                    return;
                }
                else
                { // head
                    r = r + rand();
                    Block *newBlock = new Block(new Node(key, value, lower), block->next);
                    block->next = newBlock;
                    // new level
                    if (blocks.empty())
                    {
                        Block *up = new Block(new Node(0, 0, block), nullptr);
                        up->vector.push_back(new Node(key, value, newBlock));
                        levels.push_back(up);
                    }
                    lower = newBlock;
                }
            }
        }
    }

    void remove(ulong key)
    {
        std::stack<Block*> blocks = getBlockStack(key);
        Block *current;
        Block *block;
        vector<Block*> update;
        Block *curr = nullptr;
        bool flag = false;
        for (int i = levels.size() - 1; i >= 0; i--)
        {
            Block *pre = nullptr;
            curr = levels[i];
            while (curr)
            {
                for (int j = 0; j < curr->vector.size(); j++)
                {
                    if (curr->vector[j]->key == key)
                    {
                        if (pre)
                        {
                            flag = true;
                            update.push_back(pre);
                            // cout << pre->vector[0]->value << "pre" << endl;
                        }
                        break;
                    }
                }
                if (flag)
                {
                    flag = false;
                    break;
                }

                pre = curr;
                curr = curr->next;
            }
        }

        // for (int i = 0; i < update.size(); i++)
        // {
        //     cout << update[i]->vector[0]->value << "update" << endl;
        //     if (update[i]->next)
        //     {
        //         cout << update[i]->next->vector[0]->value << "update next" << endl;
        //         if(update[i]->next->vector.size() > 1){
        //             cout << update[i]->next->vector[1]->value << "test" << endl;
        //         }
        //     }
        // }
        int x = 0;
        while (!blocks.empty())
        {
            block = blocks.top();
            blocks.pop();

            for (unsigned int i = 0; i < block->vector.size(); i++)
            {
                if (block->vector[i]->key == key)
                {
                    Block *downBlock = block->vector[i]->down;
                    block->vector.erase(block->vector.begin() + i);

                    while (downBlock != nullptr)
                    {
                        current = downBlock->vector[0]->down;
                        downBlock->vector.erase(downBlock->vector.begin());
                        if (!downBlock->vector.empty())
                        {
                            update[x]->vector.insert(update[x]->vector.end(), downBlock->vector.begin(), downBlock->vector.end());
                            update[x]->next = update[x]->next->next;
                            x++;
                        }
                        else
                        {
                            update[x]->next = update[x]->next->next;
                            x++;
                        }

                        downBlock = current;
                    }
                }
            }
        }
    }

    void print_list()
    {
        Block* curr;
        for (int i = levels.size() - 1; i >= 0; i--)
        {
            Block *pre = nullptr;
            curr = levels[i];
            while (curr)
            {
                for (int j = 0; j < curr->vector.size(); j++)
                {

                    cout << curr->vector[j]->key << " ";
                    if (curr->vector[j]->down)
                    {
                        cout << "(" << curr->vector[j]->down->vector[0]->key << ")";
                    }
                }
                curr = curr->next;
                cout << "|";
            }
            cout << " " << endl;
        }
    }

    std::vector<int> getAverageSize()
    {
        Block* curr;
        vector<int> sizes;
        for (int i = levels.size() - 1; i >= 0; i--)
        {
            Block *pre = nullptr;
            curr = levels[i];
            while (curr)
            {
                sizes.push_back(curr->vector.size());
                curr = curr->next;
            }
        }
        return sizes;
    }

    ulong search(ulong key)
    {
        std::vector<Node *>::iterator it;
        Node *node;
        Node *prev_node;
        Block *block = levels[levels.size() - 1];

        while (block)
        {
            for (it = block->vector.begin(); it != block->vector.end(); ++it)
            {
                node = *it;
                if (node->key < key)
                {
                    prev_node = node;
                    if (node == *std::prev(block->vector.end()))
                    {
                        block = block->next;
                        break;
                    }
                    else
                    {
                        continue;
                    }
                }
                else if (node->key == key)
                {
                    return node->value;
                }
                else if (key < node->key)
                {
                    block = prev_node->down;
                    break;
                }
                // else if (i == 0) {return false;}
            }
        }
        // }
        // std::cout << "Not Found Key:" << key << std::endl;
        return 0;
    }

    std::vector<bool> range_query(ulong start_key, ulong end_key)
    {
        std::vector<bool> output;
        for (ulong key = start_key; key < end_key; key++)
        {
            ulong value = search(key);
            if (value != 0)
            {
                output.push_back(value);
            }
        }
        return output;
    }

    void bulkload(std::vector<std::pair<std::pair<ulong,ulong>,double>> vec)
    {
        std::srand(time(NULL));
        this->element_count = vec.size();
        std::vector<Block*> level_current(max_level + 1, nullptr);
        
        for(int i=0; i<=max_level; i++)
        {
            double p_threshold = ((1ul << i) - 1.0) / element_count;
            p_thresholds.push_back(p_threshold);
        }

        for(int i=0; i<this->element_count; i++)
        {
            double p = vec[i].second;
            int level = get_random_level(p);

            Block *lower = nullptr;
            // insert nodes from the bottom to the "level" layer
            for(int j=0; j<=level; j++)
            {
                Node* new_node = new Node(vec[i].first.first, vec[i].first.second, lower);
                // the current layer is empty
                if(level_current[j] == nullptr)
                {
                    level_current[j] = new Block(new Node(0, 0, nullptr), nullptr); 
                    if(j==0)
                        levels.push_back(level_current[j]);
                    else if(levels.size() <= j)
                        levels.push_back(new Block(new Node(0, 0, nullptr), nullptr));
                }

                // level_current[j]->vector.push_back(new_node);
                // check if there's need to split
                if (r % 2 != 0)
                    { // tail
                        r = r + rand();
                        level_current[j]->vector.push_back(new_node);
                    }
                    else
                    { // head
                        r++;
                        // split and shrink block
                        std::vector<Node *> right;
                        right.push_back(new_node);
                        // for (unsigned int j = i; j < level_current[j]->vector.size(); j++)
                        //     right.push_back(level_current[j]->vector[j]);
                        // block->vector.resize(i);
                        Block *rightBlock = new Block(right, level_current[j]->next);
                        level_current[j]->next = rightBlock;
                        // new level
                       
                            Block *up = new Block(new Node(0, 0, level_current[j]), nullptr);
                            up->vector.push_back(new Node(vec[i].first.first, vec[i].first.second, level_current[j]->next));
                            levels.push_back(up);
                    
                        lower = level_current[j]->next;
                    }
            }
        }
    }

    int get_random_level(double p)
    {
        int level = 0;
        for(int i=1; i<=max_level; i++)
        {
            if(p >= p_thresholds[level+1] || std::rand() % 2)
                level++;
            else
                break;
        }
        return level;
    }

    int getHeight(){
        return levels.size();
    }
};
