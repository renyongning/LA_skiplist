**2024.8.12更新：**

1. 修正了学习增强跳表search操作时存在的一个重大问题，速度翻倍

2. 复现并接入了RobustSL(论文：Robust Learning-Augmented Dictionaries)，暂时只支持bulkload后的静态查询

---

**2024.8.9更新：**

1. 增加了打印当前数据结构的代码，现在进行测试时，会提示当前是哪种数据结构。

2. 修改了代码文件名和类名，原先的代码文件命名比较混乱，类名全都是ChainedHashmap，现在的代码文件名和类名可以更直观地反映其含义

3. 新接入了std::map，即红黑树

4. 调整了目录结构，各种数据结构的代码文件统一放到competitors当中（来自GRE4index项目的想法），如果有额外的依赖则放到dependency当中

5. 修改了Makefile的格式，更简洁一些，加上了-w 和 -Icompetitors 选项

---

现在支持的数据结构如下：

- 普通哈希表<br>
    即competitors/chainedhash.cpp<br>
    用make chainedhash编译

- VIP哈希表<br>
    即competitors/viphash.cpp<br>
    用make viphash编译

- 标准库map，即红黑树<br>
    即competitors/stdmap.cpp<br>
    用make stdmap编译

- 普通跳表<br>
    即competitors/skiplist.cpp<br>
    用make skiplist编译

- 学习增强跳表<br>
    即competitors/ours.cpp<br>
    用make ours编译

- Google LevelDB 底层的跳表实现<br>
    即competitors/leveldb_skiplist.cpp<br>
    用make leveldb_skiplist编译

- stx-btree，即B+树<br>
    即competitors/btee.cpp<br>
    用make btree编译

- RobustSL<br>
    即competitors/robustsl.cpp<br>
    用make robustsl编译

编译成功后，用./benchmark workloads/{具体的工作负载名}进行测试

可以通过：
make store
./benchmark workloads/{具体的工作负载名}
来将具体生成的键和操作保存为keys和ops文件，使用./read_keys和./read_ops打印到屏幕上，数量可以到read_keys.cpp和read_ops.cpp中修改；

在zipf_plot.ipynb当中，画了几个图，可以直观地看出zipf分布


