function [result] = cmeans_classifier(train_set, test_set)
    
	[model, predicted_y] = cmeans( [train_set.X  test_set.X], 2);
	result = performance( predicted_y, [train_set.y  test_set.y] );
 
    
    
end