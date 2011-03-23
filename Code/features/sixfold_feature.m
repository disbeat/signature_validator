function [ areas ] = sixfold_feature( I )
%SIXFOLD Extracts the areas of the signature from 6 diferent parts
%   The signature is devided in three equal parts and then each part is
%   devided verticaly by its centroid. The area of signature is calculated
%   respectively to each one of the six parts


    % define some auxiliar variables
    areas = zeros(1,6);
    filled_img = fill_signature( I );
    parts = devide_verticaly(I, 3);
    filled_parts = devide_verticaly(filled_img, 3);
    
    
    for i = 1:3
        
        part = filled_parts{i};        
        cntrd = centroid(part);
        
        part = filled_parts{i};
        [l c] = size(part);

        % area is the number of ones over 
        %     the size of the part
        areas(i*2 - 1) = sum(sum( part(1:cntrd(1),:) )) / ( cntrd(1) * c );
        areas(i*2) = sum( sum( part(cntrd(1) + 1 : l, : ) ) ) / ( ( l - cntrd(1) + 1) * c );
        
%         imshow(part(1:c_line, :), [0 1]);
%         pause
%         imshow(part(c_line+1: l, :), [0 1]);
%         pause
    end

end
