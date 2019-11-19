% Clear encoder if already exist
clear count encoder

% Toggle switch to PWM pin
writeDigitalPin(a, toggle, 1)

% Set direction for direction pins
writeDigitalPin(a, direction(1), 0)
writeDigitalPin(a, direction(2), 0)

% Start gantry movement
writePWMDutyCycle(a, pwmPin, 0.5)

% Do nothing until end switch is triggered
while readDigitalPin(a, mswitch(2))
    % do nothing
end

% Turn off gantry
writePWMDutyCycle(a, pwmPin, 0)

setupEncoder

pos = 0;

count = 0;

