function [ results ] = performance( predicted, real, dfce )
%PERFORMANCE Calculates some indicators of the quality of the results
%   Returns a stuct containing some indicators of the classification
%   performance, like true positives, true negatives, sensitivity,
%   specificity...

POS = 2; NEG = 1;

results = struct();

cm = confusionmat(real, predicted);


zero = 0.00000001;

results.TP = cm(POS, POS);
results.TN = cm(NEG, NEG);
results.FP = cm(NEG, POS);
results.FN = cm(POS, NEG);
results.SP = results.TN / (results.TN + results.FP + zero);
results.SN = results.TP / (results.TP + results.FN + zero);
results.PRECISION = results.TP / (results.TP + results.FP + zero);
results.RECALL = results.SN;
results.F = 2 * results.PRECISION * results.RECALL / ( results.PRECISION + results.RECALL + zero);
results.ACCURACY = ( results.TP + results.TN ) / sum(sum(cm));

if nargin > 2
    [results.rocFP, results.rocFN] = roc(dfce, real);
    fpr = []; tpr = [];
    
    for i= 1:length(results.rocFP)
        fpr(i) = results.rocFP(end-i+1);
        tpr(i) = 1 - results.rocFN(end-i+1);
    end
    
    results.AUC = trapz(fpr, tpr);
end

end
