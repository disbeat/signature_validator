function [ s ] = stprstruct( data )
%STPRSTRUCT Returns the STPRTools struct for data given

    features = data(:, 1:end-1)';
    classes = data(:, end)';
    
    s = struct('X', features, 'y', classes, 'num_data', size(features,2), 'dim', size(features,1));

end