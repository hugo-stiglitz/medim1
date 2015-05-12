function [ output_args ] = plotShape( shapes, meanShape )
%PLOTSHAPE Plots one or more shapes in a figure
%   shapes: Vector containing the shapes.
%   meanShape: The mean shape. Will be plotted in red.

[nPoints nDimensions nShapes] = size(shapes);

% Plot all shapes in blue
figure;

for i = 1:nShapes
    p = plot(shapes(:,1,i), shapes(:,2,i));
    p.Color = 'blue';
    hold on;
end

% Plot meanShape in red
p = plot(meanShape(:,1),meanShape(:,2));
p.Color = 'red';
p.LineWidth = 2;

hold off;

end

