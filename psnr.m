function psnr = psnr(A,B)
siz = size(A);
height = siz(1);
width = siz(2);

A = rgb2gray(A);
B = rgb2gray(B);

psnr = 20*log10(2^8/sqrt(sum(sum((A-B).^2))/width/height));
end