function Y = MyColorMap(X,type,range)
%% 画出一个二维图的ColorMap
% X是输入的灰度图像
% Y是返出的彩图
% type ==1 时全彩环形
% type ==2 时 winter
% type ==3 时全彩一线
% type ==4 时全彩零黑
% type ==5 时全彩软色
% See also CColorBar

if type==0
    X = (X-range(1))/(range(2)-range(1));
    X = max(min(X,1),0);
    Y = X;
    return
end

if nargin <3
    X = normalized(X);
else
    X = (X-range(1))/(range(2)-range(1));
    X = max(min(X,1),0);
end

sizeX = size(X);
X = X(:);
Y = ones(length(X), 3);

if nargin <=1
    type=1;
end

if type==2
    X = X/2;
end

if type==3%||type==5
    X = X*5/6;
end

if type==6
    X =X.^0.7*5/6;
    X0 = X;
%     X = mod(X-0/24,1);
    X = mod(X,1);
end 

if type==4
    X0 = X;
    X = mod(X-1/6,1);
end   
   


if type==5
    X = X*5/6;
    X0 = X;
    X = mod(X-0/24,1);
end  

for i  = 1:3
    ind1        = ((  ((i-1)/3)<=X  ).*(  X<=((i-1)/3+1/6)  ))>.5;
    ind2        = ((  ((i-1)/3)+1/6<=X  ).*(  X<=((i-1)/3+1/3)  ))>.5;
    if type~=5
        Color1      = zeros(1,3);     Color1(i)   = 1;
        Change1     = zeros(1,3); Change1(mod(i,3)+1) = 1;
        Color2      = zeros(1,3);     Color2([i, mod(i,3)+1]) = 1;
        Change2     = zeros(1,3); Change2(i) = -1;
    else
        Color1 = ones(1,3)*0.25;     Color1(i)   = 1;
        Change1     = zeros(1,3); Change1(mod(i,3)+1) = 0.75;
        Color2 = ones(1,3)*0.25; Color2([i, mod(i,3)+1]) = 1;
        Change2     = zeros(1,3); Change2(i) = -0.75;
    end


    Y(ind1,:) = bsxfun(@plus,Color1(end:-1:1),bsxfun(@times, Change1(end:-1:1),(X(ind1)*6-(i-1)*2)));
    Y(ind2,:) = bsxfun(@plus,Color2(end:-1:1),bsxfun(@times, Change2(end:-1:1),((X(ind2))*6-(i-1)*2-1)));
end

% if type==3
%     Y = bsxfun(@times, Y, 0.5+sqrt((min(X*6/5,0.5)*2))/2);
% end

if type==4%||type==5
    X = min(X0,1/6)*6;
    Y = bsxfun(@times, Y, X);
end

if type==6
%     X = min(X0,1/6)*6*0.8+0.2;
    X = X.^.2*0.8+0.3;
    Y = bsxfun(@times, Y, X);
end

if type==5

    [Ymax,Ind] = max(Y,[],2);
    for i  = 1:3
            temp = Y(:,i);
            temp(Ind==i) = temp(Ind==i)+0.1;
            temp(Ind~=i) = (temp(Ind~=i)+0.1)*1.2;
            Y(:,i) = temp-0.1;
    end
%     X = (min(X0,1/2)*2.5+0.4)/1.4;
    X = (min(X0,1/6)*6+0.2)/1.2;
    Y = bsxfun(@times, Y, X);

end


Y = (Fold(Y', [sizeX,3],length(sizeX)+1));


end




