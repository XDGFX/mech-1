function [v, travel] = testFrqCurve(a, p, v, target)

% Zero gantry
[a, v] = zeroGantry(a, p, v);

frq = createFrqCurve(v, target);

v = getPos(a, v, p);

startPos = v.pos.x;

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
    
    frq = 100;
    while v.pos.x - startPos < abs(target - startPos) / 2
        v = getPos(a, v, p);
        %disp(v.pos.x)
        %disp(frq)
        playTone(a.a, p.ramp, frq, 0.1)
        frq = frq + v.m;
    end
    
    peakFrq = frq;
    
    while v.pos.x < target
        v = getPos(a, v, p);
        %disp(v.pos.x)
        %disp(frq)
        playTone(a.a, p.ramp, frq, 0.1)
        frq = peakFrq * (target - v.pos.x)/(target/2);
    end
    
    pause (0.1)
    v = getPos(a, v, p);
    
    % Save distance traveled
    if d
        
        target = 0;
        
        travel.x = v.pos.x;
        travel.y = v.pos.y;
    end
    
end