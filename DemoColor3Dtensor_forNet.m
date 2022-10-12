%% 画网络模块的示例
clear; clc;
% Xind = 140:340;Yind = 280:480;
addpath('myLib')
load('fake_and_real_food_ms');
% RGB = double(imread('fake_and_real_food_RGB.bmp'))/255;
mkdir('outputImage2')

% RGB = RGB(Xind,Yind,:);
% msi = msi(Xind,Yind,:);
RGB = normalized(RGB)/0.85+0.15;

%% 侧向的彩图
imwrite(RGB,'outputImage2/RGB.png')
theta = pi/3;
tform1 = affine2d([cos(theta)*cos(theta)  sin(theta)*cos(theta) 0; 0 1 0; 0 0 1]);
tempRGB   = abs(abs(imwarp(RGB+1,tform1))-1);
imwrite(tempRGB,'outputImage2/RGB2.png')
figure(1);
imshow(tempRGB)

theFrame = 5;
colorType = 5;
%% 侧向的 彩色MSI
for i  = 1:31
temp(:,:,i) = (msi(:,:,32-i));
end
ColorMsi = MyColorMap(min(temp,1),colorType,[-0.025,0.6]);
% Par.Lw = 1;
Par.line = 1;
Par.thick = 2;
Par.lineColor = 0.8;
for i = 1:3
    Y(:,:,i) = getMsi3DLeft(ColorMsi(:,:,:,i),theFrame,Par);
end
figure(2); imshow(Y)
imwrite(Y,'outputImage2/MSI.png')


Ind = (200:-1:1)'/200;
Ind = repmat(Ind,[1,30]);
Ind = MyColorMap( Ind,colorType,[-0.055,1]);
imwrite(Ind, 'outputImage2/Colorbar.png')

figure(3); imshow(Ind)

%% 其它网络模块的画图
% %% get Z
% for i  = 1:31
% Ztemp(:,:,i) = imresize(temp(1:8:end,1:8:end,i),2,'nearest');
% Ztemp2(:,:,i) = imresize(temp(1:32:end,1:32:end,i),32);
% end
% ColorMsi = MyColorMap( min(Ztemp,1),colorType,[-0.025,0.6]);
% ColorMsi222 = MyColorMap( min(Ztemp2,1),colorType,[-0.025,0.6]);
% for i = 1:3
%     zY(:,:,i) = getMsi3DLeft(ColorMsi(:,:,:,i),theFrame,Par);
%     zY222(:,:,i) = getMsi3DLeft(ColorMsi222(:,:,:,i),theFrame,Par);
% end
% % figure(3); imshow(zY)
% imwrite(zY,'outputImage2/ZMSI.png')
% imwrite(zY222,'outputImage2/ZMSI222.png')
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
% for i = 1:3
%     Y(:,:,i) = getMsi3DLeft(ColorMsi(:,:,:,i),theFrame,Par);
% end
% % figure(4); imshow(Y)
% imwrite(Y,'outputImage2/YA.png')
% 
% 
% IndYhat = [1:10];
% %% get Yhat
% YB = msi - YA;
% [V,S,U] = svd(Unfold(YB,size(msi),3),'econ');
% Yhat    = Fold(U', size(msi),3);
% temphat    = normalized(abs(Yhat(:,:,2:11)));
% ColorMsi = MyColorMap( min(temphat,1),colorType,[-0.025,0.5]);
% Par.lineColor = 0.9;
% Par.Lw = 1;
% Par.thick = 2;
% for i = 1:3
%     tempY(:,:,i) = getMsi3DLeft(ColorMsi(:,:,:,i),1,Par);
% end
% % figure(6); imshow(tempY)
% imwrite(tempY,'outputImage2/Yhat1.png')
% temphat    = normalized(abs(Yhat(:,:,1:10)));
% ColorMsi = MyColorMap( min(temphat,1),colorType,[-0.025,0.5]);
% 
% for i = 1:3
%     tempY(:,:,i) = getMsi3DLeft(ColorMsi(:,:,:,i),1,Par);
% end
% % figure(6); imshow(tempY)
% imwrite(tempY,'outputImage2/Yhat.png')
% 
% 
% clear Par
% Par.line = 1;
% Par.thick = 2;
% Par.lineColor = 0.9;
% %% get YB
% 
% %% 之前的结果 不要这些
% S(1,1) = S(1,1)/1.5;
% U(:,1) = U(:,1)/1.5;
% U(:,2) = U(:,2)/2;
% %% 之前的结果 不要这些
% 
% 
% B  = S(IndYhat,IndYhat)*V(:,IndYhat)';
% YB = U(:,IndYhat)*B;
% YB = Fold(YB', size(msi),3);
% 
% for i  = 1:31
% temp(:,:,i) = (YB(:,:,32-i));
% end
% ColorMsi = MyColorMap( min(temp,1),colorType,[-0.055,0.6]);
% clear Y
% for i = 1:3
%     Y(:,:,i) = getMsi3DLeft(ColorMsi(:,:,:,i),theFrame,Par);
% end
% % figure(5); imshow(Y)
% imwrite(Y,'outputImage2/YB.png')
% %% get tempX
% 
% tempX = YA+YB;
% for i  = 1:31
% temp(:,:,i) = (tempX(:,:,32-i));
% end
% ColorMsi = MyColorMap(min(temp,1),colorType,[-0.025,0.6]);
% % Par.Lw = 1;
% Par.line = 1;
% Par.thick = 2;
% Par.lineColor = 0.8;
% for i = 1:3
%     Y(:,:,i) = getMsi3DLeft(ColorMsi(:,:,:,i),theFrame,Par);
% end
% % figure(2); imshow(Y)
% imwrite(Y,'outputImage2/MSItemp.png')
% 
% 
% 
% %% get CX
% for i  = 1:31
% Ztemp(:,:,i) = imresize(tempX(1:8:end,1:8:end,32-i),2,'nearest');
% end
% ColorMsi = MyColorMap( min(Ztemp,1),colorType,[-0.025,0.6]);
% for i = 1:3
%     zY(:,:,i) = getMsi3DLeft(ColorMsi(:,:,:,i),theFrame,Par);
% end
% % figure(3); imshow(zY)
% imwrite(zY,'outputImage2/CX.png')
% 
% 
% %% get ZE
% ErrorZ = abs(msi - tempX); 
% for i  = 1:31
% Ztemp(:,:,i) = imresize(ErrorZ(1:8:end,1:8:end,32-i),2,'nearest');
% end
% ColorMsi = MyColorMap( min(Ztemp,1),colorType,[-0.025,0.4]);
% ColorMsi2 = MyColorMap( min(ErrorZ,1),colorType,[-0.025,0.4]);
% for i = 1:3
%     zY(:,:,i) = getMsi3DLeft(ColorMsi(:,:,:,i),theFrame,Par);
%     zE(:,:,i) = getMsi3DLeft(ColorMsi2(:,:,:,i),theFrame,Par);
% end
% % figure(3); imshow(zY)
% % imwrite(zE,'outputImage2/ZEup.png')
% % imwrite(zY,'outputImage2/ZE.png')
% 
% %% get EY
% ErrorZ = abs(Fold( A'*Unfold(msi-tempX,size(msi),3), [size(msi,1), size(msi,2), 3], 3)); 
% imshow(ErrorZ*10)
% % figure(3); imshow(zY)
% imwrite(ErrorZ*10,'outputImage2/YE.png')
% theta = pi/3;
% tform1 = affine2d([cos(theta)*cos(theta)  sin(theta)*cos(theta) 0; 0 1 0; 0 0 1]);
% tempRGB   = abs(abs(imwarp(ErrorZ*10+1,tform1))-1);
% imwrite(tempRGB,'outputImage2/YE2.png')
% 
% 
% %% get G
% 
% % G = Unfold(ErrorZ, size(msi),3)';
% % G = G*B';
% % G = Fold(G', [size(msi,1),size(msi,2),10],3);
% % G = abs(G);
% % for i  = 1:10
% %    G(:,:,i) = normalized(G(:,:,i)); 
% % end
% % G = G/1.3;
% % % G = G(:,:,[6:end,1:6-1]);
% % % G(:,:,1) = G(:,:,1)/5;
% % 
% % ColorMsi = MyColorMap( G,colorType,[-0.025,1.5]);
% % Par.Lw = 1;
% % Par.thick = 2;
% % for i = 1:3
% %     GY(:,:,i) = getMsi3DLeft(ColorMsi(:,:,:,i),theFrame,Par);
% % end
% % % figure(3); imshow(zY)
% % imwrite(GY,'outputImage2/G.png')
% 
% G = normalized(abs(Yhat(:,:,1:10))) - normalized(abs(Yhat(:,:,2:11)));  
% G = abs(G);
% % for i  = 1:10
% %    G(:,:,i) = normalized(G(:,:,i)); 
% % end
% G = G/1.3;
% % G = G(:,:,[6:end,1:6-1]);
% % G(:,:,1) = G(:,:,1)/5;
% 
% ColorMsi = MyColorMap( G,colorType,[-0.025,0.4]);
% Par.Lw = 1;
% Par.thick = 2;
% for i = 1:3
%     GY(:,:,i) = getMsi3DLeft(ColorMsi(:,:,:,i),1,Par);
% end
% % figure(3); imshow(zY)
% imwrite(GY,'outputImage2/G.png')
% 
% 
% 
% % figure(7); imshow(normalized(min(max(normalized((Yhat(:,:,2:4))),0.3),0.6)),[])
% imwrite(normalized(min(max(normalized((Yhat(:,:,2:4))),0.3),0.6)),'outputImage2/Yhat2.png')
% 

