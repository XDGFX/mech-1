function [v] = traverse(v)

% v.points | Magnet positions
% v.cuppos | Cup positions

% Swap x and y axes to correct for rotation
v.points(:, [1, 2]) = v.points(:, [2, 1]);

% Plot magnet and cup positions
hold on
scatter(v.points(:,1), v.points(:,2), 'x', 'k', 'LineWidth', 1.5)
scatter(v.cuppos(:,1), v.cuppos(:,2), 1000, 'LineWidth', 1.5)

% Convert current position to start point
pos = [v.pos.x, v.pos.y];

% Loop through all points
for i = 1:length(v.points)
    
    % --- CUPS ---
    % Initial best distance is infinite
    bestDist = inf;
    
    % First look for the nearest cuppo
    for x = 1:size(v.cuppos, 1)
        
        % Calculate distance from current position
        dist = sqrt((v.cuppos(x, 1) - pos(end, 1))^2 + (v.cuppos(x, 2) - pos(end, 2))^2);
        
        % If new distance is better than the previous best, save it
        if dist < bestDist
            bestDist = dist;
            best = x;
        end
    end
    
    pos = [pos; v.cuppos(best, 1), v.cuppos(best, 2)];
    v.cuppos(best,:) = [];
    
    % --- MAGNETS ---
    % Initial best distance is infinite
    bestDist = inf;
    
    % Look for the nearest magnet
    for x = 1:size(v.points, 1)
        
        % Calculate distance from current position
        dist = sqrt((v.points(x, 1) - pos(end, 1))^2 + (v.points(x, 2) - pos(end, 2))^2);
        
        % If new distance is better than the previous best, save it
        if dist < bestDist
            bestDist = dist;
            best = x;
        end
    end
    
    pos = [pos; v.points(best, 1), v.points(best, 2)];
    v.points(best,:) = [];
    
end

plot(pos(:,1), pos(:,2))

v.traverse = pos;

end

