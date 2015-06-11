function f = makeDrawPopulation( EVector, b, Mean, background, costFunction, idealLandmarks )
%MAKEDRAWPOPULATION Summary of this function goes here
%   Detailed explanation goes here

    f = @drawPopulation;
    
    callCounter = 0;

    function h = drawPopulation(population, bestInd)

        figure(111);
        imshow(background);
        
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
        
        % draw ideal shape
        h = plot(idealLandmarks(:,1), idealLandmarks(:,2));
        h.Color = 'r';
        h.LineWidth = 1;
        
        % draw best shape at the end (so it isn't overdeawn)
        h = plot(bestShape(:,1), bestShape(:,2));
        h.Color = 'green';
        h.LineWidth = 2;
        
        % information text
        callCounter = callCounter + 1;
        bestParams = population(:, bestInd);
        description = {
            strcat('best cost: ',num2str(costFunction(bestParams)));
            'params: ';
            strcat(' S: ',num2str(bestParams(1)));
            strcat(' R: ',num2str(bestParams(2)));
            strcat('  = ',num2str(bestParams(2)/pi*180),'°');
            strcat(' X: ',num2str(bestParams(3)));
            strcat(' Y: ',num2str(bestParams(4)))
            ' ';
            strcat('Iteration: ',num2str(callCounter))};
        
        th = text(-50,50,description);
        th.BackgroundColor = 'white';
        
        %figure(222);
        %getLandmarkProfiles(background, bestShape', 8, 1);
    end
end

