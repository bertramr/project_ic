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

dispL = imread([outFolder outLfile]);
dispR = imread([outFolder outRfile]);

syntL = zeros(IMsize, 'uint8');
syntR = zeros(IMsize, 'uint8');


for i=1:IMsize(3)
    for y = 1:IMsize(1)
        for x = 1:IMsize(2)
            dxL = x + dispL(y,x);
            dxR = x - dispR(y,x);
            if dxL <= IMsize(1) && dxL > 0
                syntL(y,x,i) = imL(y,dxL,i);
            end
            if dxR <= IMsize(1) && dxR > 0
                syntR(y,x,i) = imR(y,dxR,i);
            end
            
        end
    end
end

imwrite(syntL,[outFolder syntLfile]);
imwrite(syntR,[outFolder syntRfile]);