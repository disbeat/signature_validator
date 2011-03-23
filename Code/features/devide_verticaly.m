function [ parts ] = devide_verticaly( img, num_parts )
%DEVIDE_VERTICALY Devides verticaly an image in n identical parts
%   This function receives an image and the number of wanted parts and
%   devide it in identical parts
    parts = [];
    [~, c] = size(img);
    step = floor( c / num_parts );
    for i = 1 : num_parts
        if (i == num_parts)
            parts{i} = img( : ,  (i-1) * step +1 : c );
        else
            parts{i} = img( :,  (i-1) * step + 1: i*step );
        end
    end
end
