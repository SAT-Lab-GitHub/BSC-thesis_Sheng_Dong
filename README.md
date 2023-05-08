# BSC-thesis_Sheng_Dong
Supporting data and scripts for Sheng Dong's BSC thesis.

## 目标检测模型：`bumblebee-detection`

### 运行环境

- Windows 10
- gcc version 8.1.0 (x86_64-posix-seh-rev0, Built by MinGW-W64 project)
- Python 3.9.7 [MSC v.1929 64 bit (AMD64)] on win32

### 编译步骤

1. 将根目录`./bumblebee-detection/`下的`main_reserved.cpp`复制至`./bumblebee-detection/compile_cpp/source/`路径下，并重命名为`main.cpp`
2. 在根目录下打开WinWG shell，执行命令“`./build.bat`”，等待编译完成

### 运行步骤

1. 将待检测的视频文件（mp4格式）复制到`./inout_video/`路径下

2. 在`./bumblebee-detection/control_python/main.py`脚本中进行参数设置，可供修改的参数位于如下所示调用函数`detection_video()`的语句中，
   ```python
   ...
   if __name__=='__main__':
   	...
       for video in video_list:
           detect_video(video, image_size=image_size, generate_videos=True, extract=5)
   	...
   ```

   - `ginerate_videos`：Bool变量，`True`则在`./bumblebee-detection/output_video/`路径中生成带有矩形目标标记的视频（以`detection_`+"输入视频文件名"+`.mp4`命名）
   - `extract`：正整数，在每n帧画面中提取一帧进行目标检测，n越大，脚本运行速度越快，但是所得到的目标检测信息越少

3. 在根目录`./bumblebee-detection/`下打开命令提示符，执行命令`python control_python/main.py`，等待脚本运行完成

4. 脚本会将所有识别到目标的信息保存在`./bumblebee-detection/output_data/`路径下，以"输入视频文件名"+`.csv`命名

注：在对视频文件进行目标检测之前，脚本会先对`./bumblebee-detection/output_data/`和`./bumblebee-detection/inout_video`两个路径下的文件进行比对。若`./bumblebee-detection/output_data`路径下 已经存在和输入视频同名的CSV文件，则该视频文件不会得到检测。因此，需要再次对某一视频进行检测时，应先移除数据输出路径下的CSV文件。

## 视频案例：`video_samples`

包含了`detect_foraging_room.mp4`和`detect_nesting_room.mp4`两段带有矩形目标标记的视频样例，其原始输入视频和目标检测信息分别见`./bumblebee-detection/video_input/`和`./bumblebee-detection/data_output/`。

## 模型A1~A12：`A_models`

- `model_data.csv`：熊蜂行为实验的监测数据
- `main.R`：执行多元线性回归和随机效应模型的R脚本（v4.3.0）
- `results.txt`：回归模型输出文件

## 模型B1~B3：`B_models`

- `model_data.csv`：失温实验的监测数据
- `main.R`：执行多元线性回归的R脚本
- `results.txt`：回归模型输出文件
