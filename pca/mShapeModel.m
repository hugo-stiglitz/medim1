% Funktion generateShape, die zu einem Parametervektor b mit einer Länge
% entsprechend der Zahl der Eigenvektoren neue Shapes generieren kann

clear all;
close all;
clc;

load('shapes.mat');

[nPoints nDimensions nShapes] = size(aligned);

meanShape = mean(aligned,3);

for i = 1:nShapes
    tmp = aligned(:,:,i);
    D(:,i) = tmp(:);
end

[EVal, EVec, m] = pca(D);

nEigenvalues = size(EVal,1);
%%
for i = -3 : 3
    b = zeros(nEigenvalues, 1);
    b(1) = i * sqrt(EVal(1));
    s(:,:,i+4) = generateShape(EVec(:,1), b, meanShape);
end

plotShape(s, meanShape);
%%
sumVariance = sum(EVal);

v = EVal ./ sumVariance
b=randn(1,nEigenvalues)'.*v;
s = generateShape(EVec(:,1), b, meanShape);
plotShape(s, meanShape);

varianceSum = 0;
lastVarianceSum = 0;
for i = 1:nEigenvalues
    
    varianceSum = varianceSum + v(i);
    
    if (varianceSum >= 0.8 && lastVarianceSum < 0.8)
        strcat('80% bei:', num2str(i))
    end
    if (varianceSum >= 0.9 && lastVarianceSum < 0.9)
        strcat('90% bei:', num2str(i))
    end
    if (varianceSum >= 0.95 && lastVarianceSum < 0.95)
        strcat('95% bei:', num2str(i))
    end
    if (varianceSum >= 1 && lastVarianceSum < 1)
        strcat('100% bei:', num2str(i))
    end
    lastVarianceSum = varianceSum;
    
end