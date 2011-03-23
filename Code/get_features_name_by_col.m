function [ name ] = get_features_name_by_col( col )

    if (~isempty(find(2:121 == col, 1)))
        name = sprintf('mdf_%d', col - 1);
    elseif (~isempty(find(122 : 122 == col, 1)))
        name = sprintf('centroid_%d', col - 121);
    elseif (~isempty(find(123 : 125 == col, 1)))
        name = sprintf('trisurface_%d', col - 122);
    elseif (~isempty(find(126 : 126 == col, 1)))
        name = 'length';
    elseif (~isempty(find(127 : 132 == col, 1)))
        name = sprintf('sixfold_%d', col - 126);
    elseif (~isempty(find(133 : 135 == col, 1)))
        name = sprintf('bestfit_%d', col - 132);
    elseif (col == 136)
        name = 'stroke';
    elseif (~isempty(find(137 : 156 == col, 1)))
        name = sprintf('histogram_%d', col - 132);
    elseif (~isempty(find(157 : 170 == col, 1)))
        name = sprintf('spitting_%d', col - 132);
    elseif (col == 171)
        name = 'target';
    else
        disp(sprintf('name for column %d not found!', col));
    end

end
