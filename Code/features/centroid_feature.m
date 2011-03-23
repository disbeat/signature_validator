function centroid_angle = centroid_feature(img)
	% centroid_feature
	length_img = floor(size(img,2) / 2);
	%first half of the image
	centroid_a = centroid(img( : , 1 : length_img));

	%second half of the image
	centroid_b = centroid( img( : , length_img + 1 : size(img,2) ) );
	
	point_c = [centroid_a(1) centroid_b(2)];
	
	height = sqrt( (point_c(1) - centroid_b(1))^2 + (point_c(2) - centroid_b(2))^2 );
	hypotenuse = sqrt( (centroid_a(1) - centroid_b(1))^2 + (centroid_a(2) - centroid_b(2))^2 );
	
	centroid_angle = asin(height / hypotenuse) / pi;
	
	
	centroid_angle = centroid_angle + (1 / 2);
end
