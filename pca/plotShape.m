function [ output_args ] = plotShape( shapes, meanShape, original )
%PLOTSHAPE Summary of this function goes here
%   Detailed explanation goes here

[nPoints nDimensions nShapes] = size(shapes);

% Plot all shapes

figure;

for i = 1:nShapes
    p = plot(shapes(:,1,i), shapes(:,2,i));
    p.Color = 'blue';
    hold on;
end


% Calculate mean shape

%meanShape = mean(shapes,3)
p = plot(meanShape(:,1),meanShape(:,2));
p.Color = 'red';
p.LineWidth = 3;

if (nargin > 2)
    p = plot(original(:,1),original(:,2));
    p.Color = 'green';
    %p.LineWidth = 3;
end

hold off;

end

