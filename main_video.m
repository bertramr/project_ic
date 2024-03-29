function main_video
addpath YUV2Image/
NFrames = 1:100;
width = 1024;
height = 768;
scale = 1/2;
%%
for cam=6:2:10
    mov = loadFileYuv(sprintf('../video/ftp.hhi.de/HHIMPEG3DV/sequences/scene_book_arrival/depth/LG/best/book_depth_%02d.yuv',cam),width,height,NFrames);
    fprintf('cam%02d loaded',cam);
    for i = NFrames
        imOriginal = mov(i).cdata;
        
        imwrite(imOriginal,...
            sprintf('../video/frame/%dx%d/depth/depth%02d_%dx%d_%03d.png',...
            width,height,cam,width,height,i));
        
        imScale = imresize(mov(i).cdata,scale);
        sWidth = width*scale;
        sHeight = height*scale;
        imwrite(imScale,...
            sprintf('../video/frame/%dx%d/depth/depth%02d_%dx%d_%03d.png',...
            sWidth,sHeight,cam,sWidth,sHeight,i));
    end
    
end
