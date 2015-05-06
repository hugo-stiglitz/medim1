clear all;
close all;
clc;

load('daten3d.mat');
[d, n] = size(data);

[EVal, EVec, m] = pca(data);

%%%%%%%% MAIN VECTOR %%%%%%%%

%projection into 2D
for i=1 : 2
    projection2D(i,:) = EVec(i,:) * (data - m * ones(1,n));
end

EVec
projection2D

%reconstruction to 3D
for i=1 : 2
    recData(i,:) = EVec(i,:)' * projection2D(i,:) + m * ones(1,n);
end

plot3DPCA(data', m, EVec', EVal, 1, 1);
plot3DPCA(recData', m, EVec', EVal, 1, 1);

%same as: mean(data - recData, n)
uncertainty = sum(abs(data - recData)') / n