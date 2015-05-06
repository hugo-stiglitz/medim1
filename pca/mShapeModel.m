% Funktion generateShape, die zu einem Parametervektor b mit einer Länge
% entsprechend der Zahl der Eigenvektoren neue Shapes generieren kann

[nPoints nDimensions nShapes] = size(aligned);

EVectors = [];
EValues = [];
Means = [];

for i = 1:nShapes
    D = aligned(:,:,i);
    [EVal, EVec, m] = pca(D);
    
    EVectors(:,:,i) = EVec;
    EValues(:,:,i) = EVal;
    Means(:,:,i) = m;
end