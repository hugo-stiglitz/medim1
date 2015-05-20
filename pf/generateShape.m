function [ shape ] = generateShape( EVector, b, Mean, scaling, rotation, xTranslation, yTranslation )
%GENERATESHAPE Generates a shape out of a Eigenvector, a Parametervector b,
%and a MeanShape
%   EVector: Eigenvector
%   b: Parametervector
%   Mean: Meanshape

shape = EVector' * b + Mean;

shape = shape .* scaling;
shape = shape * [cos(rotation) -sin(rotation); sin(rotation) cos(rotation)];
translation = zeros(size(shape));
translation(:,1) = xTranslation;
translation(:,2) = yTranslation;
shape = shape + translation;


end