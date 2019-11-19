if ~exist("a", "var")
    a = arduino('/dev/cu.usbmodem14101','Mega2560','Libraries',{'I2C', 'SPI', 'Servo','rotaryEncoder'});
    fprintf("arduino created successfully\n")
end

p = "D13";
n = "D12";
c = "D11";

% configurePin(a, p, "DigitalOutput")
% configurePin(a, n, "DigitalOutput")
% configurePin(a, c, "DigitalOutput")
% configurePin(a, c, "PWM")

if ~exist("encoder", "var")
    encoder = rotaryEncoder(a, 'D19', 'D18');
    fprintf("encoder created successfully\n")
end

% fprintf("ready to read encoder\n")

%pos = 0;
pwm = 0;

[count,~] = readCount(encoder);

fprintf("count = %d", count)
fprintf("   |   position = %.0f", pos)

if count < pos
    writeDigitalPin(a, p, 1)
    writeDigitalPin(a, n, 0)
    
    if count > pos - 700
        pwm = (pos - count) / 700;
    else
        pwm = 1;
    end
    
    writePWMDutyCycle(a, c, pwm)
    
elseif count > pos
    writeDigitalPin(a, p, 0)
    writeDigitalPin(a, n, 1)
    
    if count < pos + 700
        pwm = (count - pos) / 700;
    else
        pwm = 1;
    end
    
    writePWMDutyCycle(a, c, pwm)
    
end



