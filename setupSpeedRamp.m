pwmPin = "D12";
rampPin = "D11";
toggle = "D13";

stepSize = 25;
frq = 490;

tPause = 0.05;

%% For reference
rampSteps = 464;

configurePin(a, pwmPin, "DigitalOutput")
configurePin(a, rampPin, "DigitalOutput")
configurePin(a, toggle, "DigitalOutput")