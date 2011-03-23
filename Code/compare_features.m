addpath 'classifiers';
addpath 'performance';

features = { 'mdf' 'centroid' 'trisurface' 'sixfold' 'bestfit' 'stroke' 'histogram' };

num_folds = 6; % 10 folds for cross-validation
number_of_sets = 20;

for c = 1 : length(features) - 1
    
    comb_features = combnk(features, c);
    
    for f = 1 : length(comb_features)

        selected_features = comb_features(f, :);
        
        load images_data
        images_data = images_data(1 : number_of_sets * 54, :);
        images_data = [ get_features_by_name(images_data, selected_features) images_data(:, end)];

        avg = 0;
        [train_indexes, test_indexes] = crossval(size(images_data, 1), num_folds);      
        for fold = 1:num_folds
            train_data = images_data(cell2mat(train_indexes(fold)), :);
            train_struct = stprstruct(train_data);
            test_data = images_data(cell2mat(test_indexes(fold)), :);
            test_struct = stprstruct(test_data);
            quality = svm_classifier(train_struct, test_struct);
            avg = avg + (quality / num_folds);
        end

        disp(selected_features);
        fprintf('\tavg: %.2f%%\n', avg*100);

    end
    
end