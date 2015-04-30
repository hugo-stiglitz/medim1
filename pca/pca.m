function [ EVal, EVec ] = pca( D )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[d, n] = size(D);
m = mean(D,2);

%center the bone (remove offset)
D = D - m*ones(1,n);

%compute empirical covariance matrix
C = ourCov(D);              %covariance: C(1,2) = C(2,1) {if d=2}

%compute eigenvalue
[EVec, EVal] = eig(C);      %l1: EVal(1,1) / l2: EVal(2,2)

EVec
EVal

%TODO?


landmarks = D(:);

% TODO




end

