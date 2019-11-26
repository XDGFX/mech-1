function [v] = getPos(a, v, d)
% Get new position of gantry from encoder readings
% Note: Always set the direction pins first, then call this function!
% Note: Always call this function when gantry is stopped!

% If d doesn't exist or is "b", check both axes, otherwise check "d" only
if ~exist("d", "var") || d == "b"
    d = ['x', 'y'];
end

for d = d
    
    rc = readCount(a.encoder.(d));
    
    if v.direction.(d) % Travelling in positive direction
        
        % update position with change between old count and current count
        v.pos.(d) = v.pos.(d) + (v.count.(d) - rc);
        
        % update current count
        v.count.(d) = rc;
        
    else % Travelling in negative direction
        
        % update position with change between old count and current count
        v.pos.(d) = v.pos.(d) + (rc - v.count.(d));
        
        % update current count
        v.count.(d) = rc;
        
    end
end