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

 % preict contour for image
img = images{31};
prediction = predictContour(rf, img);
imagesc(prediction);