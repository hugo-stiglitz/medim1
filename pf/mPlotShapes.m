clear all;
close all;
clc;

load('handdata.mat');

%%
% Aufgabe 1

[nPoints nDimensions nShapes] = size(aligned);

% calculate mean shape
meanShape = mean(aligned,3);

% create landmarks from shapes
for i = 1:nShapes
    tmp = aligned(:,:,i);
    D(:,i) = tmp(:);
end

% calculate PCA
[EVal, EVec, m] = pca(D);

% create parameter vector
b = zeros(size(EVal,1), 1);
b(1) = 2 * sqrt(EVal(1));

% create some random shapes
s(:,:,1) = generateShape(EVec(:,1), b, meanShape, 1, 0, 0, 0);
s(:,:,2) = generateShape(EVec(:,1), b, meanShape, 1, 0, 10, 30);
s(:,:,3) = generateShape(EVec(:,1), b, meanShape, 1.4, 0, 0, 10);
s(:,:,4) = generateShape(EVec(:,1), b, meanShape, 0.8, pi/2, 0, 0);
s(:,:,5) = generateShape(EVec(:,1), b, meanShape, 0.3, pi, 20, 20);

plotShape(s, meanShape);
title('shapes b(1) = 2*stdv - scaled / rotated / translated');