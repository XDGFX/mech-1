function [orderedPoints] = nearestNeighbor(v, points)
% Nearest neighbour algorithm

% Plot point positions
hold on
scatter(points(:,1), points(:,2))

% Convert current position to start point
pos = [v.pos.x, v.pos.y];

% Loop through all points and cups
for i = 1:length(points) * 2
    
    bestDist = inf;
    
    for x = 1:n
        dist = sqrt((points(x, 1) - pos(end, 1))^2 + (points(x, 2) - pos(end, 2))^2);
        
        if dist < bestDist
            bestDist = dist;
            best = x;
        end
        
    end
    
    pos = [pos; points(best, 1), points(best, 2)];
    points(best,:) = [];
    n = n - 1;
    
end

pos = [pos; 0, 0];

fprintf("Time taken = %.5fs\n", toc)

plot(pos(:,1), pos(:,2))

