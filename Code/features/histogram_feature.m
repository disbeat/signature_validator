function res = histogram_feature(img)
    warning off;

    order = 9;

    hor_proj = sum(img) / size(img, 2);
    ver_proj = sum(img') / size(img, 1);
    
    x = 1 : size(hor_proj, 2);
    p1 = polyfit(x, hor_proj, order);
    f = polyval(p1,x);
    
    plot(x, hor_proj, 'r', x, f, 'b');
    pause;
    x = 1 : size(ver_proj, 2);
    p2 = polyfit(x, ver_proj, order);
    f = polyval(p2,x);
    plot(x, ver_proj, 'r', x, f, 'b');
    
    
    res = [p1, p2];
end


