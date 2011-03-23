function [filled_sig] = fill_signature(I)
%FILL_SIG Fill the surrounded spaces of a signature image
%   This function receives a signature image and fills the inside spaces of
%   it. It uses the matlab function imfill

% fill the signature
filled_sig = imfill(I * 255);

% re-invert image to its original type
filled_sig = filled_sig ./ 255;

end
