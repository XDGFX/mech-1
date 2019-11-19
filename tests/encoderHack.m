for x = 1:6
clear encoder
encoder = rotaryEncoder(a, 'D19', 'D18');
[count(x),~] = readCount(encoder);
writePWMDutyCycle(a, "D13", 0.5)
pause(10)
writePWMDutyCycle(a, "D13", 0)
[count(x),~] = readCount(encoder);
end