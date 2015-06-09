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
    [wImg, hImg] = size(img);
    
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
        for k = 1:nP+1
            y(:,k) = piStart + (k-1)/(nP+1-1) * (piEnd - piStart);

            if (drawOutput == 1)
                plot(y(1,k), y(2,k), 'r*');
            end
        end

        % get profile values
        for k = 1:nP
            iy1 = int32(y(2,k+1));
            ix1 = int32(y(1,k+1));
            
            iy0 = int32(y(2,k));
            ix0 = int32(y(1,k));
            
            if (ix1>0 && iy1>0 && ix0>0 && iy0>0 && ix1<=wImg && iy1<=hImg && ix0<=wImg && iy0<=hImg)
                g(k) = img(ix1, iy1) - img(ix0, iy0);
            else
                g(k) = 0;
            end
        end

        % normalize profile
        gSum = sum(abs(g));
        if (gSum > 0)
            g = g / gSum;
        end
        
        % save to output matrix
        profiles(:, l) = g;
    end

end

