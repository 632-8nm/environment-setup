#!/usr/bin/bash
# cmake
sudo apt update && sudo apt install cmake
# opencv 
if [ ! -f "opencv-4.11.0.tar.gz" ]; then
    wget https://github.com/opencv/opencv/archive/refs/tags/4.11.0.tar.gz
else
    echo "文件 opencv-4.11.0.tar.gz 已存在，跳过下载。"
fi
if [ ! -f "opencv_contrib-4.11.0.tar.gz" ]; then
    wget https://github.com/opencv/opencv_contrib/archive/refs/tags/4.11.0.tar.gz
else
    echo "文件 opencv_contrib-4.11.0.tar.gz 已存在，跳过下载。"
fi
tar -zxf opencv-4.11.0.tar.gz
tar -zxf opencv_contrib-4.11.0.tar.gz
mkdir -p opencv-4.11.0/build_debug opencv-4.11.0/build_release

# cuda
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.8.1/local_installers/cuda-repo-wsl-ubuntu-12-8-local_12.8.1-1_amd64.deb
sudo dpkg -i cuda-repo-wsl-ubuntu-12-8-local_12.8.1-1_amd64.deb
sudo cp /var/cuda-repo-wsl-ubuntu-12-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-8


cmake .. \
	-DCMAKE_BUILD_TYPE=Debug \
	-DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.10.0/modules \
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
 
 
 cmake .. \
	-DCMAKE_BUILD_TYPE=Release \
	-DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.10.0/modules \
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
