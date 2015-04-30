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
[EVec, tmp] = eig(C);
EVal = eig(C);

%sort eigen-values and -vectors descendendig according to eigen-value
[EVal, ind] = sort(EVal,'descend');
for i=1 : size(EVal,1)
   EVec(:,i) = EVec(ind(:,1),i); 
end

%plot2DPCA(D, m, D, EVec, EVal, 1, 1)

%TODO?

%???
%landmarks = D(:);

end

