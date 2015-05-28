clear all;
close all;
clc;

load ('handdata.mat');

%load fisheriris

i1 = images{1,1};
p1 = [aligned(:,1,1) , aligned(:,2,1)];

imagesc(i1);
axis equal;
hold on;
scatter(p1(:,1)+(143/2), p1(:,2)+(306/2));
%plot([0 100],[0 100]);