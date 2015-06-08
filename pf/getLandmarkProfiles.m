function [ profiles ] = getLandmarkProfiles( img, shape, nP, drawOutput )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    if (drawOutput == 1)
        imagesc(img);
        hold on;
        axis equal;

        plot(shape(1,:),shape(2,:));
        scatter(shape(1,:),shape(2,:));
    end

    nLandmarks = size(shape,2);

    for l = 1:nLandmarks

        % calculate normals
        p0 = shape(:,l);
        p1 = shape(:,mod(l-2,nLandmarks)+1);
        p2 = shape(:,mod(l,nLandmarks)+1);

        d1 = p1-p0;
        d2 = p0-p2;

        n1 = [-d1(2); d1(1)];
        n2 = [-d2(2); d2(1)];

        n = n1+n2;
        n = n / sum(abs(n))*10;

        piStart = [p0(1)+n(1) p0(2)+n(2)];
        piEnd = [p0(1)-n(1) p0(2)-n(2)];

        if (drawOutput == 1)
            line([p0(1)+n2(1) p0(1)], [p0(2)+n2(2) p0(2)], 'Color', 'r');
            line([p0(1)+n1(1) p0(1)], [p0(2)+n1(2) p0(2)], 'Color', 'g');
            line([piStart(1) piEnd(1)], [piStart(2) piEnd(2)], 'Color', 'b');
        end

        % get profile points
        g = zeros(nP, 1);
        for k = 1:nP
            y(:,k) = piStart + (k-1)/(nP-1) * (piEnd - piStart);

            if (drawOutput == 1)
                plot(y(1,k), y(2,k), 'r*');
            end
        end

        % get profile values
        for k = 1:nP-1
            g(k) = img(int32(y(2,k+1)), int32(y(1,k+1))) - img(int32(y(2,k)), int32(y(1,k)));
        end

        % normalize profile
        g = g / sum(abs(g));
        
        % save to output matrix
        profiles(:, l) = g;
    end

end

