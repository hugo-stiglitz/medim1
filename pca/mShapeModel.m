% Funktion generateShape, die zu einem Parametervektor b mit einer Länge
% entsprechend der Zahl der Eigenvektoren neue Shapes generieren kann

clear all;
close all;
clc;

load('shapes.mat');

[nPoints nDimensions nShapes] = size(aligned);

EVectors = [];
EValues = [];
Means = [];

nShapes = 1;
for i = 1:nShapes
    D = aligned(:,:,i);
    n = size(D, 1)
    D = D';
    [EVal, EVec, m] = pca(D);
    
    plot2DPCA(D', m, D', EVec', EVal, 1, 1);
    
    EVectors(:,:,i) = EVec;
    EValues(:,:,i) = EVal;
    Means(:,i) = m;
    
    b = EVec(:,1)' * (D - m * ones(1,n));
    
    x = generateShape(EVec, b, m);
    %plotShape(x);
end