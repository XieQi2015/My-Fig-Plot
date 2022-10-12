%% 图像窗口放大的程序基础示例
clc;clear;close all;
addpath('myLib')
X = imread('SS.png');
X = double(X)/256;
SizeFig = [1000, 900];
Lca     = [0.03,0.08]*1080;
Fig1 = figure(1); 

subplot(221);imshow(X);title('Orl');
Par.lineW = 5;
Par.times   = 3;
Par.Osz   = 0.1;
% local     = [0.33,0.48];
local     = [0.46,0.62];
Y1 = WindowBig(X,local,Par);
subplot(222);imshow(Y1);title('windowBig');
X2 = rgb2gray(X);
subplot(223);imshow(X2);title('Orl');
Y2 = WindowBig(X2,local,Par);
subplot(224);imshow(Y2);title('windowBig');
set(Fig1, 'Position',[Lca , SizeFig], 'Name','Clean Image');
imwrite(X2,'SSgry.png');
imwrite(Y1,'windBig.png');
imwrite(Y2,'gryWindBig.png');