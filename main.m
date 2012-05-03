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

imLfile = 'view1.png';
imRfile = 'view5.png';

dmin = importdata([imFolder 'dmin.txt']);
nD = dmin/3;

MRFalg = 1;
smoothmax = 2;
lambda = 20;

mrfOpt = sprintf('-n %f -b -a %d -m %d -l %d', nD, MRFalg, smoothmax,lambda);

imL = imread([imFolder imLfile]);
imR = imread([imFolder imRfile]);

system(sprintf('%s %s %s %s %s', mrfPath, mrfOpt, [imFolder imLfile], [imFolder imRfile], [outFolder outLfile]));

%% Flip-Image
for i=1:3
    imLflipped(:,:,i) = fliplr(imL(:,:,i));
    imRflipped(:,:,i) = fliplr(imR(:,:,i));
end
%% Generating disparity images


%% View synthesis