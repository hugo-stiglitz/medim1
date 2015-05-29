function f = makeCostFunction(shape, contour)
    f = @costFunction;
    function c = costFunction(params)
        
        nShapePoints = size(shape, 1);
        
        % x, y values of contour
        [yContour,xContour] = find(contour > 0);
        
        % TODO: transform shapes by params
        %costSurface(round(params(2)),round(params(1)))
        
        minimums = zeros(nShapePoints);
        % get nearest contour point of each shape point
        for i = 1 : nShapePoints
            
            xShape = shape(i,2);
            yShape = shape(i,1);
            
            for j = 1 : size(xContour)
                
                dx = xContour(j) - xShape;
                dy = yContour(j) - yShape;
                
                d = sqrt(dx*dx + dy*dy);
                
                minimums(i) = min(d, minimums(i))
            end
            
        end
        
        c = sum(minimums);
    end
end