function [v] = setupCups(a, p, v)

for n = 1:size(v.cuppos, 1)
    v = goToPos(a, p, v, v.cuppos(n, :));
    
    input("Place cup under position. Press enter to continue...")
    
    v = actuateCup(a, p, v, 1);
    v = actuateCup(a, p, v, 0);
    
end