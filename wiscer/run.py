import subprocess

# 定义数据结构列表
data_structures = [
    'chainedhash', 'viphash', 'stdmap', 'skiplist', 'ours',
    'leveldb_skiplist', 'btree'
]

# 清理之前的编译结果
subprocess.run(['make', 'clean'], check=True)
output_file='output.txt'
# 编译所有数据结构
for ds in data_structures:
    print(f"Compiling {ds}...")
    subprocess.run(['make', ds], check=True)
    print(f"Running benchmark for {ds}...")
    # 执行benchmark.out workloads/zyk_test并将输出重定向到文件
    with open(output_file, 'a') as f:
        subprocess.run(['./benchmark.out', 'workloads/zyk_test'], stdout=f, check=True)
        f.write('\n')

    with open(output_file, 'r') as f:
        lines = f.readlines()
        total_time = float(next((line for line in lines if 'Total time (us)' in line), '').split()[-1])
        net_throughput = float(next((line for line in lines if 'Net throughput' in line), '').split()[-2])
    