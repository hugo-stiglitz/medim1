function [ prediction ] = predictContour( rf, img )
%PREDICT Summary of this function goes here
%   Detailed explanation goes here

imgFeatures = cache(@computeFeatures, img);

predictionLabels = rf.predict(imgFeatures);
prediction = zeros(size(img));

nImgFeatures = size(predictionLabels,1);
for k = 1:nImgFeatures

    x = imgFeatures(k, 1);
    y = imgFeatures(k, 2);
    if (strcmp(predictionLabels{k}, 'Contour'))
        % point is on contour
        prediction(y,x) = 1.0;
    end
end

end

