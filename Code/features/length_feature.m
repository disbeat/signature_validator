function [ len ] = length_feature( img, length_data)
%CALC_LENGTH Calculates the length based on the min and max length of the
%database of signatures
%   Receives the size of the image, the base height, which uses to
%   calculate the length of the signature. Then, stretches it to the
%   interval of [min_w max_w]

    [h, w] = size(img);

    len = w * length_data.BASE_HEIGHT / h;
    len = (len - length_data.min_w) / (length_data.max_w - length_data.min_w);

end
