# 编译注意事项

1. 编译使用`./build.bat`（在`bumblebee-detection/compile_cpp`目录下运行）
2. 每次编译需要重新解压例程文件和模型，并用根目录下的`main_reserved.cpp`替代`./source/`路径下的`main.cpp`
3. 运行程序：`build/app.exe`或`build/app`
4. `make`需要用`mingw32-make`来替代，但是该命令内容不全，会报错
5. 参考https://docs.edgeimpulse.com/docs/deployment/running-your-impulse-locally/running-your-impulse-locally#running-the-impulse
6. raw_data.txt位于一级目录下，所以需要读取文件的时候应当退出到一级目录进行。若要直接测试`.exe`文件，运行`compile_cpp/build/app`