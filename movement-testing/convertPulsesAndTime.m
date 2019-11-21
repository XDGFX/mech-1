hold on

for t = 1

% Ramp of 1000Hz / ts
frq = [0,  4500];
time = [0,  t];

betterTime = [time(1):0.1:time(end)];
betterFrq = interp1(time, frq, betterTime);
steps = cumtrapz(betterTime, betterFrq) / t;

plot(steps, betterFrq)

end

m = maxFrq / rampSteps ^(0.5)

frq = m * steps ^ 0.5