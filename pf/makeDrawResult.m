function f = makeDrawResult( EVector, b, Mean, background, idealLandmarks )
    f = @drawPopulation;

    function h = drawPopulation(population, tmp)
        
        imshow(background);
        for i = 1 : size(population,2)
            % generate shape
            params = population(:, i);
            shape = generateShape(EVector, b, Mean, params(1), params(2), params(3), params(4));
        end
        
        % draw ideal shape
        h = plot(idealLandmarks(:,1), idealLandmarks(:,2));
        h.Color = 'r';
        h.LineWidth = 1;
        
        % draw shape
        h = plot(shape(:,1), shape(:,2));
        h.Color = 'green';
        h.LineWidth = 2;
        
    end
end