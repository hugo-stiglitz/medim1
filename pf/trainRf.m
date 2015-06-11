function [ rf ] = trainRf( images, masks )
%TRAIN Summary of this function goes here
%   Detailed explanation goes here

    disp('train...');

    nTrainingImages = size(images, 2);
    
    features = []; % all features
    labels = []; % all labels
    nFeatures = 0; % number of features
    
    % calculate number of final features
    % and initialize size of features matrix to speed up feature assignment
    nFeaturesFinal = 0;
    for i = 1 : nTrainingImages
        nFeaturesFinal = nFeaturesFinal + nnz(masks{i}); % nnz: Count non zero values
    end
    nFeaturesFinal = nFeaturesFinal * 2; % *2 beacuase the same amount of negative information is added
    features = zeros(nFeaturesFinal,86);
    labels = cell(nFeaturesFinal,1);
    
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
            % find random feature
            k = int32(rand() * (nImgFeatures - 1)) + 1;
            x = imgFeatures(k, 1);
            y = imgFeatures(k, 2);
            
            %only if not on contour
            if (mask(y,x) == 0)
                % not on contour
                
                nFeatures = nFeatures + 1;
                features(nFeatures, :) = imgFeatures(k, :);
                labels{nFeatures} = 'Background';
                i = i - 1;
            end
        end
    end

    disp('create random forrest...');
    tic
    rf = TreeBagger(32, features, labels', 'OOBVarImp', 'on');
    disp(['elapsed time is ' num2str(toc) ' seconds']);
end

