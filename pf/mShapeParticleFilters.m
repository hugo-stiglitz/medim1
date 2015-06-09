% Aufgabe 4

%clear all;
close all;
clc;

load ('handdata.mat');

%Aufgabe 4a
rf = cache(@train, images(1:30), masks(1:30));

 % predict contour for image
 disp('predict contour...');
img = images{31};
contour = predictContour(rf, img);
imagesc(contour);

% optimize

% PCA
disp('pca...');
[nPoints nDimensions nShapes] = size(aligned);

% calculate mean shape
meanShape = mean(aligned,3);

% create landmarks from shapes
for i = 1:nShapes
    tmp = aligned(:,:,i);
    D(:,i) = tmp(:);
end

% calculate PCA
[EVal, EVec, m] = pca(D);

% create parameter vector
b = zeros(size(EVal,1), 1);
b(1) = 2 * sqrt(EVal(1));

EVector = EVec(:,1);

% train ASM
    nLandmarks = size(landmarks{1},2);
    nImgs = 30;

    % get landmark profiles from training set
    for i = 1:nImgs
       img = images{i};
       shape = landmarks{i};

       p = getLandmarkProfiles(img, shape, 8, i==1);

       profiles(:,:,i) = p;
    end

    % calc meanProfile
    for l = 1:nLandmarks
        p = zeros(size(profiles,1),1);
        for i = 1:nImgs
            p = p + profiles(:,l,i);
        end
        meanProfile(:,l) = p / nImgs;
    end

    % covariance of mean profile
    Sg = ourCov(meanProfile);


disp('prepare optimize...');
minimums = [ 0.5; 0; 0; 0 ];
maximums = [ 2; 2*pi; size(img,1); size(img,2) ];

img = images{31};
contour = masks{31}; % TODO: remove and use prediction istead

%Good guessdrawPopulation([1;-0.05;160;73],1)

%costFunction = makeCostFunctionContourDistance(EVector, b, meanShape, contour);
costFunction = makeCostFunctionLandmarkProfiles(EVector, b, meanShape, img, meanProfile, Sg);

background = img;
contour = double(contour)*15;
drawPopulation = makeDrawPopulation(EVector, b, meanShape, background, contour);

figure;
imagesc(background);
%tmp = generateShape(EVector,b,meanShape,1,0,150,70);
%plot(tmp(:,1), tmp(:,2));
disp('optimize...');
optimize(costFunction,minimums,maximums,drawPopulation);
