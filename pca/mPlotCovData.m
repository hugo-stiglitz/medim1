clear all;
%close all;
%clc;

load('daten.mat')
data(:,:,1) = data1;
data(:,:,2) = data2;
data(:,:,3) = data3;
data(:,:,4) = data4;

figure('Name', 'covariance of data', 'NumberTitle', 'off');

dataCount = size(data);
for i=1:dataCount(3)
    d = data(:,:,i);
    covData = ourCov(d);
    subplot(2,2,i);
    plot(d(1,:),d(2,:),'.');
    title(strcat('data', num2str(i)));
    legend(strcat('cov:', num2str(covData(2,1))));
    axis('equal');
end