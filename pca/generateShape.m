function [ shapes ] = generateShape( EVectors, b, Mean )
%GENERATESHAPE Summary of this function goes here
%   Detailed explanation goes here

[nVectors] = size(EVectors, 2);
n = size(b,2);
for i = 1:nVectors
    E = EVectors(:,i);
    
    shapes(:,:,i) = (E*b + Mean*ones(1,n))';
end

end