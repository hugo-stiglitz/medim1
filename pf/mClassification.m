clear all;
close all;
clc;

load ('handdata.mat');

%Aufgabe 3a
rf = cache(@train, images(1:30), masks(1:30));

%Aufgabe 3b
oobErrorRf = oobError(rf);
plot(oobErrorRf);
xlabel('Number of grown trees');
ylabel('Out-of-bag classification error');

%Aufgabe 3c
figure();
b = bar(rf.OOBPermutedVarDeltaError);

set(gca,'Xtick',1:5,'XTickLabel',{'x'; 'y'; 'V'; 'xG'; 'yG'});