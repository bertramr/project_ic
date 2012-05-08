
movL = loadFileYuv('video/Leaving_laptop/left_432x240.yuv',432,240,1:100);
movR = loadFileYuv('video/Leaving_laptop/right_432x240.yuv',432,240,1:100);
movO = loadFileYuv('video/Leaving_laptop/out_432x240.yuv',432,240,1:100);
%%
for i = 1:100
imwrite(movL(i).cdata,sprintf('video/frame/left_%d.png',i));

imwrite(movR(i).frame.cdata,sprintf('video/frame/right_%d.png',i));

imwrite(movO(i).cdata,sprintf('video/frame/out_%d.png',i));

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