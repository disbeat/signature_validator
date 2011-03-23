function [ ] = plot_roc( results )
%PLOT_ROC Plots a roc curve from the performance struct
%   Given a performance struct with the fiels .rocFP and .rocFN plots a roc
%   curve with those values


plot(results.rocFP, 1 - results.rocFN)

xlabel('False Positive Rate ( 1 - specificity)'); 
ylabel('True Positive Rate (sensitivity)');

end

