&nbsp;

<div align="center">

<p align="center"> <img src="fig/logo.png" width="110px"> </p>

[![arXiv](https://img.shields.io/badge/paper-arxiv-179bd3)](https://arxiv.org/abs/2405.15125)
[![AK](https://img.shields.io/badge/media-AK-green)](https://x.com/_akhaliq/status/1794921228462923925?s=46)
[![MrNeRF](https://img.shields.io/badge/media-MrNeRF-green)](https://x.com/janusch_patas/status/1794932286397489222?s=46)

<h4> HDR-GS: Efficient High Dynamic Range Novel View Synthesis at 1000x Speed via Gaussian Splatting</h4> 


&nbsp;

</div>




### Introduction
This is the official implementation of our NeurIPS 2024 paper "HDR-GS: Efficient High Dynamic Range Novel View Synthesis at 1000x Speed via Gaussian Splatting". We have run the SfM algorithm to recalibrate the data. If you find this repo useful, please give it a star ⭐ and consider citing our paper. Thank you.

<img src="fig/pipeline.png" style="height:340px" />

### News
- **2024.12.01 :** Add Spiral trajectory video rendering and whole model save/reload features, refer *Training and Evaluation* for a try!🚀
- **2024.11.26 :** Code, recalibrated data following the opencv standard, and training logs have been released. Feel free to check and have a try! 🤗
- **2024.07.01 :** Our HDR-GS has been accepted by NeurIPS 2024! Code will be released before the start date of the conference (2024.12.10). Stay tuned. 🚀
- **2024.05.24 :** Our paper is on [arxiv](https://arxiv.org/abs/2405.15125) now. Code, data, and training logs will be released. Stay tuned. 💫

### Performance

<details close>
<summary><b>Synthetic Datasets</b></summary>

![results1](/fig/syn_table.png)

![results2](/fig/syn_figure.png)

</details>

<details close>
<summary><b>Real Datasets</b></summary>

![results1](/fig/real_table.png)

![results2](/fig/real_figure.png)

</details>

&nbsp;

## 1. Create Environment

We recommend using [Conda](https://docs.conda.io/en/latest/miniconda.html) to set up the environment.

``` sh
# cloning our repo
git clone https://github.com/caiyuanhao1998/HDR-GS --recursive


SET DISTUTILS_USE_SDK=1 # Windows only

# install the official environment of 3DGS
cd HDR-GS
conda env create --file environment.yml
conda activate hdr_gs
```


&nbsp;

## 2. Prepare Dataset

Download our recalibrated and reorganizewd datasets from [Google drive](https://drive.google.com/file/d/1-9K8_iFwFH3SeTcRoaOTed-h9GBdRrrr/view?usp=sharing). Then put the downloaded datasets into the folder `data_hdr/` as

```sh
  |--data_hdr
    |--synthetic
      |--bathroom
        |--exr
          |--0.exr
          |--1.exr
          ...
        |--images
          |--0_0.png
          |--0_1.png
          ...
        |--sparse
          |--0
            |--cameras.bin
            |--images.bin
            |--points3D.bin
            |--points3D.ply  
            |--project.ini
      |--bear
      ...
    |--real
      |--flower
        |--input_images
          |--000_0.jpg
          |--000_1.jpg
          ...
        |--poses_bounds_exps.npy
        |--sparse
          |--0
            |--cameras.bin
            |--images.bin
            |--points3D.bin
            |--points3D.ply  
            |--project.ini
      |--computer
      ...
```

`Note:` The original datasets are collected by [HDR-NeRF](https://arxiv.org/abs/2111.14451). But the camera poses follow the normalized device coordinates, which are not suitable for 3DGS. Besides, HDR-NeRF does not provide the initial point clouds. So we use the Structure-from-Motion algorithm to recalibrate the camera poses and generate the initial point clouds. We also organize the datasets according to the description of HDR-NeRF, which is different from its official repo.

&nbsp;

## 3. Training and Evaluation
We provide training logs for your convienience to debug. Please download them from the [Google Drive](https://drive.google.com/drive/folders/1lI2nZ51pcW12xaiNFJjvoaHeuawj1dRt?usp=drive_link).


You can run the `.sh` file by
```shell
# For synthetic scenes
bash train_synthetic.sh

# for real scenes
bash train_real.sh
```

Or you can directly train on specific scenes as
```shell
# For synthetic scenes
python3 train_synthetic_hdr_split.py --config config/sponza.yaml --eval --gpu_id 0 --syn

python3 train_synthetic_hdr_split.py --config config/sofa.yaml --eval --gpu_id 0 --syn

python3 train_synthetic_hdr_split.py --config config/bear.yaml --eval --gpu_id 0 --syn

python3 train_synthetic_hdr_split.py --config config/chair.yaml --eval --gpu_id 0 --syn

python3 train_synthetic_hdr_split.py --config config/desk.yaml --eval --gpu_id 0 --syn

python3 train_synthetic_hdr_split.py --config config/diningroom.yaml --eval --gpu_id 0 --syn

python3 train_synthetic_hdr_split.py --config config/dog.yaml --eval --gpu_id 0 --syn

python3 train_synthetic_hdr_split.py --config config/bathroom.yaml --eval --gpu_id 0 --syn

# for real scenes
python3 train_real_split.py --config config/flower.yaml --eval --gpu_id 0

python3 train_real_split.py --config config/computer.yaml --eval --gpu_id 0

python3 train_real_split.py --config config/box.yaml --eval --gpu_id 0

python3 train_real_split.py --config config/luckycat.yaml --eval --gpu_id 0
```


You can also reload trained models following:
```shell
# For synthetic scenes
python3 train_synthetic_hdr_split.py --config config/sponza.yaml --eval --gpu_id 0 --syn --load_path "path_to_your_pretrained_point_clouds"
```
For example, if you train a model with config: ``` flower.yaml```, you will get a profile as:
```sh
  |--output
    |--mlp
      |--flower
        |--exp-time
          |--point_cloud
            |interation_x
              |--pointcloud.ply
              |--tone_mapper.pth
            ...
          |--test_set_vis
          |--videos
          |--cameras.json
          |--cfg_args
          |--input.ply
          |--log.txt
```
then, the ``` "path_to_your_pretrained_point_clouds"```  of iteration_x is ``` "output/mlp/flower/exp-time/point_cloud/interation_x"```

you can also reload models only for testing by using ``` --test_only```. 
&nbsp;

## 4. Citation
```sh
@inproceedings{hdr_gs,
  title={HDR-GS: Efficient High Dynamic Range Novel View Synthesis at 1000x Speed via Gaussian Splatting},
  author={Yuanhao Cai and Zihao Xiao and Yixun Liang and Minghan Qin and Yulun Zhang and Xiaokang Yang and Yaoyao Liu and Alan Yuille},
  booktitle={NeurIPS},
  year={2024}
}
```
