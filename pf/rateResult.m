function [ distanceSum, distanceAvg, distanceMean ] = rateResult( EVector, b, meanShape, params, idealLandmarks )
%RATERESULT Summary of this function goes here
%   Detailed explanation goes here

    shape = generateShape(EVector, b, meanShape, params(1), params(2), params(3), params(4));
    
    distances = sqrt((shape(:,1)-idealLandmarks(:,1)).^2 + (shape(:,2)-idealLandmarks(:,2)).^2);
    
    distanceSum = sum(distances);
    distanceAvg = distanceSum / size(meanShape, 1);
    distanceMean = median(distances);
    
    disp(strcat('Sum Distance: ', num2str(distanceSum)));
    disp(strcat('Avg Distance: ', num2str(distanceAvg)));
    disp(strcat('Median Distance: ', num2str(distanceMean)));
end

