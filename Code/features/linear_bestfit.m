% http://www.cnsm.csulb.edu/departments/geology/people/grannell/regress.html
% http://www.xtremevbtalk.com/showthread.php?t=44870
function [b, m] = linear_bestfit(X, Y)
    n = length(X);
    m = (sum(X .* Y) - (sum(X) * sum(Y)) / n) / ( sum(X .* X) - (sum(X) ^ 2) / n );
    b = (sum(Y) - m * sum(X)) / n;
end