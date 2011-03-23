function res = bestfit_feature(img)
%BESTFIT_FEATURE Finds the angle (a) constant and the axis intercept point (b) for
% the lower and top half of the image (signature bounding).
% The values are calculated using the least-squares best fit line
% algorithm.

    rows = size(img, 1);
    cols = size(img, 2);

    up_border = zeros(1, cols);
    down_border = zeros(1, cols);
    for c=1:size(img,2)
        up_border(c) = rows - find(img(:,c) == 1, 1, 'first');
        down_border(c) = rows - find(img(:,c) == 1, 1, 'last');
    end

    X = 1:cols;
    [b1, m1] = linear_bestfit( X, up_border );
    [b2, m2] = linear_bestfit( X, down_border );
	
    
	%getting the angles between the lines
	a1 = (atan(m1) + pi / 2) / pi;
	a2 = (atan(m2) + pi / 2) / pi;
    
    F1 = @(x) b1 + m1 * x;
    F2 = @(x) b2 + m2 * x;
    area_tmp = abs(quad(F1, 0, cols) - quad(F2, 0, cols));
    area = area_tmp / (rows*cols);
    
    if 0
        subplot(1,2,1);
        imshow(img, [0 1]);
        subplot(1,2,2);
        
        plot(X, F1(X), '--r', X, up_border, 'b', X, F2(X), '--m', X, down_border, 'b', 'LineWidth',2);

    end
	res = [a1 a2 area];
end
