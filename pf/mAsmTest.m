close all;
clc;

load ('handdata.mat');

img = images{1};
contour = masks{1};
shape = landmarks{1};

nLandmarks = size(landmarks{1},2);
nImgs = 30;

% get landmark profiles from training set
for i = 1:nImgs
   img = images{i};
   shape = landmarks{i};
   
   p = getLandmarkProfiles(img, shape, 8, i==1);
   
   profiles(:,:,i) = p;
end

% calc meanProfile
for l = 1:nLandmarks
    p = zeros(size(profiles,1),1);
    for i = 1:nImgs
        p = p + profiles(:,l,i);
    end
    meanProfile(:,l) = p /nImgs;
end

% covariance of mean profile
Sg = ourCov(meanProfile);