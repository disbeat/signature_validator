
load 'images_data.mat'
%features -> mdf, centroid, trisurface, length, sixfold, bestfit



%features_to_consider = { 'mdf' 'centroid' 'trisurface' 'length' 'sixfold' 'bestfit' 'stroke' 'histogram' };
%images_data_tmp = [ get_features_by_name(images_data, features_to_consider) images_data(:, end)]; % remove set id (first column)
%load 'stroke_feature_data_1_300.mat'

%images_data = [images_data_tmp];% images_data(:, 2:end)];
%images_data = [images_data(:, 2:end)];



num_folds = 6; % 10 folds for cross-validation

number_of_sets = 44;

ends_with = 'classifier.m'; % lets run all files ending with this

addpath 'classifiers';
addpath 'performance';

%picked_classifiers = [struct('name', 'bayes_classifier.m')];
if (1)
	images_data = images_data(1 : number_of_sets * 54, :);
end


images_data_prev = images_data(randperm(size(images_data, 1)), :);


for NUM_DIM_COV = 1:5:size(images_data,2)-2
    images_data = [apply_cov(images_data_prev(:, 2:end-1),NUM_DIM_COV) images_data_prev(:, end)];

    picked_classifiers = [struct('name', 'svm_classifier.m')];
    if exist('picked_classifiers', 'var')
        files = picked_classifiers;
    else
        files = dir('classifiers');
    end

    for k = 1:length(files)
        file = files(k).name;    
        if (length(file) > length(ends_with) && strcmp(file(end - length(ends_with) + 1 : end), ends_with) == 1)

            name = file(1:end-2);
            fprintf(' --- %s ---\n', name);
            func = str2func(name);

            fprintf('Results:\n');
            avg = 0;
            all_folds_quality = [];
            for base_run=1:5
                [train_indexes, test_indexes] = crossval(size(images_data, 1), num_folds);      

                for fold = 1:num_folds
                    train_data = images_data(cell2mat(train_indexes(fold)), :);
                    train_struct = stprstruct(train_data);
                    test_data = images_data(cell2mat(test_indexes(fold)), :);
                    test_struct = stprstruct(test_data);
                    quality = func(train_struct, test_struct);
                    all_folds_quality = [all_folds_quality quality.ACCURACY];
                    fprintf('  %f\n', quality.ACCURACY);
                    avg = avg + (quality.ACCURACY / (num_folds*5));
                end
            end

            fprintf('Average: %f\n', avg);
            
            f = fopen('new_covariance.csv', 'a');
            fprintf(f, '%d', NUM_DIM_COV);
            for i = 1 : length(all_folds_quality)
                fprintf(f,';%f', all_folds_quality(i));
            end
            fprintf(f, '\n');
            fclose(f);


        end
    end
end

