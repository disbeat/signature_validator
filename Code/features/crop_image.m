function img = crop_image(img)
    rows_to_remove = find( sum(img, 2) == 0 );
	columns_to_remove = find( sum(img, 1) == 0 );
    
    img(rows_to_remove, :) = [];
    img(:, columns_to_remove) = [];
end