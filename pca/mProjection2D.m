clear all;
close all;
clc;

load('daten.mat');
data = data3;
[d, n] = size(data);

[EVal, EVec, m] = pca(data);

%%%%%%%% MAIN VECTOR %%%%%%%%

%projection into 1 dimension
projection1D = EVec(1,:) * (data - m * ones(1,n));

%reconstruction to 2D
recData = EVec(1,:)' * projection1D + m * ones(1,n);

plot2DPCA(data', m, recData', EVec', EVal, 1, 1);

%same as: mean(data - recData, n)
uncertaintyMain = sum(abs(data - recData)') / n


%%%%%%%% SIDE VECTOR %%%%%%%%

projection1D = EVec(2,:) * (data - m * ones(1,n));
recData = EVec(2,:)' * projection1D + m * ones(1,n);
plot2DPCA(data', m, recData', EVec', EVal, 1, 1);
uncertaintySide = sum(abs(data - recData)') / n