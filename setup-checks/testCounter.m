% Enable x and y
writeDigitalPin(a.a, p.enable.x, 0)
writeDigitalPin(a.a, p.enable.y, 0)

time = 1;

for frq = [100, 200, 300, 400, 500]
for dir = [1, 0]
    
    if dir
        sign = "";
    else
        sign = "-";
    end

% Set direction to positive both axes
v.direction.x = dir;
v.direction.y = dir;

writeDigitalPin(a.a, p.direction.x, v.direction.x)
writeDigitalPin(a.a, p.direction.y, v.direction.y)

% Read position
v.old = getPos(a, v, p);

% 2* frq * time = number of steps expected
playTone(a.a, p.ramp, frq, time)

pause(1)

% Read new position
v = getPos(a, v, p);

% Test x
fprintf("Expected x steps: %s%.f\n", sign, 2 * frq * time)
fprintf("Actual steps: %.f\n\n", v.pos.x - v.old.pos.x)

% Test y
fprintf("Expected y steps: %s%.f\n", sign, 2 * frq * time)
fprintf("Actual steps: %.f\n\n", v.pos.y - v.old.pos.y)

end
end

clear v.old frq time sign dir