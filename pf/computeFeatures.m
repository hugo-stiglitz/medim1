function [ features ] = computeFeatures( image )
%computeFeatures computes features of an uint8 image
%       image ... 8 bit int gray value image [0...255]

[width,height] = size(image);

%gradient
grid = meshgrid(1:width, 1:height);
[xG,yG] = gradient(grid);

%haar like
haarLikeGray = computeHaarLike(image);
%haarLikeGradient = TODO

features = zeros(width * height, 8);
k = 1;
for i = 1 : width
    for j = 1 : height
        %feature 1: x coordinate
        features(k, 1) = i;
        %feature 2: y coordinate
        features(k, 2) = j;
        %feature 3: gray-value
        features(k, 3) = image(i, j);
        %feature 4: x-gradient
        features(k, 4) = xG(j,i);
        %feature 5: y-gradient
        features(k, 5) = yG(j,i);
        %feature 6: haar like features - gray-value
        features(k, 6) = haarLikeGray(k);   % TODO
        %feature 7: haar like features - gradient
        % TODO
        
        
        k = k+1;
    end
end

end