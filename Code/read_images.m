load 'length_data.mat'

if (~exist('length_data', 'var'))
    BASE_HEIGHT = 1000;
    [min_w, max_w] = get_min_size(signatures_path, BASE_HEIGHT);
    length_data = struct('BASE_HEIGHT', BASE_HEIGHT, 'min_w', min_w, 'max_w', max_w);
    save 'length_data.mat' length_data
end

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
			img = invert(img);
			
            img = crop_image(img);
			

            features = build_feature_vector(img, length_data);
            %features = stroke_ratio_feature(img);
			%features = splitting_feature(img);
            
            %features = histogram_feature(img);
            
            
            fake = (strcmp(image_name(1:3), 'cf-') ~= 0) + 1;

            images_data = [images_data; setid features fake];

        end
    end
end

disp('Completed...');

fname = sprintf('splitting_feature_data_%d_%d.mat', start_set, end_set);
save(fname, 'images_data');
