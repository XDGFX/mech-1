function [v] = goToPos(a, p, v, position)
% Sends gantry to pos = [x, y] as fast as possible

target.x = position(1);
target.y = position(2);

% Read current position
v = getPos(a, v, p);

% Calculate distance required to travel
dist.x = abs(target.x - v.pos.x);
dist.y = abs(target.y - v.pos.y);

% Determine start positions
start.x = v.pos.x;
start.y = v.pos.y;

% Determine required direction
for d = ["x", "y"]
    if target.(d) > v.pos.(d)
        % Set direction
        v.direction.(d) = 1;
        writeDigitalPin(a.a, p.direction.(d), v.direction.(d))
    else
        % Set direction
        v.direction.(d) = 0;
        writeDigitalPin(a.a, p.direction.(d), v.direction.(d))
    end
end

% Read current position
v = getPos(a, v, p);

% Enable both axes
playTone(a.a, p.ramp, 0, 0.1) % Clear playtone pin
writeDigitalPin(a.a, p.enable.x, 0)
writeDigitalPin(a.a, p.enable.y, 0)

frq = 100;
while abs(v.pos.x - start.x) < dist.x / 2
    v = getPos(a, v, p);
    disp(v.pos.x)
    %disp(frq)
    playTone(a.a, p.ramp, frq, 0.1)
    frq = frq + v.m;
end

while abs(v.pos.x - start.x) < dist.x
    v = getPos(a, v, p);
    distLeft.x = abs(target.x - v.pos.x);
    disp(v.pos.x)
    %disp(frq)
    playTone(a.a, p.ramp, frq, 0.1)
    frq = frq * distLeft.x * 2 / dist.x;
end

% Assign shortest distance variable to 's' and longest to 'l'
if dist.x < dist.y
    s = "x";
    l = "y";
else
    s = "y";
    l = "x";
end

end

