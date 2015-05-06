clear all;
close all;
clc;

load('daten3d.mat');
[d, n] = size(data);

[EVal, EVec, m] = pca(data);

%%%%%%%% ORIGINAL DATA %%%%%%%%

% plot data
plot3DPCA(data', m', EVec, EVal, 1, 1);


%%%%%%%% RECONSTRUCTED DATA %%%%%%%%

%projection into 2D
projection2D = zeros(n,2);
for i=1 : 2
    projection2D(:,i) = EVec(:,i)' * (data - m * ones(1,n));
end

%reconstruction to 3D
recData = EVec(:,1:2) * projection2D' + m * ones(1,n);

plot3DPCA(recData', m', EVec, EVal, 1, 1);

%same as: mean(data - recData, n)
uncertainty = sum(abs(data - recData)') / n