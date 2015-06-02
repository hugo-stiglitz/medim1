function [ features ] = computeFeatures( image )
%computeFeatures computes features of an uint8 image
%       image ... 8 bit int gray value image [0...255]

[height,width] = size(image);

%gradient
[xG,yG] = gradient(double(image));

%haar like
haarLikeGray = computeHaarLike(image);
imageGradientAbs = sqrt(xG.^2 + yG.^2);
haarLikeGradientAbs = computeHaarLike(imageGradientAbs);
haarLikeGradientX = computeHaarLike(xG);
haarLikeGradientY = computeHaarLike(yG);

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
        %feature 7: haar like features - gradientAbs
        features(k, 26:45) = haarLikeGradientAbs(1:20, k);
        %feature 8: haar like features - gradient x
        features(k, 46:65) = haarLikeGradientX(1:20, k);
        %feature 8: haar like features - gradient y
        features(k, 66:85) = haarLikeGradientY(1:20, k);
        
        %playground
        vl = 0; vr = 0; vt = 0; vb = 0; vlt = 0; vlb = 0; vrt = 0; vrb = 0;
        if i > 1 && i < height && j > 1 && j < width
            vl = image(i,j-1);
            vr = image(i,j+1);
            vt = image(i+1,j);
            vb = image(i-1,j);
            
            vlt = image(i+1,j-1);
            vlb = image(i-1,j-1);
            vrt = image(i+1,j+1);
            vrb = image(i-1,j+1);
        end
        
        features(k, 86) = vt + vb + vl + vlt + vlb + image(i,j) + vr + vrt + vrb;
        features(k, 87) = vl + image(i,j) + vr;
        features(k, 88) = vt + image(i,j) + vb;
        
        k = k+1;
    end
end

end