[a, v] = zeroGantry(a, p, v);

testPos = [0, 12500; ...
    100, 12500; ...
    100, 0; ...
    200, 0; ...
    200, 12500; ...
    300, 12500; ...
    300, 0];

for i = 1:length(testPos)
    pos = [testPos(i, 1), testPos(i, 2)];
    v = goToPos(a, p, v, pos, 0);
    
    fprintf("Requested Pos: %.f, %.f\n", pos(1), pos(2))
    
    v = getPos(a, v, "b");
    
    fprintf("Actual Pos: %.f, %.f\n", v.pos.x, v.pos.y)
    
    fprintf("Diff: %.f, %.f\n\n", abs(v.pos.x - pos(1)), abs(v.pos.y - pos(2)))
    
end