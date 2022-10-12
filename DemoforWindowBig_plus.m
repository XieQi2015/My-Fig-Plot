function DemoforWindowBig_plus
%% 图像窗口放大程序高阶示例
addpath('myLib')
mkdir('outImage3');
local1 = [0.37,0.86]; % 第一个框的位置
local2 = [0.46,0.72]; % 第二个框的位置
colorType = 6;
nframe = 20;
load('fake_and_real_food_ms');
tempX = msi(:,:,nframe);
Imin  = min(tempX(:))-0;
Imax  = max(tempX(:))-0.0;
tempMsi   = MyColorMap(msi(:,:,nframe),colorType,[Imin,Imax]); % 伪彩色
GT = WB(tempMsi,local1,local2); %放大图像窗
figure(1);imshow(tempMsi)
imwrite(tempMsi,'outImage3/exampleOrl.png')
figure(2);imshow(GT)
imwrite(GT,'outImage3/exampleWB.png')
end

function  [outX, Pmin1,Pmax1, Pmin2, Pmax2] = WB(outX,local1,local2)
Par.lineW = 3;
Par.times = 3;
Par.ifDB = 0;
Par.Osz = 0.1;
Par.outX = 0.01;
Par.color = [1,0,0];
Par.Place = 'SE';
[outX, Pmax1,Pmin1] = WindowBig(outX,local1,Par);
Par.outX  = 0; %要注意这里的变化
Par.color = [0,1,0];
Par.Place = 'NW';
[outX, Pmax2,Pmin2] = WindowBig(outX,local2,Par);

end
