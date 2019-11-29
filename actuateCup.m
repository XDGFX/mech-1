function [v] = actuateCup(a, p, v, mode)

% Variables
speed = 50;
steps = 270;

if mode % Pickup cup
    
    mswitch = 0;
    failsafe = 0;
    
    while ~mswitch && failsafe < 12
        % Move stepper down
        MoveStepper(a.s, 0, speed, 20)
        
        % Read microswitch
        mswitch = readDigitalPin(a.a, p.cupswitch);
        
        failsafe = failsafe + 1;
    end
    
    % Enable electromagnet
    writeDigitalPin(a.a, p.magnet, 1)
    
    MoveStepper(a.s, 0, speed, 80)
    
    pause(0.2)
    
    % Move stepper back up
    MoveStepper(a.s, 1, speed, steps)
    
    % Cup is now held
    v.cup = 1;
    
else % Drop cup
        
    % Move stepper down
    MoveStepper(a.s, 0, speed, steps)
    
    % Disable electromagnet
    writeDigitalPin(a.a, p.magnet, 0)
    
    pause(0.2)
    
    % Move stepper back up
    MoveStepper(a.s, 1, speed, steps)
    
    % Cup is now dropped
    v.cup = 0;
    
end

