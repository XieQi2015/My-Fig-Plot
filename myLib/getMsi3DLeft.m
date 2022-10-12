%%��������3D�ĸ߹���ͼ ������
function Y = getMsi3DLeft(X0,Nfirst,Par)
% X      ������ĸ߹���ͼ
% Nfirst ����һҳͼҪ����Ϊ��ҳ
% thick  ��ÿ��ͼ�ĺ�ȣ����Բ����룬����Ļ�����ͼ��ͼ֮���û��߸���
% Lw     �ǻ��ߵĴ�ϸ
% line   ��Ҫ��Ҫ���߿��ߣ���ɫ��
% BG0    �����Ǻڵ�
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
        lineColor = 1;
    end
    
    if isfield(Par,'theta')
        theta = Par.theta;
    else
        theta = pi/3;
    end
    
    if isfield(Par,'BG0')
        BG0 = Par.BG0;
    else
        BG0 = 0;
    end
    
    sizeX  = size(X0);
    X=lineColor*ones(sizeX(1),sizeX(2),(thick+Lw)*sizeX(3));
    for i=1:thick
        X(:,:,i:(thick+Lw):end)=X0;
    end
    Nfirst = (Nfirst-1)*(thick+Lw)+1;
else
    X = X0;
end
X = double(X(:,:,[Nfirst:end,1:Nfirst-1]));
imX1   = X(:,:,1)+1;
X2     = permute(X,[2,3,1]);
imX2   = X2(:,:,1)+1;
X3     = permute(X,[1,3,2]);
imY3   = X3(:,:,end)+1;

if line
    imX1(1:end,[1,end])=lineColor+1;
    imX1([1,end],1:end)=lineColor+1;
    imX2(1:end,[1,end])=lineColor+1;
    imX2([1,end],1:end)=lineColor+1;
    imY3(1:end,[1,end])=lineColor+1;
    imY3([1,end],1:end)=lineColor+1;

end



alpha = pi/3;
tform1 = affine2d([cos(theta)*cos(alpha)  sin(theta)*cos(alpha) 0; 0 1 0; 0 0 1]);
imY1   = abs(imwarp(imX1,tform1));
tform1 = affine2d([1 0 0; cos(theta)*cos(alpha) sin(theta)*cos(alpha) 0; 0 0 1]);
imY2   = abs(imwarp(imX2,tform1));
% tform1 = affine2d([1 -1 0; 0 1 0; 0 0 1]);
% imY3   = abs(imwarp(imX3,tform1));
sizeY  = max([size(imY2,1)+size(imY3,1),size(imY1,2)+size(imY3,2)],[size(imY1,1),size(imY2,2)]);
Y      = zeros(sizeY);
Y(1:size(imY1,1),1:size(imY1,2))              = Y(1:size(imY1,1),1:size(imY1,2))+imY1;
Y(1:size(imY2,1),1:size(imY2,2))              = Y(1:size(imY2,1),1:size(imY2,2))+imY2;
Y(end-size(imY3,1)+1:end,end-size(imY3,2)+1:end)      = Y(end-size(imY3,1)+1:end,end-size(imY3,2)+1:end)+imY3;
if BG0
    Y = max(Y-1,0);
else
    Y = abs(Y-1);
end
% if line
%     Y([end-sizeX(1),end],end-size(imY3,2):end,:)=lineColor;
%     Y(end-sizeX(1):end,[end,end-size(imY3,2)],:)=lineColor;
%     Y(1,1:size(imY3,2),:)=lineColor;
%     Y(1:size(imY3,1),1,:)=lineColor;    
%     for i=1:size(imY1,2);
%         Y(size(Y,2)+1-i,i)=lineColor;
%         Y(size(Y,2)+1-i,i+1-sizeX(2))=lineColor;
%         Y(size(Y,2)+size(X,1)+1-i,i)=lineColor;
%     end
% end
end

