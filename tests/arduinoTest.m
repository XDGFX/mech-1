p = "D13";
n = "D12";
c = "D11";

configurePin(a, p, "DigitalOutput")
configurePin(a, n, "DigitalOutput")
configurePin(a, c, "DigitalOutput")
configurePin(a, c, "PWM")


while 1
    
    writeDigitalPin(a, p, 1)
    writeDigitalPin(a, n, 0)
    
    for x = 0:0.01:1
        writePWMDutyCycle(a, c, x)
        pause(0.01)
    end
    
    for x = 1:-0.01:0
        writePWMDutyCycle(a, c, x)
        pause(0.01)
    end
    
    writeDigitalPin(a, p, 0)
    writeDigitalPin(a, n, 1)
    
    for x = 0:0.01:1
        writePWMDutyCycle(a, c, x)
        pause(0.01)
    end
    
    for x = 1:-0.01:0
        writePWMDutyCycle(a, c, x)
        pause(0.01)
    end
    
    
end