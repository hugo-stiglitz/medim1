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
features = cache(@computeFeatures, img);

% without cache
%features = computeFeatures(img);

%%plot features

%gray values
figure;
imagesc(extractFeature(features, 3, imgSize));
axis('equal');
title('gray values');

%gradient
figure;
xG = extractFeature(features, 4, imgSize);
yG = extractFeature(features, 5, imgSize);
% vector plot:
%[x,y] = meshgrid(1:width,1:height);
%quiver(x,y,xG,yG);
subplot(1,2,1);
imagesc(xG);
axis('equal');
title('gradient - x');
subplot(1,2,2);
imagesc(yG);
axis('equal');
title('gradient - y');

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