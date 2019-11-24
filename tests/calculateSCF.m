function [calcSCF] = calculateSCF(a, p, v)

% Starting SCF
v.SCF = v.SCF;

calcSCF = [];

% Zero gantry
[a, v] = zeroGantry(a, p, v);

for dist = 5000:100:6000
    if v.SCF > 10 || v.SCF < 0
        error("out of bounds")
    end
    
    % Travel distance and measure distance traveled
    [v, travel] = testFrqCurve(a, p, v, dist);
    
    travel = (travel.x + travel.y) / 2;
    
    calcSCF = [calcSCF, v.SCF * dist / travel];
    
    fprintf("Requested Distance: %.f\n", dist)
    fprintf("Measured Travel: %.f\n", travel)
    fprintf("Calculated SCF: %f\n", calcSCF(end))
end
end

