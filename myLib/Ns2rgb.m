function Y =Ns2rgb(X)
%N个谱段的高光谱图转为彩图
sizeX = size(X);
X     = Unfold(X,sizeX,3)';
N     = sizeX(3);
theta = (1:N)'/N;

tranMatrix = MyColorMap(theta);


% tranMatrix   = zeros(N,3); %色彩变换的矩阵
% for i  = 1:3
%     ind1        = ((  ((i-1)/3)<=theta  ).*(  theta<=((i-1)/3+1/6)  ))>.5;
%     ind2        = ((  ((i-1)/3)+1/6<=theta  ).*(  theta<=((i-1)/3+1/3)  ))>.5;
%     Color1      = zeros(1,3); Color1(i) = 1;
%     Change1     = zeros(1,3); Change1(mod(i,3)+1) = 1;
%     Color2      = zeros(1,3); Color2([i, mod(i,3)+1]) = 1;
%     Change2     = zeros(1,3); Change2(i) = -1;
%     tranMatrix(ind1,:) = bsxfun(@plus,Color1,bsxfun(@times, Change1,(theta(ind1)*6-(i-1)*2)))*((4-i)/6+.5)+(i-1)/2*0;
%     tranMatrix(ind2,:) = bsxfun(@plus,Color2,bsxfun(@times, Change2,((theta(ind2))*6-(i-1)*2-1)))*((4-i)/6+.5)+(i-1)/2*0;
% end


Y           = X*tranMatrix;
Y           = Fold(Y',[sizeX(1:2),3],3);
Y           = normalized(Y);
end