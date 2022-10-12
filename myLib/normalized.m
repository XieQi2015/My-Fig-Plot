function Y = normalized(X)
%%用来将数据放到[0,1]之间
maxX = max(X(:));
minX = min(X(:));
Y    = (X-minX)/(maxX-minX);
end