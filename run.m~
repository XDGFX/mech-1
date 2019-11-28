clear variables

[a, p, v] = setup();

%input("Ready to place cups. Press enter to begin.")
%v = setupCups(a, p, v);

% Reset gantry zero
%[a, v] = zeroGantry(a, p, v);

% Drop sensor head ready for scanning
MoveStepper(a.s, 0, 50, 200)

input("Ready to go. Press enter to begin.")

disp("Scanning board for magnets...")
v = scanBoard(a, p, v);

disp("Calculating magnet positions...")
v = centreDetection(v);

disp("Calculating optimal path...")
v = traverse(v);

disp("Marking magnets...")
v = markMagnets(a, p, v);

disp("Complete!")