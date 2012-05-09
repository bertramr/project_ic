function main_video
movL = loadFileYuv('../video/ftp.hhi.de/HHIMPEG3DV/sequences/scene_book_arrival/normalized/BookArrival_Cam08.yuv',1024,768,1:100);
movR = loadFileYuv('../video/ftp.hhi.de/HHIMPEG3DV/sequences/scene_book_arrival/normalized/BookArrival_Cam09.yuv',1024,768,1:100);
movM = loadFileYuv('../video/ftp.hhi.de/HHIMPEG3DV/sequences/scene_book_arrival/normalized/BookArrival_Cam10.yuv',1024,768,1:100);
%%
for i = 1:100
imwrite(movL(i).cdata,sprintf('../video/frame/left_%03d.png',i));

imwrite(movR(i).cdata,sprintf('../video/frame/right_%03d.png',i));

imwrite(movM(i).cdata,sprintf('../video/frame/middle_%03d.png',i));

end

