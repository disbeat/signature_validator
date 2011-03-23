load 'images_data.mat'

features_to_consider = { 'mdf' 'centroid' 'length' 'sixfold' 'bestfit' }';
images_data = [ get_features_by_name(images_data, features_to_consider) images_data(:, end)]; % remove set id (first column)

num_folds = 6; % 10 folds for cross-validation

number_of_sets = 44;

ends_with = 'classifier.m'; % lets run all files ending with this

addpath 'classifiers';
addpath 'performance';

images_data = images_data(1 : number_of_sets * 54, :);
images_data = images_data(randperm(size(images_data, 1)), :);

%NUM_DIM_COV = 140;
%images_data = [apply_cov(images_data(:, 1:end-1),NUM_DIM_COV) images_data(:, end)];

%picked_classifiers = [struct('name', 'rbf_classifier.m')];
if exist('picked_classifiers', 'var')
    files = picked_classifiers;
else
    files = dir('classifiers');
end

tic

for k = 1:length(files)
    file = files(k).name;    
    if (length(file) > length(ends_with) && strcmp(file(end - length(ends_with) + 1 : end), ends_with) == 1)
        
        name = file(1:end-2);
        fprintf(' --- %s ---\n', name);
        func = str2func(name);
        
        fprintf('Results:\n');
        avg = 0;
        
        [train_indexes, test_indexes] = crossval(size(images_data, 1), num_folds);
		all_folds_quality = [];
        for fold = 1:num_folds
            train_data = images_data(cell2mat(train_indexes(fold)), :);
            train_struct = stprstruct(train_data);
            test_data = images_data(cell2mat(test_indexes(fold)), :);
            test_struct = stprstruct(test_data);
            result = func(train_struct, test_struct);
            all_folds_quality = [all_folds_quality result];
            fprintf('  %f\n', result.ACCURACY);
            avg = avg + (result.ACCURACY / num_folds);
        end
        fprintf('Average: %f\n', avg);
        
    end
end

toc
