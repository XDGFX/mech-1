function [] = autoSpeedRamp()

global a encoder direction enable mswitch pwmPin rampPin rampSteps stepSize toggle tPause frq

% Set toggle to ramp pin
writeDigitalPin(a, toggle, 0)

% Ramp up
for x = 100:stepSize:frq
    playTone(a, rampPin, x, tPause)
    pause(tPause * 0.9)
end

% Set PWM pin active
writePWMDutyCycle(a, pwmPin, 0.5)

% Set toggle to PWM pin
writeDigitalPin(a, toggle, 1)