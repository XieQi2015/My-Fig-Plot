%%得到一个带口子的3D图
function Y = getMsi3D_SB(X0,Hsub,Wsub,Nsub,Nfirst,Par)
% Hsub，Wsub，Nsub是口子的大小
% Nfirst = 5;
sizeX = size(X0);
Par.BG0  = 0;
Y = getMsi3D(X0,Nfirst,Par);
Par.BG0  = 1;
X_sub = X0(1:Hsub,end-Wsub+1:end,Nfirst:Nfirst+Nsub); 
Y_sub = getMsi3D2(X_sub(end:-1:1,end:-1:1,end:-1:1),1,Par);
Y_sub = Y_sub(end:-1:1,end:-1:1,:);
sizeSub = size(Y_sub);
Y_temp = -ones(size(Y));
Y_temp(size(Y,1)-(sizeX(1)-Hsub+sizeSub(1))+1:size(Y,1)-(sizeX(1)-Hsub),sizeX(2)-Hsub+1:sizeX(2)-Hsub+sizeSub(2),:) = Y_sub;
Ind = (Y_temp>=-eps);
Y_temp = max(Y_temp,0);
Y(Ind) =0;
Y(Ind) = 0;
Y = Y+ Y_temp;
end



%%用来画出3D的高光谱图
function Y = getMsi3D2(X0,Nfirst,Par)
% X      是输入的高光谱图
% Nfirst 是哪一页图要被设为首页
% thick  是每个图的厚度，可以不输入，输入的话，则图与图之间用灰线隔开
% thick2 是灰线的粗细
% line   是要不要画边框线，黑色的
% BG0    背景是黑的
line = false;
if nargin<2
    Nfirst = 1;
end
if nargin>2
    if isfield(Par,'thick')
        thick = Par.thick;
    else
        thick = 1;
    end
    if isfield(Par,'Lw')
        Lw = Par.Lw;
    else
        Lw = 0;
    end
    if isfield(Par,'line')
        line = true;
    else
        line = false;
    end
    
    if isfield(Par,'lineColor')
        lineColor = Par.lineColor;
    else
        lineColor = 0;
    end
    
    
    if isfield(Par,'BG0')
        BG0 = Par.BG0;
    else
        BG0 = 0;
    end
    
    sizeX  = size(X0);
    X=0.3*ones(sizeX(1),sizeX(2),(thick+Lw)*sizeX(3));
    for i=1:thick
        X(:,:,i:(thick+Lw):end)=X0;
    end
    Nfirst = (Nfirst-1)*(thick+Lw)+1;
else
    X = X0;
end
X = double(X(:,:,[Nfirst:end,1:Nfirst-1]));
sizeX  = size(X);
imY1   = X(:,:,1)+1;
X2     = permute(X,[3,2,1]);
imX2   = X2(end:-1:1,:,1)+1;
X3     = permute(X,[1,3,2]);
imX3   = X3(:,:,end)+1;

tform1 = affine2d([1 0 0; -1 1 0; 0 0 1]);
imY2   = abs(imwarp(imX2,tform1));
tform1 = affine2d([1 -1 0; 0 1 0; 0 0 1]);
imY3   = abs(imwarp(imX3,tform1));
sizeY  = max([sizeX(1)+size(imY2,1),sizeX(2)+size(imY3,2)],[size(imY3,1),size(imY2,2)]);
Y      = zeros(sizeY);
Y(end-sizeX(1)+1:end,1:sizeX(2))              = Y(end-sizeX(1)+1:end,1:sizeX(2))+imY1;
Y(1:size(imY2,1),1:size(imY2,2))              = Y(1:size(imY2,1),1:size(imY2,2))+imY2;
Y(1:size(imY3,1),end-size(imY3,2)+1:end)      = Y(1:size(imY3,1),end-size(imY3,2)+1:end)+imY3;
if BG0
    Y = Y-1;
else
    Y = abs(Y-1);
end
if line
    Y([end-sizeX(1)+1,end],1:sizeX(2),:)=lineColor;
    Y(end-sizeX(1)+1:end,[1,sizeX(2)],:)=lineColor;
    Y(1,sizeY(2)-sizeX(2)+1:sizeY(2),:)=lineColor;
    Y(1:sizeX(1),end,:)=lineColor;    
    for i=sizeX(2)+1:size(Y,2);
        Y(size(Y,2)+1-i,i)=lineColor;
        Y(size(Y,2)+1-i,i+1-sizeX(2))=lineColor;
        Y(size(Y,2)+size(X,1)+1-i,i)=lineColor;
    end
end
end



