steps = [0 0];
time = 2;

for frq = 0:0.001:1
    steps(time) = steps(time - 1) + frq;
    
    
    time = time + 1;
end