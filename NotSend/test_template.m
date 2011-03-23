images_data = [];
for setid = start_set : end_set
    setname = num2str(setid, '%.3d');
    fprintf('Set name: %s\n', setname);
    images = dir([ signatures_path '/' setname ]);
        
    for k = 1:length(images)
        image_name = images(k).name;
        len = length(image_name);
        if (len >= 3 && strcmp(image_name(len-2:len), 'bmp'))
            image_path = [ signatures_path '/' setname '/' images(k).name ];

            img = imread(image_path);
            
            if (size(img,1) * size(img,2) >300*100)
                img = img(1:300*100);
            end
            base = zeros(1, 300*100);
            img = invert(img);
            
            base(img~=-1) = img(:);
            
            fake = (strcmp(image_name(1:3), 'cf-') ~= 0) + 1;

            images_data = [images_data; setid base fake];
        end
    end
end



num_folds = 6; % 10 folds for cross-validation
number_of_sets = 15;

ends_with = 'classifier.m'; % lets run all files ending with this

addpath 'classifiers';
addpath 'performance';

picked_classifiers = [struct('name', 'template_classifier.m')];
if (1)
	images_data = images_data(1 : number_of_sets * 54, :);
end

images_data = images_data(randperm(size(images_data, 1)), :);

%picked_classifiers = [struct('name', 'svm_classifier.m')];
if exist('picked_classifiers', 'var')
    files = picked_classifiers;
else
    files = dir('classifiers');
end

for k = 1:length(files)
    file = files(k).name;    
    if (length(file) > length(ends_with) && strcmp(file(end - length(ends_with) + 1 : end), ends_with) == 1)
        
        name = file(1:end-2);
        fprintf(' --- %s ---\n', name);
        func = str2func(name);
        
        fprintf('Results:\n');
        avg = 0;
        
        [train_indexes, test_indexes] = crossval(size(images_data, 1), num_folds);      
        for fold = 1:num_folds
            train_data = images_data(cell2mat(train_indexes(fold)), :);
            train_struct = stprstruct(train_data);
            test_data = images_data(cell2mat(test_indexes(fold)), :);
            test_struct = stprstruct(test_data);
            quality = func(train_struct, test_struct);
            
            fprintf('  %f\n', quality);
            avg = avg + (quality / num_folds);
        end
        
        fprintf('Average: %f\n', avg);
        
    end
end

