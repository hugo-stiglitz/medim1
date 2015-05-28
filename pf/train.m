function [ rf ] = train( images, masks )
%TRAIN Summary of this function goes here
%   Detailed explanation goes here

    rf = TreeBagger(32, features', labels', 'OOBVarImp', 'on');
end

