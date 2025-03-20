#!/bin/bash

# 自动化启动程序并使用 perf 采样的脚本

# 设置环境变量
export program_path="./benchmark.out"  
export program_args="workloads/zyk_test 42" 
export sample_time=${sample_time:-"30"}  
export sample_freq=${sample_freq:-"100"} 


# 启动程序并获取 PID
echo "启动程序：$program_path $program_args"
$program_path $program_args & 
pid=$!
echo "程序已启动，PID 为 $pid"

# 启动 perf 采样
echo "开始对进程 $pid 进行 perf 采样，持续时间 $sample_time 秒..."
perf record -F $sample_freq -p $pid -g -- sleep $sample_time

# 采样完成，生成报告
echo "perf 采样完成，生成报告..."
perf report -i perf.data

# 提示用户
echo "perf 数据已保存到 perf.data 文件中，可以通过 perf report 查看分析结果。"