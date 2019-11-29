function [v] = scanBoard(a, p, v)

v = getPos(a, v);

% Initial scanning point
if v.pos.x  ~= 0 || v.pos.y ~= 2000
    v = goToPos(a, p, v, [0, 2000]);
end

% Calculate scan grid dimensions
grid.x = round(v.gantry.x / v.scanRes);
grid.y = round((13000 - 2000)/ v.scanRes); %% CHANGE BASED ON PHYSICAL DIMS

% Calculate playTone times
time.x = v.gantry.x / (2 * v.scanSpeed);
time.y = v.scanRes * 3 / (2 * v.scanSpeed); % *3 for 3 sensors

% Write y direction for scanning
v.direction.y = 1;
writeDigitalPin(a.a, p.direction.y, v.direction.y)

% Initial y index
y = 1;

% Initialise skip y
skipY = 0;

% Determine y repeats (1/3 of grid) and repeat [1, 0] that many times
% May finish at x = 0 or x = xmax
%dx = repmat([1, 0], 1, round(grid.y / 6)); Old method
dx = ones([1, round(grid.y / 3)]);
dx(2:2:end) = 0;

% Special condition for final run
dx(end) = 2;
dx(end+1) = dx(end - 2);

for dx = dx
    
    frq = v.minFrq;
    
    % Condition where end of scan reached
    if dx == 2
        skipY = 1;
        continue
    end
    
    % Write x direction for scanning
    v.direction.x = dx;
    writeDigitalPin(a.a, p.direction.x, v.direction.x)
    
    % Enable x axis only
    writeDigitalPin(a.a, p.enable.x, 0)
    writeDigitalPin(a.a, p.enable.y, 1)
    
    % Update position
    v = getPos(a, v);
    
    % Determine start and end grid points
    if v.direction.x
        s = 1;      % Start
        e = grid.x; % End
        inc = 1;    % Increment
    else
        s = grid.x; % Start
        e = 1;      % End
        inc = -1;   % Increment
    end
    
    % Move to x = v.gantry.x
    playTone(a.a, p.ramp, v.scanSpeed, time.x)
    
    % While loop for duration of playTone
    for x = s:inc:e
        v = getPos(a, v);
        
        %fprintf("Reading at %.f, %.f\n", v.pos.x, v.pos.y)
        %fprintf("Grid point at %.f, %.f\n\n", x, y)
        v.map(x, y) = readVoltage(a.a, p.sens(1));
        v.map(x, y + 1) = readVoltage(a.a, p.sens(2));
        v.map(x, y + 2) = readVoltage(a.a, p.sens(3));
        
        if v.direction.x
            
            if x * v.scanRes < v.pos.x
                fprintf("SKIPPING SENSOR READINGS +!\n")
            end
            
            while (x - 1) * v.scanRes > v.pos.x
                v = getPos(a, v, "x");
            end
        else
            
            if (x - 2) * v.scanRes > v.pos.x
                fprintf("SKIPPING SENSOR READINGS -!\n")
            end
            
            while (x - 1) * v.scanRes < v.pos.x
                v = getPos(a, v, "x");
            end
        end
        
    end
    
    v = getPos(a, v);
    
    % Enable y axis only
    writeDigitalPin(a.a, p.enable.x, 1)
    writeDigitalPin(a.a, p.enable.y, 0)
    
    % Increment gantry y by required distance
    if ~skipY
        playTone(a.a, p.ramp, v.scanSpeed, time.y)
    end
    
    pause(time.y)
    
    v = getPos(a, v);
    
    % Update y index
    y = y + 3;
    
end

% Raise sensor head
MoveStepper(a.s, 1, 50, 270)