function [ list ] = get_features_list( filter )
    
    ends_with = 'feature.m';

    
    list = {};
    files = dir('features');
    for k = 1:length(files)
        file = files(k).name;  
        if (length(file) > length(ends_with) && strcmp(file(end - length(ends_with) + 1 : end), ends_with) == 1) 
        
            name = file(1:end-2); % remove extension
            list = [list name];
            
        end
    end
    

end

