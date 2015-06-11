% Aufgabe 4

clear all;
close all;
clc;

load ('handdata.mat');

% Train
rf = cache(@trainRf, images(1:30), masks(1:30));
[ EVector, b, meanShape, minima, maxima, meanProfile, Sg ] = trainOptimization( aligned, images(1:30), landmarks(1:30) );

% Test Images
for i = 31:50
    idealLandmarks = landmarks{i};
    idealLandmarks = idealLandmarks';
    
    %costFunction = makeCostFunctionContourDistance(EVector, b, meanShape, contour);
    %costFunction = makeCostFunctionLandmarkProfiles(EVector, b, meanShape, img, meanProfile, Sg);
    %costFunction = makeCostFunctionTest(EVector, b, meanShape, idealLandmarks);
    costFunction = makeCostFunctionPrediction(EVector, b, meanShape, contour);

    drawPopulation = makeDrawPopulation(EVector, b, meanShape, images{i}, costFunction, idealLandmarks);
    disp(strcat('optimize ',num2str(i)));
    result = optimize(costFunction, minima, maxima);
    
    % draw result here
end