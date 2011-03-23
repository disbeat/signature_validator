load 'classifier_results_template.mat'


indicators_name = fieldnames(statistical_test(1));
indicators_name(find(ismember(indicators_name, 'rocFN')==1)) = [];
indicators_name(find(ismember(indicators_name, 'rocFP')==1)) = [];

results = [];
for i = 1 : size(statistical_test,2)
	temp = [];
	for k = 1 : size(indicators_name,1)
		temp = [temp ; getfield(statistical_test(i), char(indicators_name(k)))];
	end
	results = [results temp];
end



f = fopen('results_classifiers_csv/classifier_results_template.csv', 'a');




for l = 1 : size(results,1)
	fprintf(f, '%s,', char(indicators_name(l)));
	for c = 1 : size(results,2)
		fprintf(f, '%f,', results(l,c));	
	end
	fprintf(f,'\n');
end

fclose(f);






