%% main.m
%
%% Input Data

input.Folder = '../video/ftp.hhi.de/HHIMPEG3DV/sequences/scene_book_arrival/registered/';

output.Folder = './output/';
output.errorFile = 'error.png';

tmp.Folder = './tmp/';
tmp.dispRflipFile = 'dispRflip.png';
tmp.LflipFile = 'Lflip.png';
tmp.RflipFile = 'Rflip.png';

opts.imDistance = 0.5;
opts.scale = 2;
opts.nD = 93;
opts.MRFalg = 1;
opts.smoothmax = 2;
opts.lambda = 160;

PSNR.R = zeros(101,1);
PSNR.L = zeros(101,1);
PSNR.M = zeros(101,1);
%% For schleife
for i = 0:100
    
    input.Lfile = sprintf('cam01/Cam01_Frame_%03d.png',i);
    input.Rfile = sprintf('cam02/Cam02_Frame_%03d.png',i);
    input.Mfile = sprintf('cam03/Cam03_Frame_%03d.png',i);
    
    output.Lfile = sprintf('disp/dispL_%03d.png',i);
    output.Rfile = sprintf('disp/dispR_%03d.png',i);
    output.File = sprintf('synt_%03d.png',i);
    output.syntLfile = sprintf('synt/syntL_%03d.png',i);
    output.syntRfile = sprintf('synt/syntR_%03d.png',i);
    
    %%
    synthesis(input,output,tmp,opts)
    
    %% Fehler berechnen
    imM = imread([input.Folder input.Mfile]);
    
    syntL = imread([output.Folder output.syntLfile]);
    syntR = imread([output.Folder output.syntRfile]);
    synt = imread([output.Folder output.File]);
    
    holes = syntL==0;
    PSNR.L(i+1) = measerr(imM(~holes),syntL(~holes));
    holes = syntR==0;
    PSNR.R(i+1) = measerr(imM(~holes),syntR(~holes));
    holes = synt==0;
    PSNR.S(i+1) = measerr(imM(~holes),synt(~holes));
end

% imwrite(synt-imM,[outFolder errorFile]);

%% Plotten
% figure;
% subplot(2,3,1);colormap(gray); image(syntL);
% subplot(2,3,2); image(synt);
% subplot(2,3,3); image(syntR);
% subplot(2,3,4); image(imL);
% %subplot(2,3,5); image(imM);
% subplot(2,3,6); image(imR);