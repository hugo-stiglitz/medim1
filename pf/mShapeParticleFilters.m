% Aufgabe 4

clear all;
%close all;
%clc;

load ('handdata.mat');

% Train
rf = cache(@trainRf, images(1:30), masks(1:30));
[ EVector, b, meanShape, minima, maxima, meanProfile, Sg ] = trainOptimization( aligned, images(1:30), landmarks(1:30) );

% Test Images
for i = 31:50   %change to 50
    img = images{i};
    idealLandmarks = landmarks{i};
    idealLandmarks = idealLandmarks';
    
    prediction = predictContour(rf, img);
    
    costFunction = makeCostFunctionPrediction(EVector, b, meanShape, prediction);
    %costFunction = makeCostFunctionContourDistance(EVector, b, meanShape, contour);
    %costFunction = makeCostFunctionLandmarkProfiles(EVector, b, meanShape, img, meanProfile, Sg);
    %costFunction = makeCostFunctionTest(EVector, b, meanShape, idealLandmarks);

    %drawPopulation = makeDrawPopulation(EVector, b, meanShape, img, costFunction, idealLandmarks);
    drawPopulation = makeDrawResult(EVector, b, meanShape, img, idealLandmarks);
    
    disp(strcat('optimize ',num2str(i)));
    result = optimize(costFunction, minima, maxima);
    drawPopulation(result, 1);
    drawnow;
end