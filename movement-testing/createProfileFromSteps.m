maxFrq = 4500;
rampSteps = 400;

steps = 6000;

% Find gradient of ramp
m = maxFrq / rampSteps ^(0.5);

% Ramp of 1000Hz / ts
frq = [0,  4500];
time = [0,  t];

betterTime = [time(1):0.1:time(end)];
betterFrq = interp1(time, frq, betterTime);
steps = cumtrapz(betterTime, betterFrq) / t;

%plot(steps, betterFrq)

end