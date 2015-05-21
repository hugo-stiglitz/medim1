function [ feature ] = extractFeature( features, featureId )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

for k = 1 : size(features,1)
    x = features(k, 1);
    y = features(k, 2);
    feature(x,y) = features(k, featureId);
end

end

