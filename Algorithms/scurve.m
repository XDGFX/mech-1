figure('Position', [0 0 2000 450])

x = 0:0.01:1;

generateNoiseImages

% Original Image
subplot(2, 5, 6)
imagesc([0 boardSizeX],[0 boardSizeY], sensedData');
title("Original Image")

subplot(2, 5, 1)
y = x;
plot(x, y)
title("No Filter")

subplot(2, 5, 7)
sdata = smf(sensedData', [0, 1]);
imagesc([0 boardSizeX],[0 boardSizeY], sdata);
title("Output")

subplot(2, 5, 2)
y = smf(x, [0, 1]);
plot(x, y)
title("[0, 1]")

% Wiener2
subplot(2, 5, 8)
sdata = smf(sensedData', [0, 0.3]);
imagesc([0 boardSizeX],[0 boardSizeY], sdata);
title("Output")

subplot(2, 5, 3)
y = smf(x, [0, 0.3]);
plot(x, y)
title("[0, 0.3]")

% Wiener2
subplot(2, 5, 9)
sdata = smf(sensedData', [0.3, 0.7]);
imagesc([0 boardSizeX],[0 boardSizeY], sdata);
title("Output")

subplot(2, 5, 4)
y = smf(x, [0.3, 0.7]);
plot(x, y)
title("[0.3, 0.7]")

% Wiener2
subplot(2, 5, 10)
sdata = smf(sensedData', [0.7, 1]);
imagesc([0 boardSizeX],[0 boardSizeY], sdata);
title("Output")

subplot(2, 5, 5)
y = smf(x, [0.7, 1]);
plot(x, y)
title("[0.7, 1]")