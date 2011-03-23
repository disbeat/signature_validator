function [ result ] = fld_classifier( train_set, test_set )
%FLD_CLASSIFIER Fisher Linear Discriminant classifier
%   Runs the Fisher Linear Discriminant for the given train and test data

warning off;

% train
%disp('Training FLD classifier...');
tic; fld_model = fld(train_set); %toc;


% test
%disp('Testing FLD classifier...');
tic; [predicted, dfce] = linclass(test_set.X, fld_model); %toc;

result = performance(predicted, test_set.y, dfce); 


end
