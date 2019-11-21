function [] = betaPosition(a, p, v, tp)
% BETAPOSITION Takes target position in the form of pos.x and pos.y, and
% moves gantry to get to the position.

% when profile (pr) = 1, frq = v.frq

% v.rampSteps = number of steps in normal ramp
rs = v.rampSteps;

dist.x = tp.x - v.pos.x;
dist.y = tp.y - v.pos.y;

if dist.x >= dist.y % x is long distance
    l = "x";
    s = "y";
else                % y is long distance
    l = "y";
    s = "x";
end

pr.l = [0; 0]; % [steps; speed]
pr.s = [0; 0]; % [steps; speed]

if dist.l >= 4 * rs
    if dist.s >= 2 * rs
        
        pr.l = [pr.l, [rs; 1], [dist.l - rs; 1], [dist.l; 0]];
        
        
        
        start 45 deg
        
             both ramp up to 1
             
             once reached 1, ramp down shorter
        
        
        do shorter correction in middle
    else
        start at 90 deg long one only
        
        if dist.l - 2 * ramp > dist.s
            correct in middle
        else
            do one at a time
        end
    end
else
    do one at a time
end


end

