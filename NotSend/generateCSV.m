sets = 10;

load images_data
images_data = images_data(:, 2:end);

f = fopen(sprintf('images_data_nominal_%d_sets.csv', sets), 'w');

cols = size(images_data, 2);
lines = size(images_data, 1);

lines = 54 * sets;

for i = 1 : cols
    fprintf(f, '%s', get_features_name_by_col(i+1));
    if (i < cols)
        fprintf(f, ',');
    else
        fprintf(f, '\n');
    end
end

for l = 1 : lines
    for c = 1 : cols
       
        if (c == cols)
            if (images_data(l, c) == 2)
                fprintf(f, 'Real');
            elseif (images_data(l, c) == 1)
                fprintf(f, 'Fake');
            end
        else
            fprintf(f, '%f', images_data(l, c));
        end
            
        if (c < cols)
            fprintf(f, ',');
        else
            fprintf(f, '\n');
        end
        
    end
    
    disp(sprintf('%.2f%%', (l / lines) * 100));
end

fclose(f);