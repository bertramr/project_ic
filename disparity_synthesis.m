%% DISPARITY SYNTHESIS
% CALCULATES A SYNTHESISED PICTURE OUT OF DISPARTITY MAP
%%
function [synthesis] = disparity_synthesis(image,disparity,factor)

IMsize = size(image);

synthesis = zeros(IMsize, 'uint8');

for y = 1:IMsize(1)
    x = 1:IMsize(2);
    dx = fix(x + factor * double(disparity(y,x)));
    
    boolDx = 0 < dx & dx <= IMsize(2);
    intDx = uint8(boolDx);
    
    boundedDx = ~boolDx + boolDx .* dx;
    
    synthesis(y,x,:) = repmat(intDx,[1,1,3]) .* image(y,boundedDx,:);
    
    
end

end