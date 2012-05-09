function write_video
writerObj = VideoWriter('output.avi');
writerObj.FrameRate=16.6;
open(writerObj);

for i = 1:100
    frame = imread(sprintf('output/synt_%d.png',i));
    writeVideo(writerObj,frame);
end

close(writerObj);