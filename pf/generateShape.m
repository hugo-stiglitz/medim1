function [ shape ] = generateShape( EVector, b, Mean )
%GENERATESHAPE Generates a shape out of a Eigenvector, a Parametervector b,
%and a MeanShape
%   EVector: Eigenvector
%   b: Parametervector
%   Mesn: Meanshape



shape = EVector' * b + Mean;

end