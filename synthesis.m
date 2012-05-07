function synthesis(input, output, tmp, opts)

mrfPath = '../MRF-benchmarks/mrfstereo/mrfstereo';
mrfOpt = sprintf('-n %f -b -a %d -m %d -l %d', ...
    opts.nD, opts.MRFalg, opts.smoothmax,opts.lambda);


%% Flip-Image
imL = imread([input.Folder input.Lfile]);
imR = imread([input.Folder input.Rfile]);

IMsize = size(imL);

imLflipped = zeros(IMsize,'uint8');
imRflipped = zeros(IMsize,'uint8');
for i=1:3
    imLflipped(:,:,i) = fliplr(imL(:,:,i));
    imRflipped(:,:,i) = fliplr(imR(:,:,i));
end
imwrite(imLflipped,[tmp.Folder tmp.LflipFile]);
imwrite(imRflipped,[tmp.Folder tmp.RflipFile]);


%% Disparity berechnen
system(sprintf('%s %s %s %s %s', ...
    mrfPath,...
    mrfOpt,...
    [input.Folder input.Lfile],...
    [input.Folder input.Rfile],...
    [output.Folder output.Lfile]));


system(sprintf('%s %s %s %s %s',...
    mrfPath, ...
    mrfOpt, ...
    [tmp.Folder tmp.RflipFile], ...
    [tmp.Folder tmp.LflipFile], ...
    [tmp.Folder tmp.RflipFile]));

%% reflip
flipped = imread([tmp.Folder tmp.RflipFile]);
outR = fliplr(flipped);
imwrite(outR,[output.Folder output.Rfile]);


%% View synthesis

dispL = imread([output.Folder output.Lfile]);
dispR = imread([output.Folder output.Rfile]);

syntL = disparity_synthesis(imL,dispL,opts.imDistance/opts.scale);
syntR = disparity_synthesis(imR,dispR,(opts.imDistance-1)/opts.scale);

synt = view_synthesis(syntL,syntR);


%% Dateien schreiben
imwrite(syntL,[output.Folder output.syntLfile]);
imwrite(syntR,[output.Folder output.syntRfile]);
imwrite(synt,[output.Folder output.File ]);
