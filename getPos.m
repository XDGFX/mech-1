function [v] = getPos(a, v, p)
% Get new position of gantry from encoder readings
% Note: Always set the direction pins first, then call this function!
% Note: Always call this function when gantry is stopped!

for d = ['x', 'y']
    
    % Find direction; 1 is positive, 0 is negative
    direction.(d) = readDigitalPin(a.a, p.direction.(d));
    
    if direction.(d) % Travelling in positive direction
        
        % update position with change between old count and current count
        v.pos.(d) = v.pos.(d) + (readCount(a.encoder.(d)) - v.count.(d));
        
        % update current count
        [v.count.(d), ~] = readCount(a.encoder.(d));
        
    else % Travelling in negative direction
        
        % update position with change between old count and current count
        v.pos.(d) = v.pos.(d) - (readCount(a.encoder.(d)) - v.count.(d));
        
        % update current count
        [v.count.(d), ~] = readCount(a.encoder.(d));
        
    end
end