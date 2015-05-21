function [ feature ] = extractFeature( features, featureId, imgSize )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

feature = zeros(imgSize);
for k = 1 : size(features,1)
    x = features(k, 1);
    y = features(k, 2);
    feature(x,y) = features(k, featureId);
end

end

