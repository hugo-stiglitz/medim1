function f = makeCostFunctionContourDistance(EVector, b, Mean, contour)
%makeCostFunctionContourDistance Makes a cost function that measures
% the distance to the nearest prediction point.

    f = @costFunction;

    % x, y values of contour
    [yContour, xContour] = find(contour > 0);

    function c = costFunction(params)
        % generate shape
        shape = generateShape(EVector, b, Mean, params(1), params(2), params(3), params(4));
        nLandmarks = size(shape, 1);
        
        % assign very high number to minimum, so it is overwritten the
        % first time
        minima = ones(nLandmarks,1)*999999999;
        
        %figure();
        %hold on;
        
        % get nearest contour point of each shape point
        for i = 1 : nLandmarks
            
            xShape = shape(i,1);
            yShape = shape(i,2);
            
            %plot(yShape,xShape,'b+'); hold on;
            
            for j = 1 : size(xContour)
                
                dx = xContour(j) - xShape;
                dy = yContour(j) - yShape;
                
                d = sqrt(dx*dx + dy*dy);
                
                minima(i) = min(d, minima(i));
                
                %if (i==1)
                %    plot(yContour(j),xContour(j),'g*'); hold on;
                %end
            end
            
        end
        
        c = sum(minima);
    end
end