%% main.m
%
%% Input Data

input.Folder = '../MRF-benchmarks/mrfstereo/data/Plastic/';

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

%% For schleife
for i = 1:100
    
    input.Lfile = sprintf('view1.png');
    input.Rfile = sprintf('view5.png');
    input.Mfile = sprintf('view3.png');
    
    output.Lfile = sprintf('disp/dispL_%d.png',i);
    output.Rfile = sprintf('disp/dispR_%d.png',i);
    output.File = sprintf('synt_%d.png',i);
    output.syntLfile = sprintf('synt/syntL_%d.png',i);
    output.syntRfile = sprintf('synt/syntR_%d.png',i);
    
    %%
    synthesis(input,output,tmp,opts)
    
    %% Fehler berechnen
    imM = imread([input.Folder input.Mfile]);
    
    syntL = imread([output.Folder output.syntLfile]);
    syntR = imread([output.Folder output.syntRfile]);
    synt = imread([output.Folder output.File]);
    
    holes = syntL==0;
    PSNR_L = measerr(imM(~holes),syntL(~holes));
    holes = syntR==0;
    PSNR_R = measerr(imM(~holes),syntR(~holes));
    holes = synt==0;
    PSNR_S = measerr(imM(~holes),synt(~holes));
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