function [ shape ] = generateShape( EVectors, b, Mean )
%GENERATESHAPE Summary of this function goes here
%   Detailed explanation goes here

shape = EVectors' * b + Mean;

end