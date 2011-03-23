function result = splitting_feature(I) 
	ctrd = centroid(I);
	
	left = centroid(I( : , 1 : ctrd(2)));
	right = centroid(I( : , ctrd(2) : end)) + [0 ctrd(2)];
	
	up_left = centroid( I( 1 : left(1), 1 : ctrd(2)) );
	up_right = centroid( I(1 : right(1), ctrd(2) : end)) + [0 ctrd(2)];
	
	down_left = centroid( I(left(1) : end, 1 : ctrd(2))) + [ctrd(1) 0];
	down_right = centroid( I(right(1) : end, ctrd(2) : end) ) + ctrd;
	
	result = [ctrd left right up_left up_right down_left down_right];
	
	
	
	
	
	
end