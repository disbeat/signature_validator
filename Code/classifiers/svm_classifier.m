function [result] = svm_classifier(train_set, test_set)
%solvers = ['bsvm2', 'mvsvmclass', 'oaasvm', 'oaosvm', 'smo', 'svm1d', 'svm2', 'svmlight', 'svmquadprog']
    options.ker = 'rbf';
    options.arg = 0.8;
    options.C = 10;
    options.solver = 'iimdm';
    options.num_folds = 6;
    options.verb = 0;

    	
    %[model, Errors] = evalsvm(train_set, options);
	model = bsvm2(train_set, options);
    [predicted_y, dfce] = svmclass(test_set.X, model);
	result = performance(predicted_y, test_set.y, dfce); 

    %quality = 1 - cerror(predicted_y, test_set.y);	
	
end
