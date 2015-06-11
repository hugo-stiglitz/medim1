function f = makeCostFunctionLandmarkProfiles(EVector, b, Mean, img, profiles, Sg)
    f = @costFunction;

    % number of Profile Pixels
    nP = size(profiles,1);
    
    invSg = inv(Sg);
    
    function c = costFunction(params)
        % generate shape
        shape = generateShape(EVector, b, Mean, params(1), params(2), params(3), params(4));
        
        nLandmarks = size(shape, 1);
        
        p = getLandmarkProfiles(img, shape, nP, 0);
        
        c = 0;
        for l = 1:nLandmarks
            
            profileDiff = (p(:,l) - profiles(:,l));
            d = profileDiff' * invSg * profileDiff;
            
            c = c + abs(d);
        end
    end
end