```
wget -O opencv-4.11.0.tar.gz https://github.com/opencv/opencv/archive/refs/tags/4.11.0.tar.gz
wget -O opencv_contrib-4.11.0.tar.gz https://github.com/opencv/opencv_contrib/archive/refs/tags/4.11.0.tar.gz
tar -zxf opencv-4.11.0.tar.gz opencv_contrib-4.11.0.tar.gz
```
```
cd opencv-4.11.0/build_debug
cmake .. \
    -G "Ninja" \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_INSTALL_PREFIX=/usr/local/opencv_debug/ \
    -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.11.0/modules \
    -DOPENCV_ENABLE_NONFREE=ON \
    -DBUILD_PERF_TESTS=OFF -DBUILD_TESTS=OFF \
    -DBUILD_opencv_face=OFF -DBUILD_opencv_wechat_qrcode=OFF -DBUILD_opencv_features2d=OFF -DBUILD_opencv_xfeatures2d=OFF \
    -DENABLE_FAST_MATH=ON \
    -DOPENCV_DNN_OPENCL=ON \
    -DENABLE_NEON=ON -DCPU_BASELINE=NEON -DCPU_DISPATCH=NEON_FP16 \
ninja
mkdir -p /usr/local/opencv_debug && sudo ninja install
```
```
cd opencv-4.11.0/build_release
cmake .. \
    -G "Ninja" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local/opencv_release/ \
    -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.11.0/modules \
    -DOPENCV_ENABLE_NONFREE=ON \
    -DBUILD_PERF_TESTS=OFF -DBUILD_TESTS=OFF \
    -DBUILD_opencv_face=OFF -DBUILD_opencv_wechat_qrcode=OFF -DBUILD_opencv_features2d=OFF -DBUILD_opencv_xfeatures2d=OFF \
    -DENABLE_FAST_MATH=ON \
    -DOPENCV_DNN_OPENCL=ON \
    -DENABLE_NEON=ON -DCPU_BASELINE=NEON -DCPU_DISPATCH=NEON_FP16 \
ninja
mkdir -p /usr/local/opencv_release && sudo ninja install
```
