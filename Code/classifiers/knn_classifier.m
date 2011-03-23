function [result] = knn_classifier(train_set, test_set)
	
	predicted_y = knnclass(test_set.X, knnrule(train_set));	
	
	result = performance(predicted_y, test_set.y);

end