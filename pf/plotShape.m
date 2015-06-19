function [ output_args ] = plotShape( shapes, meanShape )
%PLOTSHAPE Plots one or more shapes in a figure
%   shapes: Vector containing the shapes.
%   meanShape: The mean shape. Will be plotted in red.

[nPoints nDimensions nShapes] = size(shapes);

% Plot all shapes in different colors
figure;

colors = {'blue', 'green', 'yellow', 'magenta', 'cyan'}';
for i = 1:nShapes
    p = plot(shapes(:,1,i), shapes(:,2,i));
    p.Color = colors{mod(i,5)+1};
    p.LineWidth = 1.7;
    hold on;
end

% Plot meanShape in red
p = plot(meanShape(:,1),meanShape(:,2));
p.Color = 'red';
p.LineWidth = 3;

hold off;

end

