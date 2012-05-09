%% main.m
%
%% Input Data
opts.imDistance = 0.5;
opts.scale = 1;
opts.nD = 256;
opts.MRFalg = 1;
opts.smoothmax = 4;
opts.lambda = 100;

PSNR_R = zeros(100,1);
PSNR_L = zeros(100,1);
PSNR_M = zeros(100,1);

input = struct;
output = struct;
tmp = struct;

for i =1:100
    input(i).Folder = ('../video/frame/');
    input(i).Lfile = sprintf('left_%03d.png',i);
    input(i).Rfile = sprintf('right_%03d.png',i);
    input(i).Mfile = sprintf('middle_%03d.png',i);
    
    output(i).Folder = ('./output/');
    output(i).Lfile = sprintf('disp/dispL_%03d.png',i);
    output(i).Rfile = sprintf('disp/dispR_%03d.png',i);
    output(i).File = sprintf('synt_%03d.png',i);
    output(i).syntLfile = sprintf('synt/syntL_%03d.png',i);
    output(i).syntRfile = sprintf('synt/syntR_%03d.png',i);
    
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
save([output.Folder 'PSNR.mat'],'PSNR');

% imwrite(synt-imM,[outFolder errorFile]);

%% Plotten
% figure;
% subplot(2,3,1);colormap(gray); image(syntL);
% subplot(2,3,2); image(synt);
% subplot(2,3,3); image(syntR);
% subplot(2,3,4); image(imL);
% %subplot(2,3,5); image(imM);
% subplot(2,3,6); image(imR);