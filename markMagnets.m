function [v] = markMagnets(a, p, v)

% Loop through number of magnets
for i = 2:2:size(v.traverse, 1)
    
    % Go to first cup position
    v = goToPos(a, p, v, [v.traverse(i, 1), v.traverse(i, 2)]);
    
    % Pick up cup
    %v = actuateCup(a, p, v, 1);
    
    % Go to first magnet position
    v = goToPos(a, p, v, [v.traverse(i + 1, 1), v.traverse(i + 1, 2)]);
    
    % Drop cup
    %v = actuateCup(a, p, v, 0);
end
