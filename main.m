%% main.m
%
%% Input Data

input.Folder = '../video/frame/';

output.Folder = './output/';
output.errorFile = 'error.png';

tmp.Folder = './tmp/';
tmp.dispRflipFile = 'dispRflip.png';
tmp.LflipFile = 'Lflip.png';
tmp.RflipFile = 'Rflip.png';

opts.imDistance = 0.5;
opts.scale = 1;
opts.nD = 200;
opts.MRFalg = 1;
opts.smoothmax = 2;
opts.lambda = 160;

PSNR.R = zeros(101,1);
PSNR.L = zeros(101,1);
PSNR.M = zeros(101,1);
%% For schleife
for i = 1:100
    
    input.Lfile = sprintf('left_%03d.png',i);
    input.Rfile = sprintf('right_%03d.png',i);
    input.Mfile = sprintf('middle_%03d.png',i);
    
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
    PSNR.L(i) = measerr(imM(~holes),syntL(~holes));
    holes = syntR==0;
    PSNR.R(i) = measerr(imM(~holes),syntR(~holes));
    holes = synt==0;
    PSNR.S(i) = measerr(imM(~holes),synt(~holes));
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