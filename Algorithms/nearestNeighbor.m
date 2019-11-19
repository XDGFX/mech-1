%% Nearest Neighbour
sx = 10; sy = 10; n = 100;

points = [];

for x = 1:n
    points = [points; rand(1) * sx, rand(1) * sy];
end

hold on
scatter(points(:,1), points(:,2))

pos = [0, 0];


tic
for i = 1:length(points)
    
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

