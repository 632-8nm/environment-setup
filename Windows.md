```cmd
cmake .. -G "Visual Studio 17 2022" ^
-DOPENCV_DNN_CUDA:BOOL="1" ^
-DCUDA_FAST_MATH:BOOL="1" ^
-DBUILD_opencv_java_bindings_generator:BOOL="0" ^
-DBUILD_opencv_python_bindings_generator:BOOL="0" ^
-DBUILD_CUDA_STUBS:BOOL="1" ^
-DBUILD_opencv_js_bindings_generator:BOOL="0" ^
-DBUILD_TESTS:BOOL="0" ^
-DOPENCV_EXTRA_MODULES_PATH:PATH="D:/opencv/opencv_contrib-4.11.0/modules" ^
-DBUILD_PERF_TESTS:BOOL="0" ^
-DBUILD_JAVA:BOOL="0" ^
-DWITH_CUDA:BOOL="1" ^
-DOPENCV_ENABLE_NONFREE:BOOL="1" ^
-DENABLE_FAST_MATH:BOOL="1" ^
-DBUILD_opencv_python_tests:BOOL="0" ^
-DOPENCV_TEST_DNN_TFLITE:BOOL="0"
```
