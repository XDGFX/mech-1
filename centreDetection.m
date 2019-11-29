function [v] = centreDetection(v)

% Normalise sensor input
v.map = v.map - 2.5;
v.map = abs(v.map);

% Apply S curve filter with foot, shoulder = 0, 0.3
v.map = smf(v.map, [0, 0.3]);

% Use Wiener2 method to remove noise, with 2x2 radius
v.map = wiener2(v.map, [2 2]);

% Remove all data with a value weaker than 0.4
% v.map = v.map .* (v.map > 0.4); NOT NEEDED

% Create contour plot from this data
figure(1)
contour(v.map, 20);

% Output contour shapes into M
[M, ~] = contour(v.map, 20);

% Initial variables
i = 1;
n = 1;
xPoints = [];
yPoints = [];
loop = 1;

% Loop through all points in M, taking the number of vertices and then
% averaging the next nVert values. THe value after this will again be a
% reference value.
while loop
    
    % Intensity is the strength of the signal
    intensity(n) = M(1, i);
    
    % Number of vertices to follow this, to create one shape
    nVert = M(2, i);
    
    % Step from reference to first vert value
    i = i + 1;
    
    % Loop through all vertices for this shape
    for i = i:i + nVert - 1
        xPoints = [xPoints M(1, i)];
        yPoints = [yPoints M(2, i)];
    end
    
    % Average all vertices in x and y direction
    points(1, n) = mean(xPoints);
    points(2, n) = mean(yPoints);
    
    % Clear the points variables, ready for next time
    xPoints = [];
    yPoints = [];
    
    % Make sure loop breaks if end of M is reached
    if i == size(M, 2)
        loop = 0;
    end
    
    % Increment by 1 to get next reference
    n = n + 1;
    i = i + 1;
end

% Initialise weight variable
pointsWeight = [];

% Normalise intensity to have [min max] of [0 1]
intensity = intensity - min(intensity);
intensity = intensity / max(intensity);

% Loop through points, and repeat them in a new pointsWeight variable based
% on how high the intensity is (i.e. high intensity points will be repeated
% multiple times, low intensity may be repeated only a couple)
for i = 1:length(intensity)
    
    repeats = round(100 * intensity(i));
    
    for n = 1:repeats
        pointsWeight = [pointsWeight points(:, i)];
    end
end

% Evaluate how many magnets there are using k-means clustering
[eva] = evalclusters(points','kmeans','DaviesBouldin','KList',1:12);

% Assign number of magnets (clusters) detected
nMagnetsDetected = eva.OptimalK;

% Configure options
opts = statset('Display','final');

% Output centre points to variable 'points'
[~, v.points] = kmeans(points', nMagnetsDetected, 'Distance', 'cityblock', ...
    'Replicates', 5, 'Options', opts);

hold on

plot(v.points(:,1),v.points(:,2),'kx',...
    'MarkerSize',15,'LineWidth',3)
%
% title("Actual nMagnets: " + numberMagnets + ". Detected nMagnets: " + nMagnetsDetected)
%
hold off

% Convert to gantry coordinates
v.points = v.points .* v.scanRes;

% Add start position offset
v.points(:, 1) = v.points(:, 1) + 1900;

% Add calculated offset
v.points(:, 2) = v.points(:, 2) - 0;

end