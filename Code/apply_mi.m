function [result] =  apply_mi(data, number_dim) 
	
    mi = zeros(size(data,2));

    for i=1:size(data,2)
        for j=1:size(data,2)
            if i >= j
                continue;
            end
            mi(i, j) = information(data(:, i)', data(:, j)');
            mi(j, i) = mi(i, j);
        end
    end
    
	mi_values = sum(mi);
    
    idxs = [];
    
    while(length(idxs) < number_dim)
        tmp = min(mi_values);
        idxs = [idxs find(mi_values == tmp)];
        
        mi_values(find(mi_values == tmp)) = max(mi_values) +2000;
    end
    
    result = data(:, idxs(1:number_dim));
 
end