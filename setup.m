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

% Electromagnet pin
p.magnet = "D24";

% Cup switch pin
p.cupswitch = "D28";

%% --- OTHER VARIABLES ---

% RAMP VARIABLES
% Max frequency
v.frq = 1500;

% Ramp gradient
v.m = 75;

% How many steps is close enough?
v.CE = 20;

% Minimum frequency to output when ramping
v.minFrq = 400;

% Maximum gantry dimensions
% Ref: 15000 is 460mm
v.gantry.x = 12000;
v.gantry.y = 15000;

% SCAN VARIABLES
% Steps between scanning interval
v.scanRes = 300;

% Scanning movement frequency
v.scanSpeed = 1000;

% CUP VARIABLES
% Cup currently held
v.cup = 0;

% Position vector of cups
v.cuppos = [0, 15000; ...
    2500, 15000; ...
    5000, 15000; ...
    7500, 15000; ...
    10000, 15000; ...
    0, 0; ...
    2500, 0; ...
    5000, 0; ...
    7500, 0; ...
    10000, 0
    ];

%% --- SETUP ARDUINO ---

input("TURN OFF GANTRY! Press enter to continue... ")

a.a = arduino('/dev/cu.usbmodem14101','Mega2560','Libraries',{'rotaryEncoder', 'BathUniversity/StepperMotorAddOn'});


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

% Configure stepper motor shield
a.s = addon(a.a, 'BathUniversity/StepperMotorAddOn', {'D8', 'D9', 'D12', 'D13'});

% Enable stepper motor shield
configurePin(a.a, "D10", "DigitalOutput")
configurePin(a.a, "D11", "DigitalOutput")
writeDigitalPin(a.a, "D10", 1)
writeDigitalPin(a.a, "D11", 1)

% Configure and set electromagnet low (disabled)
configurePin(a.a, p.magnet, do)
writeDigitalPin(a.a, p.magnet, 0)

% % Configure microswitch input
configurePin(a.a, p.cupswitch, di)

input("TURN ON GANTRY! Press enter to zero gantry... ")

[a, v] = zeroGantry(a, p, v);

end