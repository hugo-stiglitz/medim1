function [ features ] = computeFeatures( image )
%computeFeatures computes features of an uint8 image
%       image ... 8 bit int gray value image [0...255]

[height,width] = size(image);

%gradient
[xG,yG] = gradient(double(image));

%haar like
haarLikeGray = computeHaarLike(image');
imageGradientAbs = sqrt(xG.^2 + yG.^2);
haarLikeGradientAbs = computeHaarLike(imageGradientAbs');
haarLikeGradientX = computeHaarLike(xG');
haarLikeGradientY = computeHaarLike(yG');

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
        %feature 4: gradient value
        features(k, 4) = imageGradientAbs(i,j);
        %feature 5: x-gradient
        features(k, 5) = xG(i,j);
        %feature 6: y-gradient
        features(k, 6) = yG(i,j);
        %feature 6: haar like features - gray-value
        features(k, 7:26) = haarLikeGray(1:20, k);
        %feature 7: haar like features - gradientAbs
        features(k, 27:46) = haarLikeGradientAbs(1:20, k);
        %feature 8: haar like features - gradient x
        features(k, 47:66) = haarLikeGradientX(1:20, k);
        %feature 8: haar like features - gradient y
        features(k, 67:86) = haarLikeGradientY(1:20, k);        
        
        k = k+1;
    end
end

end