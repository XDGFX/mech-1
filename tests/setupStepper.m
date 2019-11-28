%if ~exist("a", "var")
%    a = arduino('/dev/cu.usbmodem14101','Mega2560','Libraries',{'I2C', 'SPI', 'Servo','rotaryEncoder'});
%    fprintf("arduino created successfully\n")
%end

% Motor 1 pins
out(1) = "D8";
out(2) = "D9";
control(1) = "D11";

% Motor 2 pins
out(3) = "D12";
out(4) = "D13";
control(2) = "D10";

% Set control pins active
configurePin(a.a, control(1), "DigitalOutput")
configurePin(a.a, control(2), "DigitalOutput")
writeDigitalPin(a.a, control(1), 1)
writeDigitalPin(a.a, control(2), 1)

for x = 1:4
    writeDigitalPin(a.a, out(x), 0)
end

seq = [1, 0, 1, 0; ...
    0, 1, 1, 0; ...
    0, 1, 0, 1; ...
    1, 0, 0, 1];

for x = 1:4
    configurePin(a.a, out(x), "DigitalOutput")
end

while 1
    for x = 4:-1:1
        for y = 1:4
            writeDigitalPin(a.a, out(y), seq(x, y))
        end
        %pause(0.1)
    end
end