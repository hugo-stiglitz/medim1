% Aufgabe 1b

function [C] = ourCov(D)
%ourCov calculates the covarianz of a d x n matrix
%   D ... d x n matrix
%   d ... dimension
%   n ... datapoints
%   in difference to cov.m ourCov.m calculates the mean average of each
%   dimension (line in matrix)!
%   ourCov(D) is equal to cov(D')

[d, n] = size(D);

Dc = D - mean(D,2) * ones(1,n);
C = (1/(n-1)) * (Dc * Dc');

end