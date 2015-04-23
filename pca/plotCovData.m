clear all;
close all;
clc

load('daten.mat')
data(:,:,1) = data1;
data(:,:,2) = data2;
data(:,:,3) = data3;
data(:,:,4) = data4;

figure('Name', 'covariance of data', 'NumberTitle', 'off');

dataCount = size(data);
for i=1:dataCount(3)
    d = data(:,:,i);
    covData = ourCov(d)
    subplot(2,2,i);
    plot(d(1,:),d(2,:),'.');
    title(strcat('data', num2str(i), '-cov:', num2str(covData(2,1))));
    axis('equal');
end

% %test:
%
% figure
% 
% covData = ourCov(data1);
% subplot(2,2,1)
% plot(covData)
% title(strcat('data', num2str(1)))
% axis('equal')
% 
% covData = ourCov(data2);
% subplot(2,2,2)
% plot(covData)
% title(strcat('data', num2str(2)))
% axis('equal')
% 
% covData = ourCov(data3);
% subplot(2,2,3)
% plot(covData)
% title(strcat('data', num2str(3)))
% axis('equal')
% 
% covData = ourCov(data4);
% subplot(2,2,4)
% plot(covData)
% title(strcat('data', num2str(4)))
% axis('equal')
