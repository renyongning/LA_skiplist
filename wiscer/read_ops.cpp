#include <iostream> 
#include <stdio.h> 
#include <fstream>  
  
#define OPS_NUM 500

int main() {  
  
    std::ifstream file("ops", std::ios::binary);  
    if (!file) {  
        std::cerr << "无法打开文件！" << std::endl;  
        return 1;  
    }  

    int n = 0;
    for (int i = 0; i < OPS_NUM; ++i) {  
        char op_code;
        uint64_t key;
        file.read(&op_code, sizeof(op_code));
        file.read(reinterpret_cast<char*>(&key), sizeof(key));  
        if (!file) {  
            std::cerr << "读取错误或文件不包含足够的数据！" << std::endl;  
            break;  
        }  
        n ++;
        printf("%8d | %d | ", n, op_code);
        std::cout << key << std::endl;  
    }  
  
    file.close();  
    return 0;  
}