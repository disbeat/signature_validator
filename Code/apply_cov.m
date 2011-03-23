function [result] =  apply_cov(data, number_dim) 
	
	covalues = diag(cov(data));
    
    idxs = [];
    
    while(length(idxs) < number_dim)
        tmp = min(covalues);
        idxs = [idxs find(covalues == tmp)];
        
        covalues(find(covalues == tmp)) = max(covalues) + 2000;
    end
    
    result = data(:, idxs(1:number_dim));
 
end