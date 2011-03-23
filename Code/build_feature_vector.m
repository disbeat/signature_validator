function feature_vector =  build_feature_vector(img, length_data)

        
	AVERAGING_SIZE = 5;
	
	feature_vector = [ get_mdf_vector(img,AVERAGING_SIZE) ];
	
	feature_vector = [ feature_vector centroid_feature(img)];
	
	feature_vector = [ feature_vector trisurface_feature(img)];
	 
	feature_vector = [ feature_vector length_feature(img, length_data)];
	
	feature_vector = [ feature_vector sixfold_feature(img)];	
	
	feature_vector = [ feature_vector bestfit_feature(img)];
    
end

function result = get_mdf_vector(img, num_lines_averaging)
	[lt_feat dt_feat] = mdf_feature(img,num_lines_averaging);
	result = convert_structure_to_line(lt_feat);
	result = [ result convert_structure_to_line(dt_feat) ];
end

function result = convert_structure_to_line(feature_structure)
	result = [];
	field_names = fieldnames(feature_structure);
	for k = 1 : size(field_names,1)
		temp = getfield(feature_structure,char(field_names(k)));
		result = [ result reshape(temp, 1, numel(temp)) ];
	end
	
	
end