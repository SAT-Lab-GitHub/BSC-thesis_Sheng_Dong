from header import *
from detect import *


if __name__=='__main__':
    # impulse data
    # suqare image size, resize mode = squash
    image_size = 240  # height = width
    app = 'compile_cpp\\build\\app.exe'
    generate_videos = True

    video_list = [f for f in os.listdir('input_video\\') if f[-4:]=='.mp4']
    detections = []

    # simple solution
    for video in video_list:
        detect_video(video, image_size=image_size, generate_videos=True, extract=5)
    
    # # multi-process solution
    # NOTE: has "raw_data.txt" issues!
    # process_list = []
    # for video in video_list:
    #     pr = multiprocessing.Process(
    #         name=video,
    #         target=detect_video,
    #         args=(video, image_size, True),
    #         daemon=False
    #     )
    #     process_list.append(pr)
    
    # max_pr_num = 5
    # group_num = int(np.ceil(len(process_list)//max_pr_num))
    # group_list = []
    # for i in range(group_num-1):
    #     g = process_list[i:i+5]
    #     group_list.append(g)
    # group_list.append(process_list[i:])
    
    # for group in group_list:
    #     for pr in group:
    #         pr.start()
    #     while(True):
    #         c = len(multiprocessing.active_children())
    #         if c <= 0:
    #             break