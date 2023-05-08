from header import *

def rgb2hex(value):
    r, g, b = value
    return ('0x'+'{:02X}' * 3).format(r, g, b)

def get_color(tag):
    if tag=='bee':
        return (0, 0, 255)
    elif tag=='egg':
        return (0, 255, 0)
    else:
        random.seed(tag)
        return (int(random.random()*255), int(random.random()*255), int(random.random()*255))

def detect_video(video, image_size, generate_videos=False, extract=1):
    print('\nDetecting: '+video)
    vc = cv.VideoCapture('input_video\\'+video)
    fps = vc.get(cv.CAP_PROP_FPS)
    frame_num = vc.get(cv.CAP_PROP_FRAME_COUNT)
    size = (int(vc.get(cv.CAP_PROP_FRAME_WIDTH)),int(vc.get(cv.CAP_PROP_FRAME_HEIGHT)))

    if generate_videos:
        four_cc = cv.VideoWriter_fourcc(*'mp4v')
        videowriter = cv.VideoWriter('output_video\\detect_'+video, four_cc, fps/extract, size)
    num = 0

    detections = [['frame_number', 'time_s', 'tag', 'probability', 'x', 'y', 'w', 'h']]
    while(True):
        num += 1
        if num % extract != 0:
            rval = vc.read()
            continue
        rval, frame = vc.read()
        print('\r    frame number = '+str(num)+'    {:.2f}%'.format(num/frame_num*100), end='')
        if not rval:
            break
        else:
            img = cv.resize(frame, (image_size, image_size), interpolation=cv.INTER_AREA)
            plt.imshow(img)
            img_array = np.array(img)
            img_hex = ''
            for row in img_array:
                for pix_rgb in row:
                    pix_hex = rgb2hex(pix_rgb)
                    img_hex += pix_hex+' '

            raw_data = open('raw_data.txt', mode='w+')
            raw_data.write(img_hex)
            raw_data.close()

            res = os.popen('compile_cpp\\build\\app.exe')
            frame_detections = []
            for line in res.readlines():
                if line != '\n':
                    if 'width:' in line and 'height:' in line:
                        pattern1 = re.compile(r'[a-z]* \([0-9.]*\)')
                        tag_prob = re.findall(pattern1, line)[0]
                        tag, prob = tag_prob.split(' ')[0], float(tag_prob.split(' ')[1][1:-1])
                        pattern2 = re.compile(r'\[.*\]')
                        x_y_w_h = re.findall(pattern2, line)[0][1:-1]
                        x, y = int((x_y_w_h.split(', ')[0]).split(': ')[1]), int((x_y_w_h.split(', ')[1]).split(': ')[1])
                        w, h = int((x_y_w_h.split(', ')[2]).split(': ')[1]), int((x_y_w_h.split(', ')[3]).split(': ')[1])
                        frame_detections.append([tag, x, y, w, h])
                        detections.append([num, num/fps, tag, prob, x, y, w, h])
            
            if generate_videos:
                # 画出
                detect_img = frame
                for detection in frame_detections:
                    [tag, x, y, w, h] = detection[:]
                    x0, y0 = int(x*size[0]/image_size), int(y*size[1]/image_size)
                    w0, h0 = int(w*size[0]/image_size), int(h*size[1]/image_size)
                    color = get_color(tag)
                    cv.rectangle(detect_img, (x0, y0), (x0+w0, y0+h0), color, 2)
                videowriter.write(detect_img)

    if generate_videos:
        videowriter.release()
        cv.destroyAllWindows()

    np.savetxt("output_data\\"+video[:-4]+".csv", detections, delimiter =",",fmt ='% s')