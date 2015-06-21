function f = makeCostFunctionGrowPrediction(EVector, b, Mean, prediction, n)
%makeCostFunctionGrowPrediction Makes a cost function that uses the predicted
% contour and a neighborhood as cost function


f = @costFunction;

[pHeight, pWidth] = size(prediction);

prediction = (1001 ./ (1000 * prediction + 1)) - 1;

x = 1000/n;

for it = 0 : x : 1000
    for i = 2 : pHeight-1
        for j = 2 : pWidth-1
            if prediction(i,j) == it
                for m = -1 : 2 : 1
                    for n = -1 : 1
                        if prediction(i+m,j+n) > it
                            prediction(i+m,j+n) = it + x;
                        end
                    end
                end
            end
        end
    end
end

%figure;
%imagesc(prediction);

    function c = costFunction(params)
        % generate shape
        shape = generateShape(EVector, b, Mean, params(1), params(2), params(3), params(4));
        nShapePoints = size(shape, 1);
        c = 0;
        
        if min(min(shape)) > 1 && max(shape(:,2)) < pHeight && max(shape(:,1)) < pWidth
            for k = 1 : nShapePoints
                xShape = round(shape(k,1));
                yShape = round(shape(k,2));
                
                c = c + prediction(yShape, xShape);
            end
        else
            c = 1e12;
        end
    end

end