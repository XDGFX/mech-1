setup

[count,~] = readCount(encoder);

% error if encoder count not 0
if count ~= 0
    error()
end


% Toggle to PWM pin
writeDigitalPin(a, toggle, 1)

writePWMDutyCycle(a, pwmPin, 0.5)

while readDigitalPin(a, mswitch(2))
    % do nothing
end

writePWMDutyCycle(a, pwmPin, 0)

[count,~] = readCount(encoder)
