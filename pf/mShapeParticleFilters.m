% Aufgabe 4

%clear all;
close all;
clc;

load ('handdata.mat');

%Aufgabe 4a

% check if rf already exists, so it doesnt have to be computed every time
if (exist('rf') == 0)
    rf = train(images(1:30), masks(1:30));
end

 % get feature for images
img = images{31};
imgFeatures = cache(@computeFeatures, img);

predictionLabels = rf.predict(imgFeatures);
prediction = zeros(size(img));

nImgFeatures = size(predictionFeatures,1);
nContourPixels = 0;
for k = 1:nImgFeatures

    x = imgFeatures(k, 1);
    y = imgFeatures(k, 2);
    if (strcmp(predictionLabels{k}, 'Contour'))
        % point is on contour
        prediction(y,x) = 1.0;
    end
end

imagesc(prediction);