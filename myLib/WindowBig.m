function [Y, maxP, minP] = WindowBig(X,local,Par)
%  用来将图像取一个窗口放大的程序
%  [Y, maxP, minP] = WindowBig(X,local,Par)
%  X是输入图像是[0,1]之间的值，彩色或黑白的，Y，是输出图像，一定是彩色的，是一个三维的张量。
%  local 是要放大的块的左上角的位置,以占原图的比例来表示
%  Osz   是块的原大小，以占原图的比例来表示
%  times 是要放大的倍数
%  Place 是放大窗口的方位 
%  outX  是放大的块伸出图像的多小，如0.1代表伸出数是原图大小的0.1倍
%  lineW 是边框线的线宽
%  color 是线的颜色;                                                                               谢琦
%  ifDB  是是否要放大对比度                                                                            2015.9.27
%  Place 是方位：有 'SE','NE', 'SW', 'NW'四个 

if nargin<2
    local=[0.1,0.1];
end
if nargin<3
    Osz    = [0.1,0.1];
    outX   = 0.01;
    lineW  = 1;
    times  = 2;
    color  = [1,0,0];
    ifDB   = 0;
    Place = 'SE';
else
    if isfield(Par,'Osz')
        Osz = Par.Osz;
    else
        Osz = [0.1,0.1];
    end
    
    if isfield(Par,'Place')
        Place = Par.Place;
    else
        Place = 'SE';
    end   
    
    if isfield(Par,'outX')
        outX = Par.outX;
    else
        outX = 0.01;
    end
    if isfield(Par,'lineW')
        lineW = Par.lineW;
    else
        lineW = 1;
    end
    if isfield(Par,'times')
        times = Par.times;
    else
        times = 2;
    end
    if isfield(Par,'color')
        color = Par.color;
    else
        color = [1,0,0];
    end
    if isfield(Par,'ifDB')
        ifDB = Par.ifDB;
    else
        ifDB = 0;
    end
    
end

switch Place
    case{'NE'}
        X = X(end:-1:1,:,:);
    case{'SW'}
        X = X(:,end:-1:1,:);
    case{'NW'}
        X = X(end:-1:1,end:-1:1,:);
end


sizeX   = size(X);
sizeP   = round(sizeX(1:2).*Osz);
sizeOut = round(sizeX(1:2)*outX);
sizeY   = [sizeX(1:2)+2*sizeOut,3];

x1      = max(round(sizeX(1:2).*local),1);
x2      = min(x1+sizeP,sizeX(1:2));

Y       = ones(sizeY);
if length(sizeX)==2
    for i = 1:3
        Y(sizeOut(1)+1:sizeOut(1)+sizeX(1),sizeOut(2)+1:sizeOut(2)+sizeX(2),i) = X;
    end
elseif length(sizeX)==3
    Y(sizeOut(1)+1:sizeOut(1)+sizeX(1),sizeOut(2)+1:sizeOut(2)+sizeX(2),1:3) = X;
else
    error('请输入正确的图像格式')
end
Patch   = Y(x1(1):x2(1),x1(2):x2(2),1:3);
if isfield(Par,'maxP');maxP=Par.maxP;else maxP  = max(Patch(:));end
if isfield(Par,'minP');minP=Par.minP;else minP  = min(Patch(:));end
if ifDB
    Patch = (Patch-minP)/(maxP-minP);
end
rePatch = imresize(Patch,times,'nearest');

resizeP = size(rePatch);
y2      = sizeY(1:2);
y1      = max(1,y2-resizeP(1:2)+1);
Y(y1(1):y2(1),y1(2):y2(2),1:3)=rePatch;

%原块边框线
for i = 1:3
        Y(x1(1):x2(1),[x1(2):x1(2)+lineW-1,x2(2)-lineW+1:x2(2)],i)=color(i);
        Y([x1(1):x1(1)+lineW-1,x2(1)-lineW+1:x2(1)],x1(2):x2(2),i)=color(i);

        Y(y1(1):y2(1),[y1(2):y1(2)+lineW-1,y2(2)-lineW+1:y2(2)],i)=color(i);
        Y([y1(1):y1(1)+lineW-1,y2(1)-lineW+1:y2(1)],y1(2):y2(2),i)=color(i);

end

switch Place
    case{'NE'}
        Y = Y(end:-1:1,:,:);
    case{'SW'}
        Y = Y(:,end:-1:1,:);
    case{'NW'}
        Y = Y(end:-1:1,end:-1:1,:);
end
end