function feature = get_features_by_name(features_vector, feature_name)
	%%feature_name is a cell array
	feature = [];
	for i = 1 : size(feature_name,2)
		if (strcmp(feature_name(i), 'mdf'))
			feature = [feature features_vector(:, 2 : 121)];
		elseif(strcmp(feature_name(i), 'centroid'))
			feature = [feature features_vector(:, 122)];
		elseif(strcmp(feature_name(i), 'trisurface'))
			feature = [feature features_vector(:, 123 : 125)];
		elseif(strcmp(feature_name(i), 'length'))
			feature = [feature features_vector(:, 126 : 126)];
		elseif(strcmp(feature_name(i), 'sixfold'))
			feature = [feature features_vector(:, 127 : 132)];
		elseif(strcmp(feature_name(i), 'bestfit'))
			feature = [feature features_vector(:, 133 : 135)];
        elseif(strcmp(feature_name(i), 'stroke'))
            feature = [feature features_vector(:, 136)];
        elseif(strcmp(feature_name(i), 'histogram'))
            feature = [feature features_vector(:, 137 : 156)];
        elseif(strcmp(feature_name(i), 'splitting'))
            feature = [feature features_vector(:, 157 : 170)];
		end
		
    end
end