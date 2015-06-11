function [ f ] = makeCostFunctionOnContour( EVector, b, Mean, contour )
%MAKECOSTFUNCTIONONCONTOUR Summary of this function goes here
%   Detailed explanation goes here

    f = @costFunction;
    [hImg, wImg] = size(contour);

    function c = costFunction(params)
        % generate shape
        shape = generateShape(EVector, b, Mean, params(1), params(2), params(3), params(4));
        nShapePoints = size(shape, 1);
        
        % check if landmark lies on contour
        c = 0;
        
        for i = 1 : nShapePoints
            
            xShape = round(shape(i,1));
            yShape = round(shape(i,2));
            
            if (xShape > 0 && yShape > 0 && xShape <= wImg && yShape <= hImg)
                
                v = contour(yShape, xShape);
                c = c + (1-v);
                
            else
               % out of bounds -> increase cost
               c = c + 1;
            end
            
        end
    end
end