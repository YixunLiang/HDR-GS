OPENCV_IO_ENABLE_OPENEXR=1 python3 train_real.py --config config/flower.yaml --eval --gpu_id 0 --test_only --load_path "/home/ps/yixun_workspace/hdrgs_dev/HDR-GS/output/mlp/flower/2024_12_02_00_05_46/point_cloud/iteration_1000"

# python3 train_real_split.py --config config/computer.yaml --eval --gpu_id 0

# python3 train_real_split.py --config config/box.yaml --eval --gpu_id 0

# python3 train_real_split.py --config config/luckycat.yaml --eval --gpu_id 0
