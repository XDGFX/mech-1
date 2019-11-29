clear variables

[a, p, v] = setup();
% 
% %input("Ready to place cups. Press enter to begin.")
% v = setupCups(a, p, v);

% Reset gantry zero
[a, v] = zeroGantry(a, p, v);

v = goToPos(a, p, v, [0, 2000]);

% Drop sensor head ready for scanning
failsafe = 0;
mswitch = readDigitalPin(a.a, p.cupswitch);
while ~mswitch && failsafe < 15
    % Move stepper down
    MoveStepper(a.s, 0, 20, 20)
    
    % Read microswitch
    mswitch = readDigitalPin(a.a, p.cupswitch);
    
    failsafe = failsafe + 1;
end

input("Ready to go. Press enter to begin.")

disp("Scanning board for magnets...")
v = scanBoard(a, p, v);

disp("Calculating magnet positions...")
v = centreDetection(v);

disp("Calculating optimal path...")
v = traverse(v);

v = getPos(a, v);

disp("Marking magnets...")
v = markMagnets(a, p, v);

disp("Complete!")