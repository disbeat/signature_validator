function [result] = rbf_classifier(train_set, test_set)

	options = struct('min_error', 0.0000001, 'spread_rbf', 11, 'max_neurons', 300, 'neurons_display', 50)

	rbf_net = newrb(train_set.X, train_set.y, options.min_error, options.spread_rbf, options.max_neurons, options.neurons_display);

	predicted_y = round(sim(rbf_net, test_set.X));
	
	%predicted_y
	%test_set
	
	
	result = performance(predicted_y, test_set.y);
	%quality = 1 - cerror(predicted_y, int16(test_set.y));
    
end