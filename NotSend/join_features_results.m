names = {};
results = [];

%f = fopen('final_features_results.csv');
f = fopen('new_mutualinfo.csv');
while(1)
    line = fgets(f);
    if (line == -1)
        break;
    end
    
    splitted = strsplit(line, ';');
    name = int2str(splitted(1));
    
    
    res = eval(['{' line '}']);
    values = cell2mat(res(2:end))';
    
    names = [names name];
    results = [results values'];
end

save('mutualinfo_results.mat', 'names', 'results');