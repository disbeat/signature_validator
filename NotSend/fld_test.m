load 'images_data.mat';

[l c] = size(images_data);
%features = images_data( images_data(:, 1) == 1, 2 : c-1 )';
features = images_data( : , 2 : c-1 )';

%classes = images_data( images_data(:, 1) == 1, c )' + 1;
classes = images_data( : , c )' + 1;

base = 1 : size(features,2);

train_sample = sort(randsample( base, floor(size(features,2) * 0.7) ));
test_sample = base;
test_sample(train_sample) = [];

train_data = struct('X', features(:, train_sample), 'y', classes(train_sample), 'num_data', length(train_sample), ...
 	'dim', size(features,1));

test_data = struct('X', features(:, test_sample), 'y', classes(test_sample), 'num_data', length(test_sample), ...
 	'dim', size(features,1));


% train
tic;
fld_model = fld(train_data);
toc;

tic;
fldqp_model = fldqp(train_data);
toc;
% test
tic;
res = linclass(test_data.X, fld_model);
toc;

tic;
res2 = linclass(test_data.X, fldqp_model);
toc;

err = cerror( res, test_data.y)
err2 = cerror( res2, test_data.y)
