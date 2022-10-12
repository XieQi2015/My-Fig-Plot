
function DemoColorBar(type, ifWrite)
% 用来画出 MyColorMap的圆形ColorBar
% See also MyColorMap
if nargin <1
   type=1; 
   ifWrite = 0;
elseif nargin<2
   ifWrite = 0;
end

if nargin>=1
   if type~=1&&type~=2
       if type~=3&&type~=4
           if type~=5&&type~=6
               error('第一个输入必需为 1 到 6 的整数');
           end
       end
   end
   if nargin>=2
       if ifWrite~=1
           if ifWrite~=0
               error('第二个输入必需为 0 或 1')
           end
       end
   end
end

r     = 800;
sizeX = 2*r+1;
X = (1:sizeX)-r-1;
X = repmat(X,sizeX,1);
Y = X';
Ind = ((X.^2+Y.^2)>(.5*r).^2);
Ind = ((X.^2+Y.^2)<(.9*r).^2).*Ind;
% imshow(Ind)
Circle = zeros(sizeX,sizeX);
% n = 18.01; % 离散色环
n = 180.1; %连续色环
for theta  = -pi/2:(pi/n):pi/2
tempInd = (Y-tan(theta)*X)>0;
tempInd = ((Y-tan(theta+pi/n)*X)<=0).*tempInd.*Ind;
tempInd = tempInd>.5;
Circle(tempInd) = -theta+pi/2;
end

Circle =Circle+Circle(end:-1:1,end:-1:1)+pi*(X<0).*Ind;
Circle(1:r,r+1) = pi;
Circle = mod(Circle,2*pi);
Circle = Circle.*Ind;
Circle = MyColorMap(reshape(1-Circle(:)/pi/2,[sizeX,sizeX]),type);
Ind = (Ind<.5);
Ind = repmat(Ind,[1,1,3]);
Circle(Ind) = 1;
Circle = imresize(Circle, 0.2);
imshow(normalized(Circle));
if ifWrite
imwrite(Circle,'ColorCircle.png');
end
end