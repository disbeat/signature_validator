function c = centroid(matrix)
	%CENTROID Calculates the line and column of the image's centroid
	%   Receives an image as argument and calculates its centroid. Returns the
	%   line and column of its cointroid.
	
	[row, col] = find( matrix( : , : ) == 1 );

    c = [floor( sum(row) / length(row) ), floor( sum(col) / length(col) )];
	
end