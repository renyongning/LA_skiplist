#include <iostream> 
#include <stdio.h> 
#include <fstream>  
  
#define KEYS_NUM 1000

int main() {  
  
    std::ifstream file("keys", std::ios::binary);  
    if (!file) {  
        std::cerr << "无法打开文件！" << std::endl;  
        return 1;  
    }  

    int n = 0;
    for (int i = 0; i < KEYS_NUM; ++i) {  
        uint64_t key;  
        file.read(reinterpret_cast<char*>(&key), sizeof(key));  
        if (!file) {  
            std::cerr << "读取错误或文件不包含足够的数据！" << std::endl;  
            break;  
        }  
        n ++;
        printf("%8d | ", n);
        std::cout << key << std::endl;  
    }  
  
    file.close();  
    return 0;  
}