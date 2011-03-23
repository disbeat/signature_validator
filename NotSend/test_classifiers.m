load 'images_data.mat';
%X matrix:
%lines = features:
%columns = cases
%Sets with good results: 70
SET = 70;

[l c] = size(images_data);
%only working with the first set
features = images_data( images_data(:, 1) == SET, 2 : c-1 )';
%features = images_data( : , 2 : c-1 )';

classes = images_data( images_data(:, 1) == SET, c )' + 1;
%classes = images_data( : , c )' + 1;

base = 1 : size(features,2);

train_sample = sort(randsample( base, floor(size(features,2) * 0.7) ));
test_sample = base;
test_sample(train_sample) = [];

train_set = struct('X', features(:, train_sample), 'y', classes(train_sample), 'num_data', length(train_sample), ...
 	'dim', size(features,1));

test_set = struct('X', features(:, test_sample), 'y', classes(test_sample), 'num_data', length(test_sample), ...
 	'dim', size(features,1));



% test_set = struct('X', features( : , 100:130), 'y', classes(1,100:130), 'num_data', 30, ...
%  	'dim', size(features,1))



%svm_classifier(train_set, test_set)

%rbf_classifier(train_set, test_set)
cmeans_classifier(train_set, test_set)

%nn_classifier(train_set);

%test_set.y


