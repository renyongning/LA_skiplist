- 基于zyk分支8月12日的提交的版本，即没有A2算法的LAskiplist，维护了基础的b-skiplist的Block结构
- 参考的论文是The B-Skip-List: A Simpler Uniquely Represented Alternative to B-Trees （Write-Optimized Skip Lists中所用的Bskiplist结构是考虑了write缓冲区的Bskiplist，我们实现的是暂时没有考虑上缓冲区的bskiplist，参考论文为Write-Optimized的一篇引用论文）
- 划分block的逻辑为 第`i`层的`x`个node,会把第`i-1`层的链表划分为`x+1`个Block
- bulkload中实现了构造初始的Block,思路与函数中node的构建类似
- insert函数中,如果insert到不为0的level也会进一步划分Block,同时把该node加入到对应Block

- 数据结构为:
- Node中新增`Block <K,V> ** forward_blocks;`forward_blocks[0]代表第一层中由该node打头的Block,以此类推,范围为 0 ~ node_level-2,即不包含本层的Block信息
- Block结构为
template<typename K,typename V>
class Block
{
    std::vector<Node<K,V> *> nodes; //当前Block包含的node
    Block *next; // 指向当前level的下一个Block
    int block_level;//block所在的层次
}

- 为了方便与最新的更新匹配,保留了所有的原本的Node结构,所以空间还能再优化
- Search还是原本的逻辑(node之间通过指针指来指去),所以现在还没有体现出分块的优势,Block中通过vector存储node,所以改为通过Block进行search可能会更快
- 结构示意图

*****SkipList*****
Level0:   0;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;852;854;856;858;860;
Level1:   11;15;19;
Level2:   15;

*****Block Structure of SkipList*****
Level 0:   [7683896064, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] -> [11, 12, 13, 14] -> [15, 16, 17, 18] -> [19, 852, 854, 856, 858, 860]
Level 1:   [7683896064, 11] -> [15, 19]
Level 2:   [7683896064, 15]

- 可以通俗的理解为：level 1的 3个node，把level 0 的链表分割为 3+1=4个Block
- level 2的 1个node，把level 1 的链表分割为 1+1=2个Block