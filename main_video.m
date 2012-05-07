

for i = 1:64*25
    
frame = loadFileYuv('video/left_320x192.yuv',320,192,i);

imwrite(frame.cdata,sprintf('video/frame/left_320x192_%d.png',i));

frame = loadFileYuv('video/right_320x192.yuv',320,192,i);

imwrite(frame.cdata,sprintf('video/frame/right_320x192_%d.png',i));


end