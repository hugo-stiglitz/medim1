function [ output_args ] = plotShape( shapes )
%PLOTSHAPE Summary of this function goes here
%   Detailed explanation goes here

[nPoints nDimensions nShapes] = size(shapes);

% Plot all shapes

for i = 1:nShapes
    p = plot(shapes(:,1,i), shapes(:,2,i));
    p.Color = 'blue';
    hold on;
end


% Calculate mean shape

meanShape = mean(shapes,3)
p = plot(meanShape(:,1),meanShape(:,2));
p.Color = 'red';
p.LineWidth = 3;

hold off;

end
