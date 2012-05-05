%% main.m
%
%%
clc; clear all; close all;
%% Input Data
mrfPath = '../MRF-benchmarks/mrfstereo/mrfstereo';

imFolder = '../MRF-benchmarks/mrfstereo/data/Plastic/';

outFolder = './output/';

outLfile = 'dispL.png';
outRfile = 'dispR.png';

outRflipFile = 'dispRflip.png';

imLflipFile = 'imLflip.png';
imRflipFile = 'imRflip.png';

imLfile = 'view1.png';
imRfile = 'view5.png';

imDistance = 0.5;
scale = 3;

syntLfile = 'syntL.png';
syntRfile = 'syntR.png';

outFile = 'viewsynt.png';
errorFile = 'error.png';

dmin = importdata([imFolder 'dmin.txt']);
nD = dmin/3;

MRFalg = 1;
smoothmax = 2;
lambda = 80;

mrfOpt = sprintf('-n %f -b -a %d -m %d -l %d', ...
    nD, MRFalg, smoothmax,lambda);


%% Flip-Image
imL = imread([imFolder imLfile]);
imR = imread([imFolder imRfile]);

IMsize = size(imL);


imLflipped = zeros(IMsize,'uint8');
imRflipped = zeros(IMsize,'uint8');
for i=1:3
    imLflipped(:,:,i) = fliplr(imL(:,:,i));
    imRflipped(:,:,i) = fliplr(imR(:,:,i));
end
imwrite(imLflipped,[outFolder imLflipFile]);
imwrite(imRflipped,[outFolder imRflipFile]);


%% Disparity berechnen
system(sprintf('%s %s %s %s %s', ...
    mrfPath,...
    mrfOpt,...
    [imFolder imLfile],...
    [imFolder imRfile],...
    [outFolder outLfile]));


system(sprintf('%s %s %s %s %s',...
    mrfPath, ...
    mrfOpt, ...
    [outFolder imRflipFile], ...
    [outFolder imLflipFile], ...
    [outFolder outRflipFile]));

%% reflip
flipped = imread([outFolder outRflipFile]);

outR = fliplr(flipped);

imwrite(outR,[outFolder outRfile]);


%% View synthesis

dispL = imread([outFolder outLfile]);
dispR = imread([outFolder outRfile]);
%dispL = imread([imFolder 'disp1.png']);
%dispR = imread([imFolder 'disp5.png']);

syntL = disparity_synthesis(imL,dispL,imDistance/scale);
syntR = disparity_synthesis(imR,dispR,(imDistance-1)/scale);

synt = view_synthesis(syntL,syntR);

%% Fehler berechnen
imM = imread([imFolder 'view3.png']);
[PSNR,MSE,MAXERR,L2RAT]=measerr(imM,synt)

%% Dateien schreiben
imwrite(syntL,[outFolder syntLfile]);
imwrite(syntR,[outFolder syntRfile]);
imwrite(synt,[outFolder outFile ]);
imwrite(synt-imM,[outFolder errorFile]);


%% Plotten
figure;
subplot(2,3,1);colormap(gray); image(syntL);
subplot(2,3,2); image(synt);
subplot(2,3,3); image(syntR);
subplot(2,3,4); image(imL);
subplot(2,3,5); image(imM);
subplot(2,3,6); image(imR);