function Y = normalized(X)
%%���������ݷŵ�[0,1]֮��
maxX = max(X(:));
minX = min(X(:));
Y    = (X-minX)/(maxX-minX);
end