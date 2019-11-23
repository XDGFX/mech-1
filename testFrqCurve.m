function [v, travel] = testFrqCurve(a, p, v, dist)

frq = createFrqCurve(v, dist);

v = getPos(a, v, p);

% Enable both axes
playTone(a.a, p.ramp, 0, 0.1) % Clear playtone pin
writeDigitalPin(a.a, p.enable.x, 0)
writeDigitalPin(a.a, p.enable.y, 0)

% Set direction pins
for d = [1, 0]
    
    v.direction.x = d; % +x
    v.direction.y = d; % +y
    
    writeDigitalPin(a.a, p.direction.x, v.direction.x)
    writeDigitalPin(a.a, p.direction.y, v.direction.y)
    
    v = getPos(a, v, p);
    
    for i = 1:length(frq)
        playTone(a.a, p.ramp, frq(i), 0.1)
    end
    
    pause(0.1)
    
    v = getPos(a, v, p);
    
    % Save distance traveled
    if d
        travel.x = v.pos.x;
        travel.y = v.pos.y;
    end
    
end