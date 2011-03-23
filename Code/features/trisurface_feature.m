function [ areas ] = trisurface_feature( I )
%TRISURFACE Calculated the area covered by the signature in three equal
%parts of the signature's space
%   This function receives a croped binary image, fills the areas of the
%   image and calculates the area covered by it, deviding the space in
%   three equal parts

    % fill the signature to consider its area
    filled = fill_signature( I );
    
    % define some auxiliar variables
    areas = zeros(1,3);
    
    parts = devide_verticaly(filled, 3);
    
    for i = 1:3
        %figure;
        %imshow(parts{i}, [0 1]);
        % area  is the complemtnt of the total of ones over 
        %     the size of the part
        areas(i) = sum( sum( parts{i} ) ) / ( size(filled, 1) * size(parts{i}, 2) );
    end

end