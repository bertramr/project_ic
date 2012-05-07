%% main.m
%
%% Input Data

input.Folder = './video/frame/';

output.Folder = './output/';
output.errorFile = 'error.png';

tmp.Folder = './tmp/';
tmp.dispRflipFile = 'dispRflip.png';
tmp.LflipFile = 'Lflip.png';
tmp.RflipFile = 'Rflip.png';

opts.imDistance = 0.5;
opts.scale = 6;
opts.nD = 40;
opts.MRFalg = 1;
opts.smoothmax = 2;
opts.lambda = 60;

for i = 241:260
    
    input.Lfile = sprintf('left_320x192_%d.png',i);
    input.Rfile = sprintf('right_320x192_%d.png',i);
    
    output.Lfile = sprintf('disp/dispL_%d.png',i);
    output.Rfile = sprintf('disp/dispR_%d.png',i);
    output.File = sprintf('synt_%d.png',i);
    output.syntLfile = sprintf('synt/syntL_%d.png',i);
    output.syntRfile = sprintf('synt/syntR_%d.png',i);

    
    synthesis(input,output,tmp,opts)
end

% imwrite(synt-imM,[outFolder errorFile]);
%% Fehler berechnen
% imM = imread([imFolder 'view3.png']);
% [PSNR,MSE,MAXERR,L2RAT]=measerr(imM,synt)

%% Plotten
% figure;
% subplot(2,3,1);colormap(gray); image(syntL);
% subplot(2,3,2); image(synt);
% subplot(2,3,3); image(syntR);
% subplot(2,3,4); image(imL);
% %subplot(2,3,5); image(imM);
% subplot(2,3,6); image(imR);