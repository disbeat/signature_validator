%features_comb_file_name = 'features_combination_to_fabio_run_3.txt';
number_of_runs = 5;

%fid = fopen(features_comb_file_name, 'r');
picked_classifiers = [struct('name', 'template_classifier.m')];
statistical_test = [];
while(true) 
	%line = fgets(fid);
	%line = line(1 : end - 1)
    
	%if(line == -1)
	%	break;
    %end
    %features_to_consider = eval(line);
	statistical_test= [];
	for i = 1 : number_of_runs
        tic;
		runtests;
        toc;
		statistical_test = [statistical_test all_folds_quality];
	end
	%f = fopen('classifier_results_rbf.csv', 'a');
    
	%fprintf(f, '%s', line(1 : end - 1));
    save 'classifier_results_template.mat' statistical_test;
% 	for i = 1 : length(statistical_test)
% 		fprintf(f,',%f', statistical_test(i));
% 	end
% 	fprintf(f, '\n');
% 	fclose(f);
	break;
end

%fclose(fid);