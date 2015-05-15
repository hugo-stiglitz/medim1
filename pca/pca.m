% Aufgabe 2

function [ EVal, EVecSort, m ] = pca( D )
%pca calculates eigen-vectors and eigen-values of a data set
%   D ... d x n matrix
%   d ... dimension
%   n ... datapoints
%   calculates the variance-matrix of the input data D and returns a list
%   of eigen-values (sorted descending) and eigen-vectors sorted according
%   to the eigen-value
%   EVal ... sorted eigen-values
%   EVecSort ... sorted eigen-vectors
%   m ... mean

[d, n] = size(D);
m = mean(D,2);

%center the bone (remove offset)
D0 = D - m*ones(1,n);

%compute empirical covariance matrix
C = ourCov(D0);              %covariance: C(1,2) = C(2,1) {if d=2}

%compute eigenvalue
[EVec, tmp] = eig(C);
EVal = eig(C);

%sort eigen-values and -vectors descendendig according to eigen-value
[EVal, ind] = sort(EVal,'descend');
for i=1 : size(EVal,1)
   EVecSort(:,i) = EVec(:,ind(i)); 
end

end
