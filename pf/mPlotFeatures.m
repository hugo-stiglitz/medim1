clear all;
close all;
clc;

load ('handdata.mat');
img = images{1,1};
[height,width] = size(img);
imgSize = [height width];

figure;
%plot image
imshow(img);

%compute features
features = computeFeatures(img);

%%plot features

%gray values
figure;
imagesc(extractFeature(features, 3, imgSize));
axis('equal');
title('gray values');

%gradient
figure;
[x,y] = meshgrid(1:width,1:height);
xG = extractFeature(features, 4, imgSize)
yG = extractFeature(features, 5, imgSize);
quiver(x,y,xG,yG);
axis('equal');
title('gradient');

%haar-like gray-value
figure;
imagesc(extractFeature(features, 6, imgSize));
axis('equal');
title('haar-like gray');

%haar-like gradient
figure;
imagesc(extractFeature(features, 26, imgSize));
axis('equal');
title('haar-like gradient');
