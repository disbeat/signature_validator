function [ list ] = get_classifiers_names(  )
    
    ends_with = 'classifier.m';

    
    list = {};
    files = dir('classifiers');
    for k = 1:length(files)
        file = files(k).name;    
        if (length(file) > length(ends_with) && strcmp(file(end - length(ends_with) + 1 : end), ends_with) == 1) 
            name = file(1:end-2);
            list = [list name];
        end
    end
    

end

