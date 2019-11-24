function [v] = scanBoard(a, p, v)

v = getPos(a, v);

if v.pos.x  ~= 0 || v.pos.y ~= 0
    [a, v] = zeroGantry(a, p, v);
end

% Calculate scan grid dimensions
grid.x = round(v.gantry.x / v.scanRes);
grid.y = round(v.gantry.y / v.scanRes); %% CHANGE BASED ON PHYSICAL DIMS

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
dx = repmat([1, 0], 1, round(grid.y / 6));

% Special condition for final run
dx(end) = 2;

for dx = dx
    
    if dx == 2
        dx = 0;
        skipY = 1;
    end
    
    % Write x direction for scanning
    v.direction.x = dx;
    writeDigitalPin(a.a, p.direction.x, v.direction.x)
    
    % Enable x axis only
    writeDigitalPin(a.a, p.enable.x, 0)
    writeDigitalPin(a.a, p.enable.y, 1)
    
    % Update position
    v = getPos(a, v);
    
    % Move to x = v.gantry.x
    playTone(a.a, p.ramp, v.scanSpeed, time.x)
    
    if v.direction.x
        s = 1;
        e = grid.x;
        inc = 1;
    else
        s = grid.x;
        e = 1;
        inc = -1;
    end
    
    % While loop for duration of playTone
    for x = s:inc:e
        v = getPos(a, v);
        
        %fprintf("Reading at %.f, %.f\n", v.pos.x, v.pos.y)
        %fprintf("Grid point at %.f, %.f\n\n", x, y)
        v.map(x, y) = readVoltage(a.a, p.sens(1));
        v.map(x, y + 1) = readVoltage(a.a, p.sens(2));
        v.map(x, y + 2) = readVoltage(a.a, p.sens(3));
        
        if v.direction.x
            while (x - 1) * v.scanRes > v.pos.x
                v = getPos(a, v, "x");
            end
        else
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