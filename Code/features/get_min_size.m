function [ min_width, max_width ] = get_min_size( path, BASE_HEIGHT )
    min_width = -1;
    max_width = 0;

    folders = dir(path);
    for i = 1:length(folders)
        if (folders(i).isdir && folders(i).name(1) ~= '.')
            images = dir([ path '\' folders(i).name ]);
            for k = 1:length(images)
                img = images(k).name;
                if (length(img) >= 3 && strcmp(img(length(img)-2:length(img)), 'bmp'))
                    
                    image = [ path '\' folders(i).name '\' images(k).name ];
                    I = imread(image);
                    I = crop_image(I);

                    % check length in reference height
                    [l c] = size(I);
                    w = c * BASE_HEIGHT / l;
                    if w > max_width
                        max_width = w;
                    elseif w < min_width || min_width == -1
                        min_width = w;
                    end
                    
                end
            end
        end
    end

end

