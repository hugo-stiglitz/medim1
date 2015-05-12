clear all;
%close all;
%clc;

load('shapes.mat');

%%
% Aufgabe 5a

[nPoints nDimensions nShapes] = size(aligned);

% calculate mean shape
meanShape = mean(aligned,3);

% create data matrix (256x14) from shapes (128x2x14)
for i = 1:nShapes
    tmp = aligned(:,:,i);
    
    % concatenate x- and y-values of each shape
    D(:,i) = tmp(:);
end

% calculate PCA
[EVal, EVec, m] = pca(D);

nEigenvalues = size(EVal,1);

%%
% Aufgabe 5b

% loop factors for std deviation
for i = -3 : 3
    % create parameter vector
    b = zeros(nEigenvalues, 1);
    
    % set only first value to i*stddeviation
    b(1) = i * sqrt(EVal(1));
    
    s(:,:,i+4) = generateShape(EVec(:,1), b, meanShape);
end

plotShape(s, meanShape);
title('shape model - standard deviations');

%%
% Aufgabe 5c

% calculate total variance from eigen values (std deviation)
totalVariance = sum(abs(EVal));

v = abs(EVal); % variances
bAll = randn(1,nEigenvalues)' .* sqrt(v); % random parameter vector with all values set
vNorm = v ./ totalVariance; % normalized variance vector

varianceSum = 0;
lastVarianceSum = 0; % varianceSum of last
s = [];
% reset parameter vecotr
b = zeros(nEigenvalues, 1);

figure;
title('shape model - 80% / 90% / 95% / 100% variance');

    p.Color = 'blue';
    hold on;

indices = []; % indices when 80%, 90%, 95% and 100% variance is met
for i = 1:nEigenvalues
    
    varianceSum = varianceSum + vNorm(i);
    
    b(i) = bAll(i); % fill up parameter vector
    
    % variance exceeded 80%
    if (varianceSum >= 0.8 && lastVarianceSum < 0.8)
        strcat('80% bei:', num2str(i))
        s(:,:,1) = generateShape(EVec(:,1), b, meanShape);
        plot(s(:,1,1), s(:,2,1));
        indices(1) = i;
    end
    
    % variance exceeded 90%
    if (varianceSum >= 0.9 && lastVarianceSum < 0.9)
        strcat('90% bei:', num2str(i))
        s(:,:,2) = generateShape(EVec(:,1), b, meanShape);
        plot(s(:,1,2), s(:,2,2));
        indices(2) = i;
    end
    
    % variance exceeded 95%
    if (varianceSum >= 0.95 && lastVarianceSum < 0.95)
        strcat('95% bei:', num2str(i))
        s(:,:,3) = generateShape(EVec(:,1), b, meanShape);
        plot(s(:,1,3), s(:,2,3));
        indices(3) = i;
    end
    
    % variance exceeded 100%
    if (varianceSum >= 1 && lastVarianceSum < 1)
        strcat('100% bei:', num2str(i))
        s(:,:,4) = generateShape(EVec(:,1), b, meanShape);
        plot(s(:,1,4), s(:,2,4));
        indices(4) = i;
        break;
    end
    
    lastVarianceSum = varianceSum;
end

p = plot(meanShape(:,1), meanShape(:,2));
p.Color = 'red';
p.LineWidth = 2;
legend('80%', '90%', '95%', '100%', 'Average');
