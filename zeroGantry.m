function [a, v] = zeroGantry(a, p, v)
%% --- ZERO GANTRY ---
% Can be called at any point to put the gantry to (0, 0)
% and start counting position again.

% Enable gantry
playTone(a.a, p.ramp, 0, 0.1) % Clear playtone pin
writeDigitalPin(a.a, p.enable.x, 0)
writeDigitalPin(a.a, p.enable.y, 0)

%% INITIAL ZERO

% Set direction pins
v.direction.x = 0; % -x
v.direction.y = 0; % -y

writeDigitalPin(a.a, p.direction.x, v.direction.x)
writeDigitalPin(a.a, p.direction.y, v.direction.y)

% Initialise zeroing variables
z.x = 1;
z.y = 1;

while z.x || z.y
       
    % Check x axis not reached home
    if ~readDigitalPin(a.a, p.mswitch.x)
        writeDigitalPin(a.a, p.enable.x, 1)
        z.x = 0;
    end
    
    % Check y axis not reached home
    if ~readDigitalPin(a.a, p.mswitch.y)
        writeDigitalPin(a.a, p.enable.y, 1)
        z.y = 0;
    end
    
    % Constant playtone of 490Hz
    playTone(a.a, p.ramp, 490, 1)
    
end

%% SECOND ZERO

% Clear playtone pin and enable gantry
playTone(a.a, p.ramp, 0, 0.1)
writeDigitalPin(a.a, p.enable.x, 0)
writeDigitalPin(a.a, p.enable.y, 0)

% Set direction pins
v.direction.x = 1; % +x
v.direction.y = 1; % +y

writeDigitalPin(a.a, p.direction.x, v.direction.x)
writeDigitalPin(a.a, p.direction.y, v.direction.y)

playTone(a.a, p.ramp, 490, 0.5)
pause(0.5)

% Set direction pins
v.direction.x = 0; % -x
v.direction.y = 0; % -y

writeDigitalPin(a.a, p.direction.x, v.direction.x)
writeDigitalPin(a.a, p.direction.y, v.direction.y)

% Initialise zeroing variables
z.x = 1;
z.y = 1;

while z.x || z.y
       
    % Check x axis not reached home
    if ~readDigitalPin(a.a, p.mswitch.x)
        writeDigitalPin(a.a, p.enable.x, 1)
        z.x = 0;
    end
    
    % Check y axis not reached home
    if ~readDigitalPin(a.a, p.mswitch.y)
        writeDigitalPin(a.a, p.enable.y, 1)
        z.y = 0;
    end
    
    % Constant playtone of 50Hz
    playTone(a.a, p.ramp, 50, 1)
    
end

% Clear playtone pin
playTone(a.a, p.ramp, 0, 0.1)

% Create encoders if they don't already exist
if ~isfield(a, "encoder")
    a.encoder.x = rotaryEncoder(a.a, p.encoder.x1, p.encoder.x2);
    a.encoder.y = rotaryEncoder(a.a, p.encoder.y1, p.encoder.y2);
end

% Zero position (relative to gantry) and count (total steps since zero) variables
v.pos.x = 0;
v.pos.y = 0;

% Only reset count if this is a fresh encoder
if isfield(v, "count")
    [v.count.x, ~] = readCount(a.encoder.x);
    [v.count.y, ~] = readCount(a.encoder.y);
else
    v.count.x = 0;
    v.count.y = 0;
end

end

