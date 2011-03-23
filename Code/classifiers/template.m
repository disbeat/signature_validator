function [ perf ] = template_classifier( train_set, test_set )
%TEMPLATE_CLASSIFIER Summary of this function goes here
%   Detailed explanation goes here

load 'template.mat'

fake = mean(train_set.X( 2:end , (train_set.y == 2)), 2);

valid = mean(train_set.X( 2:end, (train_set.y == 1)), 2);

result = zeros(length(test_set.y), 1);

for i= 1:length(test_set.y)
   img = test_set.X( 2:end , i );
   
   sum(img .* fake);
   sum(img .* valid);
   
   result(i) = (sum(img .* fake) > sum(img .* valid)) + 1;
end

perf = performance(result, test_set.y); 

%quality = 1 - cerror(result, test_set.y);

end

