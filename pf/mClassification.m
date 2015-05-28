clear all;
close all;
clc;

load ('handdata.mat');

%Aufgabe 3a
rf = train(images(1:30), masks(1:30));

%Aufgabe 3b
oobErrorRf = oobError(rf);
plot(oobErrorRf);
xlabel('Number of grown trees');
ylabel('Out-of-bag classification error');

%Aufgabe 3c
figure();
bar(rf.OOBPermutedVarDeltaError);