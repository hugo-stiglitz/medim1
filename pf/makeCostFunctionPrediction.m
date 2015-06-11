function f = makeCostFunctionPrediction(EVector, b, Mean, prediction)
f = @costFunction;

figure;
imagesc(prediction);

[pHeight, pWidth] = size(prediction);

tmpPrediction(:,:) = prediction(:,:);
for i = 4 : pHeight-3
    for j = 4 : pWidth-3
        if prediction(i,j) == 1
            for m = -3 : 3
                for n = -3 : 3
                   if tmpPrediction(i+m,j+n) < 1
                      tmpPrediction(i+m,j+n) = tmpPrediction(i+m,j+n) + 0.01; 
                   end
                end
            end
            for m = -2 : 2
                for n = -2 : 2
                   if tmpPrediction(i+m,j+n) < 1
                      tmpPrediction(i+m,j+n) = tmpPrediction(i+m,j+n) + 0.02; 
                   end
                end
            end
            for m = -1 : 1
                for n = -1 : 1
                   if tmpPrediction(i+m,j+n) < 1
                      tmpPrediction(i+m,j+n) = tmpPrediction(i+m,j+n) + 0.1; 
                   end
                end
            end
        end
    end
end

prediction = 1./(tmpPrediction+1);
figure;
imagesc(prediction);

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
        c = 1e9 * max(shape(:,1)) - 1e9 * min(min(shape));
    end
end
end