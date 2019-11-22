function [a, p, v] = setup()
%% --- PIN VARIABLES ---

% Gantry enable pins
p.enable.x = "D53";
p.enable.y = "D52";

% Gantry direction pins
p.direction.x = "D51";
p.direction.y = "D50";

% Gantry microswitch pins
p.mswitch.x = "D49";
p.mswitch.y = "D48";

% playTone / ramp pin
p.ramp = "D9";

% Ramp toggle pins (switch between ramp and 555)
p.toggle.x = "D8";
p.toggle.y = "D7";

% Encoder read pins
p.encoder.x1 = "D2"; % Stepper input
p.encoder.x2 = "D3"; % Edge trig pulse
p.encoder.y1 = "D18"; % Stepper input
p.encoder.y2 = "D19"; % Edge trig pulse

%% --- OTHER VARIABLES ---

% RAMP VARIABLES
% Ramp up / down step size in Hz
v.stepSize = 100;

% Frequency at which ramp will switch to 555
v.frq = 4400 - v.stepSize;

% Time pause between ramp steps
v.tPause = 0.05;

% Number of steps required to ramp up or down from full speed
v.rampSteps = 464;

%% --- SETUP ARDUINO ---

a.a = arduino('/dev/cu.usbmodem14101','Mega2560','Libraries',{'I2C', 'SPI', 'Servo', 'rotaryEncoder'});


%% --- INITIALISE PINS ---

do = "DigitalOutput";
di = "DigitalInput";

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

%% --- ZERO GANTRY ---

% Set direction pins to -x, -y
writeDigitalPin(a.a, p.direction.x, 0)
writeDigitalPin(a.a, p.direction.y, 0)

% Constant playtone of 490Hz for 100s
playTone(a.a, p.ramp, 490, 60)

% Initialise zeroing variables
z.x = 1;
z.y = 1;

while z.x || z.y
    
    % Check x axis not reached home
    if ~readDigitalPin(a.a, p.mswitch.x)
        writeDigitalPin(a.a, p.enable.x, 1)
        z.x = 0;
    end
    
    % Check y axis not reached home
    if ~readDigitalPin(a.a, p.mswitch.y)
        writeDigitalPin(a.a, p.enable.y, 1)
        z.y = 0;
    end
    
end

% Clear playtone pin
playTone(a.a, p.ramp, 0, 0.1)

% Configure rotary encoders (will start counting immediately)
a.encoder.x = rotaryEncoder(a.a, p.encoder.x1, p.encoder.x2);
a.encoder.y = rotaryEncoder(a.a, p.encoder.y1, p.encoder.y2);

% Zero position (relative to gantry) and count (total steps since zero) variables
v.pos.x = 0;
v.pos.y = 0;
v.count.x = 0;
v.count.y = 0;

end