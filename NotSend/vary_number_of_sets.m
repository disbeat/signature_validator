features_to_consider = { 'mdf' 'centroid' 'length' 'sixfold' 'bestfit' }';
num_folds = 6;
final_results = {};

for number_of_sets = [1 5:5:45 50:50:300 ]

    addpath 'classifiers';
    addpath 'performance';

    load 'images_data.mat'
    images_data = [ get_features_by_name(images_data, features_to_consider) images_data(:, end)];
    images_data = images_data(1 : number_of_sets * 54, :);
    images_data = images_data(randperm(size(images_data, 1)), :);

    fprintf('Results for %d sets:\n', number_of_sets);
    avg = 0;

    [train_indexes, test_indexes] = crossval(size(images_data, 1), num_folds);
    
    all_folds = { number_of_sets };
    for fold = 1:num_folds
        train_data = images_data(cell2mat(train_indexes(fold)), :);
        train_struct = stprstruct(train_data);
        test_data = images_data(cell2mat(test_indexes(fold)), :);
        test_struct = stprstruct(test_data);
        result = svm_classifier(train_struct, test_struct);
        all_folds = [all_folds result];
        fprintf('  %f\n', result.ACCURACY);
        avg = avg + (result.ACCURACY / num_folds);
    end
    fprintf('Average: %f\n', avg);

    final_results = [final_results; all_folds ];
    
    toc

end

save('varying_number_sets_2.mat', 'final_results');