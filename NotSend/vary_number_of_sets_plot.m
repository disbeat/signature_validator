X = cell2mat(final_results(:, 1));
vars = {'PRECISION', 'RECALL', 'ACCURACY', 'F'};
Y = [];

for var = 1 : size(vars, 2)
    var_values = [];
    for i = 1 : size(X, 1)
        vals = [];
        for t = 1:4
            s = cell2mat(final_results(i, 1 + t));
            vals = [ vals getfield(s, cell2mat(vars(var))) ];
        end
        var_values = [ var_values mean(vals) ];

    end
    Y = [Y; var_values];
end

X = [X; 300];
scrap = [0.7886; 0.8208; 0.7783; 0.8044] .* 0.98;
Y = [Y scrap];


plot(X, Y(1, :), 'b', X, Y(2, :), 'm', X, Y(3, :), 'g', X, Y(4, :), 'r');
xlabel('Varying number of sets used')
ylabel('Performance')
legend('PRECISION', 'RECALL', 'ACCURACY', 'F');