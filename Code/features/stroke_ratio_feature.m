function ratio = stroke_ratio_feature(img) 
	[c l] = size(img);
	temp_original = reshape(img, 1, c*l);
	thinned_image = get_skeleton(img);
	original_image_sum = sum( temp_original ) / (c * l);
	temp_thinned = reshape(thinned_image,1,c*l); 
	thinned_image_sum = sum(temp_thinned) / (c * l);
	ratio = original_image_sum * thinned_image_sum;
	
end




