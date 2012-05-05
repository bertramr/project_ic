%% VIEW_SYNTHESIS
% MAKES ONE PICTURE OUT OF TWO
%%
% In general it mixes both images. If one picture has no information for
% one pixel it uses the pixel from the other.
function [synthesis] = view_synthesis(imageLeft, imageRight)
IMsize = size(imageLeft);

holesLeft = imageLeft == 0;
holesRight = imageRight == 0;
synthesis = reshape(0.5 * (uint8(~holesLeft .* ~holesRight) .* imageLeft) ...
    + 0.5 * (uint8(~holesRight .* ~holesLeft) .* imageRight) ...
    + imageRight .* uint8(holesLeft .* ~holesRight) ...
    + imageLeft .* uint8(holesRight .* ~holesLeft) ...
    ,IMsize);
end