function [a, p, v] = setup()
%% --- PIN VARIABLES ---

% Gantry enable pins
p.cutout.x = "D49";
p.cutout.y = "D48";

% Gantry direction pins
p.direction.x = "D53";
p.direction.y = "D51";

% Gantry microswitch pins
p.mswitch.x = "D52";
p.mswitch.y = "D50";

% playTone / ramp pin
p.ramp = "D9";

% Gantry enable pins (previously toggle)
p.enable.x = "D8";
p.enable.y = "D7";

% Encoder read pins
p.encoder.x1 = "D2"; % Stepper input
p.encoder.x2 = "D3"; % Edge trig pulse
p.encoder.y1 = "D18"; % Stepper input
p.encoder.y2 = "D19"; % Edge trig pulse

%% --- OTHER VARIABLES ---

% RAMP VARIABLES
% Ramp up / down step size in Hz
v.stepSize = 300;

% Frequency at which ramp will switch to 555
v.frq = 4319;

% Time pause between ramp steps
v.tPause = 0.05;

% Number of steps required to ramp up or down from full speed
v.rampSteps = 464;

%% --- SETUP ARDUINO ---

input("TURN OFF GANTRY! Press enter to continue... ")

a.a = arduino('/dev/cu.usbmodem14101','Mega2560','Libraries',{'I2C', 'SPI', 'Servo', 'rotaryEncoder'});


%% --- INITIALISE PINS ---

do = "DigitalOutput";
di = "DigitalInput";

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

input("TURN ON GANTRY! Press enter to zero gantry... ")

[a, v] = zeroGantry(a, p, v);

end