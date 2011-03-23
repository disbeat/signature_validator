load 'mutualinfo_results.mat'

%kruskalwallis test
[p,table,stats] = kruskalwallis(results,names,'on');

stats.gnames(find(stats.meanranks == max(stats.meanranks)))

save('results_to_marco_mi.mat', 'p', 'table', 'stats');