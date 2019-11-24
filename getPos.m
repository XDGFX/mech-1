function [v] = getPos(a, v, d)
% Get new position of gantry from encoder readings
% Note: Always set the direction pins first, then call this function!
% Note: Always call this function when gantry is stopped!

% If d doesn't exist or is "b", check both axes, otherwise check "d" only
if ~exist("d", "var") || d == "b"
    d = ['x', 'y'];
end

for d = d
    
    if v.direction.(d) % Travelling in positive direction
        
        % update position with change between old count and current count
        v.pos.(d) = v.pos.(d) + (v.count.(d) - readCount(a.encoder.(d)));
        
        % update current count
        [v.count.(d), ~] = readCount(a.encoder.(d));
        
    else % Travelling in negative direction
        
        % update position with change between old count and current count
        v.pos.(d) = v.pos.(d) + (readCount(a.encoder.(d)) - v.count.(d));
        
        % update current count
        [v.count.(d), ~] = readCount(a.encoder.(d));
        
    end
end