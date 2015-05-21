clear all;
close all;
clc;

load ('handdata.mat');
img = images{1,1};
[height,width] = size(img);

figure;
%plot image
imshow(img);

%compute features
features = computeFeatures(img);

%%plot features

%gray values
figure;
imagesc(extractFeature(features, 3));
axis('equal');
title('gray values');

%gradient
figure;
hold on;
imagesc(img);
x = extractFeature(features, 1);
y = extractFeature(features, 2);
xG = extractFeature(features, 3);
yG = extractFeature(features, 4);
quiver(x,y,xG,yG);
axis('equal');
title('gradient');
%TODO