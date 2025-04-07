#include <iostream>
#include <vector>
#include <cmath> // for std::fabs
// 请确保你自己的工程中包含 PGM-index 的头文件路径
#include "PGM-index/include/pgm/piecewise_linear_model.hpp"
template<typename K, typename V>
class Block
{
public:
    std::vector<K> keys;

    double slope{0.0};      // 线性模型的斜率
    double intercept{0.0};  // 线性模型的截距
    size_t max_err{0};      // 线性模型的最大偏差(实际观测到的误差)
    
    Block *next; // Pointer to the next block at the same level
    int block_level;//block所在的层次

    Block(size_t size) {
        keys.reserve(size);
    }

    Block(std::vector<K> keyss) {
        keys=keyss;
    }
    /**
     * @brief 根据当前 Block 中的 keys，构建一个线性预测模型，满足不超过给定误差 M 的最大范围。
     *        从 M 开始向 0 递减，如果能够用单条线段拟合所有 keys，则记录下该段的 slope/intercept/max_err；
     *        如果在某个 M 失败，就用最后一次成功时的参数作为最终模型。
     * 
     * @param M 误差允许的最大上界
     */
    void buildLinearModel(int M) {
        // 如果 keys 为空或只有一个点，直接处理
        if (keys.size() <= 1) {
            slope = 0.0;
            intercept = 0.0;
            max_err = 0; 
            return;
        }

        // 临时变量，记录“最后一次成功”的模型参数
        double best_slope = 0.0;
        double best_intercept = 0.0;
        size_t best_maxerr = 0;
        int best_M = -1;  // 用来标记有没有成功过

        // 从 M 开始，一直尝试到 0
        for (int m = M; m >= 0; --m) {
            // 1) 用当前 m 构造一个模型
            pgm::internal::OptimalPiecewiseLinearModel<K,int> model(m);

            // 2) 依次往模型里加点 (x = keys[i], y = i)
            bool canFit = true;
            for (size_t i = 0; i < keys.size(); i++) {
                if (!model.add_point(keys[i], static_cast<int>(i))) {
                    canFit = false;
                    break;
                }
            }

            if (canFit) {
                // 3) 如果可以拟合，则获取它的线段
                auto seg = model.get_segment();
                // 这里 origin=0 让我们拿到 slope/intercept 即 y = slope*(x-0) + intercept
                auto [temp_slope, temp_intercept] = seg.get_floating_point_segment(0);

                // 5) 记录到“最后一次成功”的模型参数
                best_slope    = temp_slope;
                best_intercept= temp_intercept;
                best_maxerr   = m;
            }
            else {
                // 一旦失败，说明当前 m 以及后续更小的 m 都很可能无法成功，
                // 因为误差要求更严格了，所以就直接跳出
                break;
            }
        }

        // 循环结束后，如果 best_M >= 0，代表至少有一次成功
        // 就把那次的模型参数写入本 Block
        if (best_maxerr >= 0) {
            this->slope     = best_slope;
            this->intercept = best_intercept;
            this->max_err   = best_maxerr; // 观测到的“实际最大误差”
            std::cout<<"slope = "<<slope<<" intercept = "<<intercept<<" max_err = "<<max_err<<std::endl;
        } else {
            // 如果从头到尾都失败，就给一个默认值
            // 这里可以视需求给定，也可以抛出异常
            this->slope     = 0.0;
            this->intercept = 0.0;
            this->max_err   = 999999; // 表示无法拟合
        }
    }
   /**
     * @brief 搜索给定的 key，返回其 lower bound 的下标（即第一个 >= key 的位置）。
     * 
     * 1) 如果 max_err == 999999 (未成功构建模型)，则顺序遍历。
     * 2) 否则，根据 (slope, intercept) 预测下标，再在 [pred - max_err, pred + max_err] 范围里线性搜索lower bound。
     */
    size_t search(const K &searchKey) const {
        // 如果根本没有成功构建模型，就做顺序查找
        if (max_err == 999999) {
            // 线性扫一遍，找到第一个 >= searchKey 的位置
            size_t i = 0;
            for (; i < keys.size(); i++) {
                if (keys[i] >= searchKey) {
                    return i;
                }
            }
            return i; // 若都 < searchKey，则返回 size()
        }

        // ------------------------------
        // 已成功构建模型，先计算预测下标
        // y = slope * key + intercept
        // 这里用四舍五入来获取最接近的整数下标
        long long pred_idx = static_cast<long long>(
            std::llround(slope * static_cast<long double>(searchKey) + intercept)
        );

        // 然后在 [pred_idx - max_err, pred_idx + max_err] 范围顺序搜索 lower bound
        // 注意要做边界裁剪
        long long start = pred_idx - static_cast<long long>(max_err);
        long long end   = pred_idx + static_cast<long long>(max_err);

        // 裁剪到 [0, keys.size()-1]
        if (start < 0) start = 0;
        if (end >= static_cast<long long>(keys.size())) {
            end = static_cast<long long>(keys.size()) - 1;
        }
        while(start<=end&&keys[start]<=searchKey)
        {
            start ++;
        }

        return (start-1);
    }
};

int main() {
    // 假设你想要拟合的 keys
    std::vector<int> keys = {1, 2, 4, 5, 7, 8, 10, 11};

    Block<int,int> blk = Block<int,int>(keys);
    // 给定一个误差上界的初始值
    int M = 10;  
    blk.buildLinearModel(M);
    for(auto it:keys)
    {
        std::cout<<blk.search(it)<<std::endl;
    }
    std::cout<<"after build"<<std::endl;
    return 0;
}
