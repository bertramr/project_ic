
movL = loadFileYuv('../video/ftp.hhi.de/HHIMPEG3DV/sequences/scene_book_arrival/normalized/BookArrival_Cam01.yuv',1024,768,1:100);
movR = loadFileYuv('../video/ftp.hhi.de/HHIMPEG3DV/sequences/scene_book_arrival/normalized/BookArrival_Cam02.yuv',1024,768,1:100);
movM = loadFileYuv('../video/ftp.hhi.de/HHIMPEG3DV/sequences/scene_book_arrival/normalized/BookArrival_Cam03.yuv',1024,768,1:100);
%%
for i = 1:100
imwrite(movL(i).cdata,sprintf('../video/frame/left_%03d.png',i));

imwrite(movR(i).cdata,sprintf('../video/frame/right_%03d.png',i));

imwrite(movM(i).cdata,sprintf('../video/frame/middle_%03d.png',i));

end

%%
writerObj = VideoWriter('output.avi');
writerObj.FrameRate=16.6;
open(writerObj);

for i = 1:100
    frame = imread(sprintf('output/synt_%d.png',i));
    writeVideo(writerObj,frame);
end

close(writerObj);