% Enable pins
enable(1) = "D53";
enable(2) = "D52";

% Direction pins
direction(1) = "D51";
direction(2) = "D50";

% Pulse pins
%pulse(1) = "D49";
%pulse(2) = "D48";

% Microswitch pins
mswitch(1) = "D47";
mswitch(2) = "D46";

% Set Enable pins low
configurePin(a, enable(1), "DigitalOutput")
configurePin(a, enable(2), "DigitalOutput")

writeDigitalPin(a, enable(1), 0)
writeDigitalPin(a, enable(2), 0)

% Setup Direction pins
configurePin(a, direction(1), "DigitalOutput")
configurePin(a, direction(2), "DigitalOutput")

% Set Pulse pins
%configurePin(a, pulse(1), "DigitalOutput")
%configurePin(a, pulse(2), "DigitalOutput")

% Set Switch pins
configurePin(a, mswitch(1), "DigitalInput")
configurePin(a, mswitch(2), "DigitalInput")
