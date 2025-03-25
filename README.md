# Ubuntu-24.04 OpenCV CUDA 环境配置

## 换源

```
cd /etc/apt/sources.list.d/
sudo cp ubuntu.sources ubuntu.sources.bak
sudo vi ubuntu.sources
```

```
Types: deb
URIs: http://mirrors.tuna.tsinghua.edu.cn/ubuntu/
Suites: noble noble-security noble-updates noble-proposed noble-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
```

```
sudo apt update
sudo apt upgrade -y
```

## 设置中文

```
sudo apt update
sudo apt install language-pack-zh-hans locales -y
sudo update-locale LANG=zh_CN.UTF-8
echo "LANG=zh_CN.UTF-8" | sudo tee -a /etc/environment
sudo apt install fonts-wqy-microhei fonts-wqy-zenhei -y
```

重启

## 安装cmake
```
sudo apt update
sudo apt install cmake g++ -y
```
## 下载opencv 
```
mkdir -p opencv
cd opencv
```
```
wget -O opencv-4.11.0.tar.gz https://github.com/opencv/opencv/archive/refs/tags/4.11.0.tar.gz
wget -O opencv_contrib-4.11.0.tar.gz https://github.com/opencv/opencv_contrib/archive/refs/tags/4.11.0.tar.gz
```
```
tar -zxf opencv-4.11.0.tar.gz
tar -zxf opencv_contrib-4.11.0.tar.gz
```

## 安装cuda cudnn
```
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.8.1/local_installers/cuda-repo-wsl-ubuntu-12-8-local_12.8.1-1_amd64.deb
sudo dpkg -i cuda-repo-wsl-ubuntu-12-8-local_12.8.1-1_amd64.deb
sudo cp /var/cuda-repo-wsl-ubuntu-12-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-8
```
```
wget https://developer.download.nvidia.com/compute/cudnn/9.8.0/local_installers/cudnn-local-repo-ubuntu2404-9.8.0_1.0-1_amd64.deb
sudo dpkg -i cudnn-local-repo-ubuntu2404-9.8.0_1.0-1_amd64.deb
sudo cp /var/cudnn-local-repo-ubuntu2404-9.8.0/cudnn-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cudnn-cuda-12
```
### 添加环境变量
```
sudo nano ~/.bashrc
```
```
export CUDA_HOME="/usr/local/cuda-12.8"
export CuDNN_HOME="/usr/local/cuda-12.8/include"
export PATH="/usr/local/cuda-12.8/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-12.8/lib64:$LD_LIBRARY_PATH"
```
```
source ~/.bashrc
```

### 验证安装

```
nvcc -V
```

## 构建opencv
### debug版本
```
mkdir -p opencv-4.11.0/build_debug opencv-4.11.0/build_release
cd opencv-4.11.0/build_debug
```
```
cmake .. \
	-G "Ninja" \
	-DCMAKE_BUILD_TYPE=Debug \
	-DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.11.0/modules \
	-DCMAKE_INSTALL_PREFIX=/usr/local/opencv_debug/ \
	-DBUILD_opencv_java_bindings_generator=OFF \
	-DBUILD_JAVA=OFF \
	-DBUILD_opencv_python_bindings_generator=OFF \
	-DBUILD_opencv_python_tests=OFF \
	-DBUILD_PERF_TESTS=OFF \
	-DBUILD_TESTS=OFF \
	-DOPENCV_TEST_DNN_TFLITE=OFF \
	-DBUILD_opencv_face=OFF \
	-DBUILD_opencv_wechat_qrcode=OFF \
	-DBUILD_opencv_features2d=OFF \
	-DBUILD_opencv_xfeatures2d=OFF \
	-DBUILD_opencv_cudafeatures2d=OFF \
	-DBUILD_CUDA_STUBS=ON \
	-DOPENCV_DNN_CUDA=ON \
	-DWITH_CUDA=ON \
	-DOPENCV_ENABLE_NONFREE=ON \
	-DWITH_GTK_2_X=ON \
	-DENABLE_FAST_MATH=ON 
```
```
ninja
sudo ninja install
```
### release版本
```
cd ../build_ralease
cmake .. \
	-G "Ninja" \
	-DCMAKE_BUILD_TYPE=Release \
	-DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.11.0/modules \
	-DCMAKE_INSTALL_PREFIX=/usr/local/opencv_release/ \
	-DBUILD_opencv_java_bindings_generator=OFF \
	-DBUILD_JAVA=OFF \
	-DBUILD_opencv_python_bindings_generator=OFF \
	-DBUILD_opencv_python_tests=OFF \
	-DBUILD_PERF_TESTS=OFF \
	-DBUILD_TESTS=OFF \
	-DOPENCV_TEST_DNN_TFLITE=OFF \
	-DBUILD_opencv_face=OFF \
	-DBUILD_opencv_wechat_qrcode=OFF \
	-DBUILD_opencv_features2d=OFF \
	-DBUILD_opencv_xfeatures2d=OFF \
	-DBUILD_opencv_cudafeatures2d=OFF \
	-DBUILD_CUDA_STUBS=ON \
	-DOPENCV_DNN_CUDA=ON \
	-DWITH_CUDA=ON \
	-DOPENCV_ENABLE_NONFREE=ON \
	-DWITH_GTK_2_X=ON \
	-DENABLE_FAST_MATH=ON 
```
```
ninja
sudo ninja install
```
## 验证 Debug/Release
```
file /usr/local/opencv_debug/lib/libopencv_core.so.4.11.0
file /usr/local/opencv_release/lib/libopencv_core.so.4.11.0
```

