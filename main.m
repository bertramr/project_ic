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

syntLfile = 'syntL.png';
syntRfile = 'syntR.png';

dmin = importdata([imFolder 'dmin.txt']);
nD = dmin/3;

MRFalg = 1;
smoothmax = 2;
lambda = 20;

mrfOpt = sprintf('-n %f -b -a %d -m %d -l %d', ...
    nD, MRFalg, smoothmax,lambda);


%%
system(sprintf('%s %s %s %s %s', ...
    mrfPath,...
    mrfOpt,...
    [imFolder imLfile],...
    [imFolder imRfile],...
    [outFolder outLfile]));

%% Flip-Image
imL = imread([imFolder imLfile]);

IMsize = size(imL);

imR = imread([imFolder imRfile]);

%%
imLflipped = zeros(IMsize,'uint8');
imRflipped = zeros(IMsize,'uint8');
for i=1:3
    imLflipped(:,:,i) = fliplr(imL(:,:,i));
    imRflipped(:,:,i) = fliplr(imR(:,:,i));
end
imwrite(imLflipped,[outFolder imLflipFile]);
imwrite(imRflipped,[outFolder imRflipFile]);

system(sprintf('%s %s %s %s %s',...
    mrfPath, ...
    mrfOpt, ...
    [outFolder imRflipFile], ...
    [outFolder imLflipFile], ...
    [outFolder outRflipFile]));

%% reflip
flipped = imread([outFolder outRflipFile]);
outR = zeros(IMsize,'uint8');
for i=1:3
    outR = fliplr(flipped);
end
imwrite(outR,[outFolder outRfile]);

%% View synthesis
%
dispL = imread([outFolder outLfile]);
dispR = imread([outFolder outRfile]);

imM = imread([imFolder 'view3.png']);

syntL = zeros(IMsize, 'uint8');
syntR = zeros(IMsize, 'uint8');

for y = 1:IMsize(1)
    for x = 1:IMsize(2)
        dxL = fix(x + imDistance * dispL(y,x));
        dxR = fix(x - (imDistance-1) * dispR(y,x));
        
        if 0 < dxL && dxL <= IMsize(2)
            syntL(y,x,:) = imL(y,dxL,:);
        else
            [x,y]
        end
        if 0 < dxR && dxR <= IMsize(2)
            syntR(y,x,:) = imR(y,dxR,:);
        else
            [x,y]
        end
        
    end
end

imwrite(syntL,[outFolder syntLfile]);
imwrite(syntR,[outFolder syntRfile]);

% Synthese aus 2 mach 1
synt = zeros(IMsize,'uint8');
syntLholes = syntL == 0;
syntRholes = syntR == 0;
synt = reshape(0.5 * syntL(~syntLholes) + 0.5 * syntR(~syntRholes),IMsize);

imwrite(synt,[outFolder 'viewsynt.png']);

[PSNR,MSE,MAXERR,L2RAT]=measerr(imM,synt)

figure;
subplot(2,3,1);colormap(gray); image(dispL);
subplot(2,3,2); image(synt);
subplot(2,3,3); image(dispR);
subplot(2,3,4); image(imL);
subplot(2,3,5); image(imM);
subplot(2,3,6); image(imR);