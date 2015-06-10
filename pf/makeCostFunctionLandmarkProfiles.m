function f = makeCostFunctionLandmarkProfiles(EVector, b, Mean, img, profiles, Sg)
    f = @costFunction;

    % number of Profile Pixels
    nP = size(profiles,1);
    
    function c = costFunction(params)
        % generate shape
        gShape = generateShape(EVector, b, Mean, params(1), params(2), params(3), params(4));
        
        shape(1,:) = gShape(:,2)';
        shape(2,:) = gShape(:,1)';
        
        nLandmarks = size(shape, 1);
        
        p = getLandmarkProfiles(img, shape, nP, 0);
        
        c = 0;
        for l = 1:nLandmarks
            
            profileDiff = (p(:,l) - profiles(:,l));
            d = profileDiff' * inv(Sg) * profileDiff;
            
            c = c + abs(d);
        end
    end
end