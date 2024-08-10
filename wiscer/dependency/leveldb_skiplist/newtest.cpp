#include <iostream>
#include "/root/workspace/resource/leveldb/db/memtable.h"


int main()
{
    // 假设你已经有了一个比较器（Comparator）
    const leveldb::InternalKeyComparator comparator(leveldb::BytewiseComparator());

    // 创建 MemTable
    leveldb::MemTable* memtable = new leveldb::MemTable(comparator);

    // 需要为 MemTable 分配内存池
    memtable->Ref();

    // 生成序列号和类型（通常为 kTypeValue 或 kTypeDeletion）
    uint64_t sequence = 1; // 假设这是序列号
    leveldb::ValueType type = leveldb::kTypeValue; // 插入类型

    // 假设有一个键和值
    std::string key = "example_key";
    std::string value = "example_value";

    // 插入到 MemTable 中
    memtable->Add(sequence, type, key, value);

    leveldb::LookupKey lookup_key(key, sequence);
    std::string found_value;
    leveldb::Status s = memtable->Get(lookup_key, &found_value);

    if (s.ok()) {
        // 找到值
        std::cout << "Found value: " << found_value << std::endl;
    } else {
        // 没有找到
        std::cout << "Key not found" << std::endl;
    }

    memtable->Unref();

    return 0;
}