currentPos = 0;
desiredPos = 1000;

%stepSize = 10;

maxFrq = 4500;

rampSteps = 400;

profile = [0, rampSteps, desiredPos - rampSteps, desiredPos; 0, maxFrq, maxFrq, 0];


for 


plot(profile(1, :), profile(2, :))

