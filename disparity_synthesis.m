%% DISPARITY SYNTHESIS
% CALCULATES A SYNTHESISED PICTURE OUT OF DISPARTITY MAP
%%
function [synthesis] = disparity_synthesis(image,disparity,factor)

IMsize = size(image);

synthesis = zeros(IMsize, 'uint8');

for y = 1:IMsize(1)
    for x = 1:IMsize(2)
        dx = fix(x + factor * double(disparity(y,x)));        
        if 0 < dx && dx <= IMsize(2)
            synthesis(y,x,:) = image(y,dx,:);
        end
    end
end

end