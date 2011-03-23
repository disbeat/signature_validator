function [result] =  apply_pca(img, number_dim) 
	line_img = img(:);
	model = pca(img, number_dim);
	result = linproj(data,model);
	
end