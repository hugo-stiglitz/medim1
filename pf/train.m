function [ rf ] = train( images, masks )
%TRAIN Summary of this function goes here
%   Detailed explanation goes here

%numberOfTrees = 32;
numberOfTrees = 10;

for i = 1 : 1   %30
    features = cache(@computeFeatures, images{i});
    mask = masks{i};
    labels = mask(:);
    rf = TreeBagger(numberOfTrees, features, labels', 'OOBVarImp', 'on');
    
    if i == 1
        %Aufgabe 3b
        oobErrorRf1 = oobError(rf);
        plot(oobErrorRf1);
        xlabel('Number of grown trees');
        ylabel('Out-of-bag classification error');
    end
end

end

