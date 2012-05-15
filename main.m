%% main.m
%
%% Input Data
opts.imDistance = 0.5;
opts.scale = 2;
opts.nD = 128;
opts.MRFalg = 1;
opts.smoothmax = opts.nD + 1;
opts.lambda = 50;

PSNR_R = zeros(10,1);
PSNR_L = zeros(10,1);
PSNR_M = zeros(10,1);

input = struct;
output = struct;
tmp = struct;

for i =1:100
    input(i).Folder = ('../video/frame/512x384/');
    input(i).Lfile = sprintf('cam09_512x384_%03d.png',i);
    input(i).Mfile = sprintf('cam08_512x384_%03d.png',i);
    input(i).Rfile = sprintf('cam07_512x384_%03d.png',i);
    
    output(i).Folder = ('./output/');
    output(i).Lfile = sprintf('disp/dispL_09_512x384_%03d.png',i);
    output(i).Rfile = sprintf('disp/dispR_07_512x384_%03d.png',i);
    output(i).File = sprintf('synt_08_512x384_%03d.png',i);
    output(i).syntLfile = sprintf('synt/syntL_08_512x384_%03d.png',i);
    output(i).syntRfile = sprintf('synt/syntR_08_512x384_%03d.png',i);
    
    tmp(i).Folder = './tmp/';
    tmp(i).dispRflipFile = sprintf('dispRflip_%03d.png',i);
    tmp(i).LflipFile = sprintf('Lflip_%03d.png',i);
    tmp(i).RflipFile = sprintf('Rflip_%03d.png',i);
    
end

%% For schleife
parfor i = 1:100
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
save([output(1).Folder 'PSNR__09_07_08.mat']);

% imwrite(synt-imM,[outFolder errorFile]);

%% Plotten
% figure;
% subplot(2,3,1);colormap(gray); image(syntL);
% subplot(2,3,2); image(synt);
% subplot(2,3,3); image(syntR);
% subplot(2,3,4); image(imL);
% %subplot(2,3,5); image(imM);
% subplot(2,3,6); image(imR);
