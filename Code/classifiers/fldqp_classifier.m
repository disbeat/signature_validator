function [ result ] = fldqp_classifier( train_set, test_set )
%FLD_CLASSIFIER Fisher Linear Discriminant using Quadratic Programming
%classifier
%   Runs the Fisher Linear Discriminant using Quadratic Programming for the
%   given train and test data

% train
%disp('Training FLDQP classifier...');
tic; fldqp_model = fldqp(train_set); %toc;

% test
%disp('Testing FLDQP classifier...');
tic; predicted = linclass(test_set.X, fldqp_model); %toc;

result = performance(predicted, test_set.y); 


end

