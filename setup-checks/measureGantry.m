% Zero position (relative to gantry) and count (total steps since zero) variables
v.pos.x = 0;
v.pos.y = 0;

% Only reset count if this is a fresh encoder
if isfield(v, "count")
    [v.count.x, ~] = readCount(a.encoder.x);
    [v.count.y, ~] = readCount(a.encoder.y);
else
    v.count.x = 0;
    v.count.y = 0;
end

% Cutout pins enabled (allows movement)
writeDigitalPin(a.a, p.cutout.x, 1)
writeDigitalPin(a.a, p.cutout.y, 1)

input("Place gantry in maximum x and y. Press enter to continue... ")

% Cutout pins disabled
writeDigitalPin(a.a, p.cutout.x, 0)
writeDigitalPin(a.a, p.cutout.y, 0)

% Zero gantry without overwriting values
[a, v] = zeroGantry(a, p, v, 1);

% Get 0,0 position relative to start position
v = getPos(a, v);

fprintf("Gantry x: %.f\n", -v.pos.x);
fprintf("Gantry y: %.f\n", -v.pos.y);

% Zero gantry normally
[a, v] = zeroGantry(a, p, v);