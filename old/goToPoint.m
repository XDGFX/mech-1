function [] = goToPoint(x, y)

global a encoder direction enable mswitch pwmPin rampPin rampSteps stepSize toggle tPause frq dirn pos count

readEncoder

% special case if already there

% set direction
if pos - x < 0
    writeDigitalPin(a, direction(2), 1)
    dirn = 1;
    readEncoder
else
    writeDigitalPin(a, direction(2), 0)
    dirn = 0;
    readEncoder
end

if abs(pos - x) < rampSteps
    writeDigitalPin(a, toggle, 1)
    writePWMDutyCycle(a, pwmPin, 0.5)
else
    autoSpeedRamp
end


running = 1;
 
while running
    
    readEncoder
    
    if dirn
        if pos > x
            running = 0;
        end
    else
        if pos < x
            running = 0;
        end
    end

end

writePWMDutyCycle(a, pwmPin, 0)

x
pos