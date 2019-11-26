function [a, p, v] = setup()
%% --- PIN VARIABLES ---

% Gantry cutout pins
p.cutout.x = "D6";
p.cutout.y = "D7";

% Gantry direction pins
p.direction.x = "D5";
p.direction.y = "D3";

% Gantry microswitch pins
p.mswitch.x = "D4";
p.mswitch.y = "D2";

% playTone / ramp pin
p.ramp = "D15";

% Gantry enable pins (previously toggle)
p.enable.x = "D14";
p.enable.y = "D16";

% Encoder read pins
p.encoder.x1 = "D18"; % Stepper input
p.encoder.x2 = "D20"; % Edge trig pulse
p.encoder.y1 = "D19"; % Stepper input
p.encoder.y2 = "D21"; % Edge trig pulse

% Hall effect sensor read pins
p.sens(2) = "A10";
p.sens(3) = "A9";
p.sens(1) = "A8";

%% --- OTHER VARIABLES ---

% RAMP VARIABLES
% Max frequency
v.frq = 4000;

% Ramp gradient
v.m = 75;

% How many steps is close enough?
v.CE = 50;

% Minimum frequency to output when ramping
v.minFrq = 400;

% Maximum gantry dimensions
v.gantry.x = 15000;
v.gantry.y = 15000;

% SCAN VARIABLES
% Steps between scanning interval
v.scanRes = 300;

% Scanning movement frequency
v.scanSpeed = 600;

%% --- SETUP ARDUINO ---

input("TURN OFF GANTRY! Press enter to continue... ")

a.a = arduino('/dev/cu.usbmodem14101','Mega2560','Libraries',{'I2C', 'SPI', 'Servo', 'rotaryEncoder'});


%% --- INITIALISE PINS ---

do = "DigitalOutput";
di = "DigitalInput";
ai = "AnalogInput";

% Configure and set cutout pins low (enabled)
configurePin(a.a, p.cutout.x, do)
configurePin(a.a, p.cutout.y, do)

writeDigitalPin(a.a, p.cutout.x, 0)
writeDigitalPin(a.a, p.cutout.y, 0)

% Configure and set enable pins low (enabled)
configurePin(a.a, p.enable.x, do)
configurePin(a.a, p.enable.y, do)

writeDigitalPin(a.a, p.enable.x, 0)
writeDigitalPin(a.a, p.enable.y, 0)

% Configure direction pins
configurePin(a.a, p.direction.x, do)
configurePin(a.a, p.direction.y, do)

% Configure microswitch pins
configurePin(a.a, p.mswitch.x, di)
configurePin(a.a, p.mswitch.y, di)

% Configure hall effect sensor pins
configurePin(a.a, p.sens(1), ai)
configurePin(a.a, p.sens(2), ai)
configurePin(a.a, p.sens(3), ai)

input("TURN ON GANTRY! Press enter to zero gantry... ")

[a, v] = zeroGantry(a, p, v);

end