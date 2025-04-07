2025-2-21

更新了mytest文件夹,使用自己写的测试对比了bskiplist和btree

- mytest/easytest.cpp 简单的测试了bskiplist的插入和删除,Block结构不会被插入和删除破坏
  - 测试方法:`g++ -o easytest easytest.cpp`  `./easytest`
- mytest/test.cpp 测试了bskiplist和btree的search效率,测试利用的keys和工作负载来源于wiscer,我修改了wiscer的代码,使得在生成keys时写入到outputs/keys.csv,包括了每个键以及每个键的出现频率,outputs/reqs.txt内容是以空格为分割的被search 的key,通过执行./benchmark.out workloads/test即可生成指定zipf偏斜的查询键值
  - 测试方法:需要先通过wiscer生成keys和reqs写入到outputs/文件,然后编译运行
  - `cd wiscer`
  - `make bskiplist` (可以是随便一个结构)
  - `./benchmark.out workloads/test`
  - `cd ../mytest`
  - `g++ -o test test.cpp`  `./test`

### 测试结果
通过mytest/test.cpp进行测试,发现`不学习工作负载的bskiplist`比`btree` 速度比大概是2:3 ,可以运行randomtest.cpp
`学习工作负载的bskiplist且zipf=1时`(使用workloads/test生成的负载),比`btree`速度比大概是6:5,稍微快一点