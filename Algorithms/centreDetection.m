function [] = centreDetection()

global counts wrong

% Generate sample data; input this instead if you have it
[sensedData, numberMagnets] = generateNoiseImages;

% Use Wiener2 method to remove noise, with 8x8 radius
wiener2Data = wiener2(sensedData', [8 8]);

% Remove all data with a value weaker than 0.4
wiener2Data = wiener2Data .* (wiener2Data > 0.4);

% Create contour plot from this data
% figure(1)
% contour(wiener2Data, 20);

% Output contour shapes into M
[M, ~] = contour(wiener2Data, 20);

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
        try
            xPoints = [xPoints M(1, i)];
            yPoints = [yPoints M(2, i)];
        catch
            a = 1;
        end
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

[eva] = evalclusters(points','kmeans','DaviesBouldin','KList',[1:12]);

nMagnetsDetected = eva.OptimalK;

opts = statset('Display','final');
[idx,C] = kmeans(points', nMagnetsDetected,'Distance','cityblock',...
    'Replicates',5,'Options',opts);

% hold on
% 
% plot(C(:,1),C(:,2),'kx',...
%     'MarkerSize',15,'LineWidth',3)
% 
% title("Actual nMagnets: " + numberMagnets + ". Detected nMagnets: " + nMagnetsDetected)
% 
% hold off

if numberMagnets ~= nMagnetsDetected
    if numberMagnets ~= 1
        wrong = wrong + 1;
        % saveas(1, datestr(now,'HH:MM:SS FFF'), "jpg")
    end
end

counts = counts + 1;

end