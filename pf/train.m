function [ rf ] = train( images, masks )
%TRAIN Summary of this function goes here
%   Detailed explanation goes here

%numberOfTrees = 32;
% numberOfTrees = 10;
% 
% for i = 1 : 1   %30
%     features = cache(@computeFeatures, images{i});
%     mask = masks{i};
%     labels = mask(:);
%     rf = TreeBagger(numberOfTrees, features, labels', 'OOBVarImp', 'on');
%     
%     if i == 1
%         %Aufgabe 3b
%         oobErrorRf1 = oobError(rf);
%         plot(oobErrorRf1);
%         xlabel('Number of grown trees');
%         ylabel('Out-of-bag classification error');
%     end
% end


    nTrainingImages = 1; %size(masks, 2);
    
    features = []; % all features
    labels = []; % all labels
    nFeatures = 0; % number of features
    
    % iterate images
    for i = 1 : nTrainingImages
        mask = masks{i};
        
        % get feature for images
        imgFeatures = cache(@computeFeatures, images{i});
        
        nImgFeatures = size(imgFeatures,1);
        nContourPixels = 0;
        for k = 1:nImgFeatures
            
            x = imgFeatures(k, 1);
            y = imgFeatures(k, 2);
            if (mask(y,x) > 0)
                % point is on contour
                
                nContourPixels = nContourPixels + 1;
                
                % add feature
                nFeatures = nFeatures + 1;
                features(nFeatures, :) = imgFeatures(k, :);
                labels{nFeatures} = 'Contour';
            end
        end
        
        % add features not on contur
        i = nContourPixels;
        while i > 0
            k = int32(rand() * (nImgFeatures - 1)) + 1;
            x = imgFeatures(k, 1);
            y = imgFeatures(k, 2);
            if (mask(y,x) == 0)
                % not on contour
                
                nFeatures = nFeatures + 1;
                features(nFeatures, :) = imgFeatures(k, :);
                labels{nFeatures} = 'Background';
                i = i - 1;
            end
        end
    end

    rf = TreeBagger(32, features, labels', 'OOBVarImp', 'on');
    
    %Aufgabe 3b
    oobErrorRf1 = oobError(rf);
    plot(oobErrorRf1);
    xlabel('Number of grown trees');
    ylabel('Out-of-bag classification error');
    
    %Aufgabe 3c
    figure();
    plot(rf.OOBPermutedVarDeltaError, '*');
    figure();
    bar(rf.OOBPermutedVarDeltaError);
end

