%% main.m
%
%% Input Data
width = 512;
height = 384;
frames = 1;

leftCam = 9;
rightCam = 7;
middleCam = 8;

opts.imDistance = 0.5;
opts.scale = 2;
opts.nD = 128;
opts.MRFalg = 1;
opts.smoothmax = opts.nD + 1;
opts.lambda = 25;

strOpt = sprintf('nD%03d_m%03d_lambda%03d',...
    opts.nD, opts.smoothmax, opts.lambda);

PSNR_R = zeros(frames,1);
PSNR_L = zeros(frames,1);
PSNR_M = zeros(frames,1);

input = struct;
output = struct;
tmp = struct;



for i =1:frames
    input(i).Folder = sprintf('../video/frame/%dx%d/',width,height);
    input(i).Lfile = sprintf('cam%02d_%dx%d_%03d.png',leftCam,width,height,i);
    input(i).Mfile = sprintf('cam%02d_%dx%d_%03d.png',middleCam,width,height,i);
    input(i).Rfile = sprintf('cam%02d_%dx%d_%03d.png',rightCam,width,height,i);
    
    output(i).Folder = ('./output/');
    output(i).Lfile = sprintf('disp/dispL_%02d_%dx%d_%03d_%s.png',...
        leftCam,width,height,i,strOpt);
    output(i).Rfile = sprintf('disp/dispR_%02d_%dx%d_%03d_%s.png',...
        rightCam,width,height,i,strOpt);
    output(i).File = sprintf('synt_%02d_%dx%d_%03d_L%02d_R%02d_%s.png',...
        middleCam,width,height,i,leftCam,rightCam,strOpt);
    output(i).syntLfile = sprintf('synt/syntL_%02d_%dx%d_%03d_%s.png',...
        leftCam,width,height,i,strOpt);
    output(i).syntRfile = sprintf('synt/syntR_%02d_%dx%d_%03d_%s.png',...
        rightCam,width,height,i,strOpt);
    
    
    tmp(i).Folder = './tmp/';
    tmp(i).dispRflipFile = sprintf('dispRflip_%03d.png',i);
    tmp(i).LflipFile = sprintf('Lflip_%03d.png',i);
    tmp(i).RflipFile = sprintf('Rflip_%03d.png',i);
    
end

%% For schleife
parfor i = 1:frames
    %%
    synthesis(input(i),output(i),tmp(i),opts)
    
    %% Fehler berechnen
    imM = imread([input(i).Folder input(i).Mfile]);
    
    syntL = imread([output(i).Folder output(i).syntLfile]);
    syntR = imread([output(i).Folder output(i).syntRfile]);
    synt = imread([output(i).Folder output(i).File]);
    
    holes = syntL==0;
    PSNR_L(i) = measerr(imM(~holes),syntL(~holes));
    holes = syntR==0;
    PSNR_R(i) = measerr(imM(~holes),syntR(~holes));
    holes = synt==0;
    PSNR_M(i) = measerr(imM(~holes),synt(~holes));
end
save([output(1).Folder ...
    sprintf('PSNR_cam%02d_%dx%d_Lcam%02d_Rcam%02d_1-%03d.mat',middleCam,width,height,leftCam,rightCam,frames)]);

% imwrite(synt-imM,[outFolder errorFile]);

%% Plotten
% figure;
% subplot(2,3,1);colormap(gray); image(syntL);
% subplot(2,3,2); image(synt);
% subplot(2,3,3); image(syntR);
% subplot(2,3,4); image(imL);
% %subplot(2,3,5); image(imM);
% subplot(2,3,6); image(imR);
