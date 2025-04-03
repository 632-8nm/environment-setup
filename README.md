# Linux

## 换源

```sh
cd /etc/apt/sources.list.d/
sudo cp ubuntu.sources ubuntu.sources.bak
sudo vi ubuntu.sources
```

```sh
Types: deb
URIs: http://mirrors.tuna.tsinghua.edu.cn/ubuntu/
Suites: noble noble-security noble-updates noble-proposed noble-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
```

```sh
sudo apt update
sudo apt upgrade -y
```
## 安装zsh
```sh
sudo apt update && sudo apt install zsh -y \
chsh -s $(which zsh) \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 
sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc 
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc 
source ~/.zshrc
```

## 设置中文

```sh
sudo apt update
sudo apt install language-pack-zh-hans locales -y
sudo update-locale LANG=zh_CN.UTF-8
echo "LANG=zh_CN.UTF-8" | sudo tee -a /etc/environment
sudo apt install fonts-wqy-microhei fonts-wqy-zenhei -y
```

重启

## 安装依赖
```sh
sudo apt update
sudo apt install cmake gcc g++ ninja-build libgtk2.0-dev pkg-config libgtk-3-dev pkg-config tree clangd nfs-kernel-server -y
```
## 配置opencv with cuda 
### 下载opencv
```sh
mkdir -p opencv
cd opencv
```
```sh
wget -O opencv-4.11.0.tar.gz https://github.com/opencv/opencv/archive/refs/tags/4.11.0.tar.gz
wget -O opencv_contrib-4.11.0.tar.gz https://github.com/opencv/opencv_contrib/archive/refs/tags/4.11.0.tar.gz
```
```sh
tar -zxf opencv-4.11.0.tar.gz
tar -zxf opencv_contrib-4.11.0.tar.gz
```

### 安装cuda cudnn
```sh
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.8.1/local_installers/cuda-repo-wsl-ubuntu-12-8-local_12.8.1-1_amd64.deb
sudo dpkg -i cuda-repo-wsl-ubuntu-12-8-local_12.8.1-1_amd64.deb
sudo cp /var/cuda-repo-wsl-ubuntu-12-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-8
```
```sh
wget https://developer.download.nvidia.com/compute/cudnn/9.8.0/local_installers/cudnn-local-repo-ubuntu2404-9.8.0_1.0-1_amd64.deb
sudo dpkg -i cudnn-local-repo-ubuntu2404-9.8.0_1.0-1_amd64.deb
sudo cp /var/cudnn-local-repo-ubuntu2404-9.8.0/cudnn-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cudnn-cuda-12
```
### 添加环境变量
```sh
sudo nano ~/.bashrc
```
```sh
export CUDA_HOME="/usr/local/cuda-12.8"
export CuDNN_HOME="/usr/local/cuda-12.8/include"
export PATH="/usr/local/cuda-12.8/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-12.8/lib64:$LD_LIBRARY_PATH"
```
```sh
source ~/.bashrc
```

### 验证安装

```sh
nvcc -V
```

### 构建opencv

```sh
mkdir -p opencv-4.11.0/build
sudo /usr/local/opencv/Release/ /usr/local/opencv/Debug/ 
cd opencv-4.11.0/build
```
### debug版本
```sh
cmake .. \
	-G "Ninja" \
	-DCMAKE_BUILD_TYPE=Debug \
	-DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.11.0/modules \
	-DCMAKE_INSTALL_PREFIX=/usr/local/opencv/Debug/ \
	-DBUILD_opencv_java_bindings_generator=OFF -DBUILD_JAVA=OFF \
	-DBUILD_opencv_python_bindings_generator=OFF -DBUILD_opencv_python_tests=OFF \
	-DBUILD_PERF_TESTS=OFF -DBUILD_TESTS=OFF -DOPENCV_TEST_DNN_TFLITE=OFF \
	-DBUILD_opencv_face=OFF \
	-DBUILD_opencv_wechat_qrcode=OFF \
	-DBUILD_opencv_features2d=OFF \
	-DBUILD_opencv_xfeatures2d=OFF \
	-DBUILD_opencv_cudafeatures2d=OFF \
	-DBUILD_CUDA_STUBS=ON -DOPENCV_DNN_CUDA=ON -DWITH_CUDA=ON \
	-DOPENCV_ENABLE_NONFREE=ON \
	-DWITH_GTK=ON -DWITH_GTK2=OFF -DWITH_GTK3=ON \
	-DENABLE_FAST_MATH=ON 
```
```sh
ninja
sudo ninja install
```
### release版本
```sh
rm -rf *
cmake .. \
	-G "Ninja" \
	-DCMAKE_BUILD_TYPE=Release \
	-DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.11.0/modules \
	-DCMAKE_INSTALL_PREFIX=/usr/local/opencv/Release/ \
	-DBUILD_opencv_java_bindings_generator=OFF -DBUILD_JAVA=OFF \
	-DBUILD_opencv_python_bindings_generator=OFF -DBUILD_opencv_python_tests=OFF \
	-DBUILD_PERF_TESTS=OFF -DBUILD_TESTS=OFF -DOPENCV_TEST_DNN_TFLITE=OFF \
	-DBUILD_opencv_face=OFF \
	-DBUILD_opencv_wechat_qrcode=OFF \
	-DBUILD_opencv_features2d=OFF \
	-DBUILD_opencv_xfeatures2d=OFF \
	-DBUILD_opencv_cudafeatures2d=OFF \
	-DBUILD_CUDA_STUBS=ON -DOPENCV_DNN_CUDA=ON -DWITH_CUDA=ON \
	-DOPENCV_ENABLE_NONFREE=ON \
	-DWITH_GTK=ON -DWITH_GTK2=OFF -DWITH_GTK3=ON \
	-DENABLE_FAST_MATH=ON 
```
```sh
ninja
sudo ninja install
```
### 验证 Debug/Release

```sh
file /usr/local/opencv/Debug/lib/libopencv_core.so.4.11.0
file /usr/local/opencv/Release/lib/libopencv_core.so.4.11.0
```

## XServer

```sh
echo "export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0" >> ~/.bashrc
source ~/.bashrc
```

## 安装QT

```sh
wget https://d13lb3tujbc8s0.cloudfront.net/onlineinstallers/qt-online-installer-linux-x64-4.9.0.run
chmod +x qt-online-installer-linux-x64-4.9.0.run
./qt-online-installer-linux-x64-4.9.0.run
```



