function [result] = bayes_classifier(train_set, test_set) 
	%warning off all
    class1 = find(train_set.y == 1);
	class2 = find(train_set.y == 2);
	model.Pclass{1} = mlcgmm(train_set.X(:,class1));
	model.Pclass{2} = mlcgmm(train_set.X(:,class2));
	%prior estimation
	total_length = length(class1) + length(class2);
	model.Prior = [length(class1) length(class2) ] ./ total_length;
	[predicted_y, dfce] = bayescls(test_set.X,model);
    result = performance(predicted_y, test_set.y, dfce);	
end