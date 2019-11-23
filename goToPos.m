function [v] = goToPos(a, p, v, position)
% Sends gantry to pos = [x, y] as fast as possible

pos.x = position(1);
pos.y = position(2);

% Read current position
v = getPos(a, v, p);

% Calculate distance required to travel
dist.x = pos.x - v.pos.x;
dist.y = pos.y - v.pos.y;

% Assign shortest distance variable to 's' and longest to 'l'
if dist.x < dist.y
    s = "x";
    l = "y";
else
    s = "y";
    l = "x";
end



dist.(s);

end

