function f = makeDrawPopulation( EVector, b, Mean, contour )
%MAKEDRAWPOPULATION Summary of this function goes here
%   Detailed explanation goes here

    f = @drawPopulation;

    function h = drawPopulation(population, bestInd)
        % h(1) = plot(population(1,:),population(2,:),'wx'); hold on
        % h(2) = plot(population(1,:),population(2,:),'b+'); hold on      
        
        imagesc(contour);
        
        for i = 1 : size(population,2)
            % generate shape
            params = population(:, i);
            shape = generateShape(EVector, b, Mean, params(1), params(2), params(3), params(4));

            hold on;
            
            if (i == bestInd)
                bestShape = shape;
            else 
                h = plot(shape(:,1), shape(:,2));
                h.Color = 'blue';
                h.LineStyle = '--';
            end
        end
        
        % draw best shape at the end (so it isn't overdeawn)
        h = plot(bestShape(:,1), bestShape(:,2));
        h.Color = 'green';
        h.LineWidth = 2;
    end
end

