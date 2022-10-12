%% ��ɫ���ӻ��߹���ͼʾ���ļ�
clear; clc;
addpath('myLib')
load('fake_and_real_food_ms');
mkdir('outputImage')

%% ������ɫ3D�߹���ͼ
theFrame = 5; % �Եڼ�֡Ϊ����
colorType = 5;
for i  = 1:31
temp(:,:,i) = (msi(:,:,32-i));
end
ColorMsi = MyColorMap(min(temp,1),colorType,[-0.025,0.6]);
% Par.Lw = 1;
Par.line = 1;
Par.thick = 1;
Par.lineColor = 0.8;
for i = 1:3
    Y(:,:,i) = getMsi3D(ColorMsi(:,:,:,i),theFrame,Par);
end
figure(1); imshow(Y)
imwrite(Y,'outputImage/MSI.png')

%% ���������ӵ�3D�߹���ͼ
for i  = 1:31
temp(:,:,i) = (msi(:,:,32-i));
end
ColorMsi = MyColorMap(min(temp,1),colorType,[-0.025,0.6]);
% Par.Lw = 1;
Par.line = 1;
Par.thick = 1;
Par.lineColor = 0.8;
for i = 1:3
    
    Y(:,:,i) = getMsi3D_SB(ColorMsi(:,:,:,i),85,85,11,theFrame,Par);
end
figure(2); imshow(Y)
imwrite(Y,'outputImage/MSI_plus.png')

%% ɫ��
Ind = (200:-1:1)'/200;
Ind = repmat(Ind,[1,30]);
Ind = MyColorMap( Ind,colorType,[-0.055,1]);
imwrite(Ind, 'outputImage/Colorbar.png')
figure(3); imshow(Ind)

%% �����ڰ�3D�߹���ͼ
theFrame = 5; % �Եڼ�֡Ϊ����
colorType = 5;
for i  = 1:31
temp(:,:,i) = normalized(msi(:,:,32-i));
end
% Par.Lw = 1;
Par.line = 1;
Par.thick = 1;
Par.lineColor = 0.8;
greyY= getMsi3D(temp*1.9,theFrame,Par);
figure(4); imshow(greyY)
imwrite(greyY,'outputImage/GreyMSI.png')

%% ��ͼ
RGB = normalized(RGB)/0.85+0.15;
figure(5);imshow(RGB,[])
mkdir('outputImage')
imwrite(RGB,'outputImage/RGB.png')


%% ������ͼ��
% 



% %% get Z
% for i  = 1:31
% Ztemp(:,:,i) = imresize(temp(1:8:end,1:8:end,i),2,'nearest');
% end
% 
% ColorMsi = MyColorMap( min(Ztemp,1),colorType,[-0.025,0.6]);
% Par.line = 1;
% 
% Par.lineColor = 0.8;
% for i = 1:3
%     zY(:,:,i) = getMsi3D(ColorMsi(:,:,:,i),theFrame,Par);
% end
% % figure(3); imshow(zY)
% imwrite(zY,'outputImage/ZMSI.png')
% 
% %% get YA
% RGB = Unfold(RGB,size(RGB),3);
% X = Unfold(msi,size(msi),3);
% YA = Fold(X*RGB'/(RGB*RGB')*RGB,size(msi),3);
% 
% for i  = 1:31
% temp(:,:,i) = (YA(:,:,32-i));
% end
% ColorMsi = MyColorMap( min(temp,1),colorType,[-0.025,0.6]);
% Par.lineColor = 0.8;
% for i = 1:3
%     Y(:,:,i) = getMsi3D(ColorMsi(:,:,:,i),theFrame,Par);
% end
% % figure(4); imshow(Y)
% imwrite(Y,'outputImage/YA.png')
% 
% %% get YB
% YB = msi - YA;
% 
% for i  = 1:31
% temp(:,:,i) = (YB(:,:,32-i));
% end
% ColorMsi = MyColorMap( min(temp,1),colorType,[-0.055,0.6]);
% Par.lineColor = 0.8;
% for i = 1:3
%     Y(:,:,i) = getMsi3D(ColorMsi(:,:,:,i),theFrame,Par);
% end
% % figure(5); imshow(Y)
% imwrite(Y,'outputImage/YB.png')
% 
% %% get Yhat
% 
% [V,S,U] = svd(Unfold(YB,size(msi),3),'econ');
% Yhat    = Fold(U', size(msi),3);
% temphat    = normalized(abs(Yhat(:,:,1:10)));
% ColorMsi = MyColorMap( min(temphat,1),colorType,[-0.025,0.5]);
% Par.lineColor = 0.8;
% Par.Lw = 1;
% Par.thick = 2;
% for i = 1:3
%     tempY(:,:,i) = getMsi3D(ColorMsi(:,:,:,i),1,Par);
% end
% % figure(6); imshow(tempY)
% imwrite(tempY,'outputImage/Yhat.png')
% 
% % figure(7); imshow(normalized(min(max(normalized((Yhat(:,:,2:4))),0.3),0.6)),[])
% imwrite(normalized(min(max(normalized((Yhat(:,:,2:4))),0.3),0.6)),'outputImage/Yhat2.png')
% 

