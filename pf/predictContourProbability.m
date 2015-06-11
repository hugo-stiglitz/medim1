function [ prediction ] = predictContourProbability( rf, img )
%PREDICT Summary of this function goes here
%   Detailed explanation goes here

imgFeatures = cache(@computeFeatures, img);

[predictionLabels, scores] = rf.predict(imgFeatures);
prediction = zeros(size(img));

nImgFeatures = size(predictionLabels,1);
for k = 1:nImgFeatures

    x = imgFeatures(k, 1);
    y = imgFeatures(k, 2);

    % propability of being contour
    prediction(y,x) = scores(k,2);
end

end

