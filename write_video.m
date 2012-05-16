function write_video(input, output, PSNR)
writerObj = VideoWriter([output(1).Folder output(1).video]);
writerObj.FrameRate=16.6;
open(writerObj);

frames = 100;

psnr_mov_L = psnr_video(PSNR.L);
psnr_mov_M = psnr_video(PSNR.M);
psnr_mov_R = psnr_video(PSNR.R);

for i = 1:frames
    imL = imread([input(i).Folder input(i).Lfile]);
    imR = imread([input(i).Folder input(i).Rfile]);
    imM = imread([input(i).Folder input(i).Mfile]);
    
    dispL = imread([output(i).Folder output(i).Lfile]);
    dispR = imread([output(i).Folder output(i).Rfile]);
    synt = imread([output(i).Folder output(i).File]);
    syntL = imread([output(i).Folder output(i).syntLfile]);
    syntR = imread([output(i).Folder output(i).syntRfile]);
    
    error = repmat(abs(rgb2gray(synt)-rgb2gray(imM)),[1,1,3]);
    
    
    new = [psnr_mov_L(:,:,:,i), psnr_mov_M(:,:,:,i), psnr_mov_R(:,:,:,i);...
        syntL, error, syntR ;...
        repmat(dispL,[1,1,3]), synt, repmat(dispR,[1,1,3]);...
        imL, imM, imR];
    writeVideo(writerObj,new);
end

close(writerObj);