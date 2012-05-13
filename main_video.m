function main_video
addpath YUV2Image/
NFrames = 100;
scale = 1/2;
%%
movL = loadFileYuv('../video/ftp.hhi.de/HHIMPEG3DV/sequences/scene_book_arrival/normalized/BookArrival_Cam06.yuv',1024,768,1:100);
disp('movL loaded');
for i = 1:NFrames
    i
    imwrite(imresize(movL(i).cdata,scale),sprintf('../video/frame/cam06_%03d.png',i));
end
%%
movR = loadFileYuv('../video/ftp.hhi.de/HHIMPEG3DV/sequences/scene_book_arrival/normalized/BookArrival_Cam10.yuv',1024,768,1:100);
disp('movR loaded');
for i = 1:NFrames
    i
    imwrite(imresize(movR(i).cdata,scale),sprintf('../video/frame/cam10_%03d.png',i));
end
%%
movM = loadFileYuv('../video/ftp.hhi.de/HHIMPEG3DV/sequences/scene_book_arrival/normalized/BookArrival_Cam08.yuv',1024,768,1:100);
disp('movM loaded');
for i = 1:NFrames
    i
    imwrite(imresize(movM(i).cdata,scale),sprintf('../video/frame/cam08_%03d.png',i));
end


