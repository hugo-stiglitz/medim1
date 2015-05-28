function [ features ] = computeFeatures( image )
%computeFeatures computes features of an uint8 image
%       image ... 8 bit int gray value image [0...255]

[height,width] = size(image);

%gradient
[xG,yG] = gradient(double(image));

%haar like
haarLikeGray = computeHaarLike(image);
imageGradient = sqrt(xG.^2 + yG.^2);
haarLikeGradient = computeHaarLike(imageGradient);

features = zeros(height * width, 8);
k = 1;
for i = 1 : height
    for j = 1 : width
        %feature 1: x coordinate
        features(k, 1) = j;
        %feature 2: y coordinate
        features(k, 2) = i;
        %feature 3: gray-value
        features(k, 3) = image(i,j);
        %feature 4: x-gradient
        features(k, 4) = xG(i,j);
        %feature 5: y-gradient
        features(k, 5) = yG(i,j);
        %feature 6: haar like features - gray-value
        features(k, 6:25) = haarLikeGray(1:20, k);
        %feature 7: haar like features - gradient
        features(k, 26:45) = haarLikeGradient(1:20, k);
        
        k = k+1;
    end
end

end