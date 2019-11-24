[a, v] = zeroGantry(a, p, v);

testPos = [1000, 1000; ...
    2000, 2000; ...
    5000, 5000; ...
    1000, 5000; ...
    10000, 1000; ...
    2417, 3981; ...
    0, 0];

for i = 1:length(testPos)
    pos = [testPos(i, 1), testPos(i, 2)];
    v = goToPos(a, p, v, pos);
    
    fprintf("Requested Pos: %.f, %.f\n", pos(1), pos(2))
    
    v = getPos(a, v, "b");
    
    fprintf("Actual Pos: %.f, %.f\n", v.pos.x, v.pos.y)
    
    fprintf("Diff: %.f, %.f\n\n", abs(v.pos.x - pos(1)), abs(v.pos.y - pos(2)))
    
end