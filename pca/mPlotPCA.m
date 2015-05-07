clear all;
close all;
clc;

load('daten.mat');
data(:,:,1) = data1;
data(:,:,2) = data2;
data(:,:,3) = data3;
data(:,:,4) = data4;

dataCount = size(data);
for i=1:dataCount(3)
    D = data(:,:,i);
    [EVal, EVec, m] = pca(D);
    % * data D must be transposed for plot
    % * eigenvectors EVec must be transposed for plot (plot2DPCA needs
    %eigenvectors in colums)
    plot2DPCA(D', m, D', EVec, EVal, 1, 1);
end