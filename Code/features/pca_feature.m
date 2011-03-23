function [ out ] = pca_feature( img )

    img = round(double(bwmorph(invert(img),'skel',Inf)));
    original_size = size(img);
    
    img = reshape(img, 1, []);
    
    new_dim = 1;
    
    %lines = 512;
    %padding = lines - rem(length(img), lines);
    %img = [img zeros(1, padding)];
    %X = reshape(img, lines, length(img) / lines);
    
    X = find(img > 0);
    
    %model = kpca( X, struct('ker','rbf','arg',4,'new_dim',new_dim));
    model = pca( X, new_dim);
    Y = pcarec( X, model );
    
    X = X(1:end-padding);
    X = reshape(X, original_size);
    figure; imshow(X);
    
    Y = Y(1:end-padding);
    Y = reshape(Y, original_size);
    figure; imshow(Y);
   
end

