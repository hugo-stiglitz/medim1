function [ EVector, b, meanShape, minima, maxima, meanProfile, Sg ] = trainOptimization( aligned, images, landmarks )
%TRAINOPTIMIZATION Summary of this function goes here
%   Detailed explanation goes here

% PCA
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
b(1:15) = 2 * sqrt(EVal(1:15));

EVector = EVec(:,1);

% determine bounds and landmark profiles
nLandmarks = size(landmarks{1},2);
nImgs = 30;

minX = 99999;
minY = 99999;
maxX = 0;
maxY = 0;
minW = 99999;
maxW = 0;
minH = 99999;
maxH = 0;

% get landmark profiles from training set
for i = 1:nImgs
   img2 = images{i};
   shape = landmarks{i}';

   p = getLandmarkProfiles(img2, shape, 8, 0);

   profiles(:,:,i) = p;

   % get min/max of landmarks
   minX = min(minX, min(shape(:,1)));
   maxX = max(maxX, max(shape(:,1)));
   minY = min(minY, min(shape(:,2)));
   maxY = max(maxY, max(shape(:,2)));
   minW = min(minW, maxX-minX);
   maxW = max(maxW, maxX-minX);
   minH = min(minH, maxY-minY);
   maxH = max(maxH, maxY-minY);
end

meanW = max(meanShape(:,1)) - min(meanShape(:,1));
meanH = max(meanShape(:,2)) - min(meanShape(:,2));

% calc meanProfile
for l = 1:nLandmarks
    p = zeros(size(profiles,1),1);
    for i = 1:nImgs
        p = p + profiles(:,l,i);
    end
    meanProfile(:,l) = p / nImgs;
end

% covariance of mean profile
Sg = ourCov(meanProfile);

%minima = [ 0.7; 0; 0; 0 ];
%maxima = [ 1.3; 2*pi; size(img,1); size(img,2) ];
minima = [min(minW/meanW, minH/meanH)*0.9; -pi/2; minX; minY];
maxima = [max(maxW/meanW, maxH/meanH)*1.2; pi/2; maxX; maxY];


end

