%% DISPARITY SYNTHESIS
% CALCULATES A SYNTHESISED PICTURE OUT OF DISPARTITY MAP
%%
function [synthesis] = disparity_synthesis(image,disparity,factor)

IMsize = size(image);

synthesis = zeros(IMsize, 'uint8');
intDx = zeros([1,IMsize(2),3], 'uint8');

for y = 1:IMsize(1)
    x = 1:IMsize(2);
    dx = fix(x - factor * double(disparity(y,x)));
    
    boolDx = 0 < dx & dx <= IMsize(2);
    %intDx = uint8(repmat(boolDx,[1,1,3]));
    %[intDx(1,:,1),intDx(1,:,2),intDx(1,:,3)] = deal(boolDx);
    intDx(1,:,1) = boolDx;
    intDx(1,:,2) = boolDx;
    intDx(1,:,3) = boolDx;
    boundedDx = ~boolDx + boolDx .* dx;
    
    synthesis(y,boundedDx,:) = intDx .* image(y,x,:);
    
    
end

end