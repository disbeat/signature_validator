function [ result ] = average_lines( matrix, wanted_lines )
%AVERAGE_LINES Averages the lines of matrix to fit in wanted_lines lines
%   Each line of result is the mean of (number of lines of the matrix) /
%   wanted_lines.
    
    [lines, cols] = size(matrix);
    result = zeros(wanted_lines, cols);
    
    step = floor( lines / wanted_lines );
    
    if step == 1
        % if step == 1 then the result == the matrix
        result(1:wanted_lines-1, :) = matrix(1:wanted_lines-1, :);
    else
        % average step by step
        for i = 1:wanted_lines-1
            result(i, :) = mean(matrix((i-1)*step+1:i*step, :));
        end
    end
    
    % last line is a special case
    if step > 1
        result(wanted_lines, :) = mean(matrix((wanted_lines-1)*step: lines, :));
    else
        result(wanted_lines, :) = matrix(wanted_lines, :);
    end
end

