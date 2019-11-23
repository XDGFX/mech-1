direction = 1;

playTone(a.a, p.ramp, 0, 0.1) % Clear ramp pin

xDims = 0:0.5:10;
frq = smf(xDims,[1 8]);
frq = frq .* v.frq;

frqFlip = flip(frq);


writeDigitalPin(a.a, p.enable.x, 0) % Enable both axes
writeDigitalPin(a.a, p.enable.y, 0) % Enable both axes

while 1
    
    % Set direction
    writeDigitalPin(a.a, p.direction.x, direction)
    writeDigitalPin(a.a, p.direction.y, direction)
    
    % Toggle to ramp
    writeDigitalPin(a.a, p.toggle.x, 0)
    writeDigitalPin(a.a, p.toggle.y, 0)
    
    % Ramp up
    for n = 1:length(frq) % [0:v.stepSize:v.frq]
        playTone(a.a, p.ramp, frq(n), 0.1)
    end
    
    % Switch to max speed
    writeDigitalPin(a.a, p.toggle.x, 1)
    writeDigitalPin(a.a, p.toggle.y, 1)
       
    pause(0.5)
    
    % Start playTone
    playTone(a.a, p.ramp, v.frq, 1)
    
    % Switch to ramp
    writeDigitalPin(a.a, p.toggle.x, 0)
    writeDigitalPin(a.a, p.toggle.y, 0)
    
    % Ramp down
    for n = 1:length(frqFlip) % = negativefrqSCurve %[v.frq:-v.stepSize:0]
        playTone(a.a, p.ramp, frqFlip(n), 0.1)
    end
    
    if direction
        direction = 0;
    else
        direction = 1;
    end
    
end