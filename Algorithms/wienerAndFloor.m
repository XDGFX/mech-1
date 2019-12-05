figure('Position', [0 0 2000 200])

generateNoiseImages

% Original Image
subplot(1, 5, 1)
imagesc([0 boardSizeX],[0 boardSizeY], sensedData');
title("Original Image")

% Wiener2
subplot(1, 5, 2)
wiener2Data = wiener2(sensedData', [8 8]);

wiener2Data = wiener2Data .* (wiener2Data > 0);

imagesc([0 boardSizeX],[0 boardSizeY], wiener2Data);
title("No floor")

% Wiener2
subplot(1, 5, 3)
wiener2Data = wiener2(sensedData', [8 8]);

wiener2Data = wiener2Data .* (wiener2Data > 0.2);

imagesc([0 boardSizeX],[0 boardSizeY], wiener2Data);
title("Floor 0.2")

% Wiener2
subplot(1, 5, 4)
wiener2Data = wiener2(sensedData', [8 8]);

wiener2Data = wiener2Data .* (wiener2Data > 0.4);

imagesc([0 boardSizeX],[0 boardSizeY], wiener2Data);
title("Floor 0.4")

% Wiener2
subplot(1, 5, 5)
wiener2Data = wiener2(sensedData', [8 8]);

wiener2Data = wiener2Data .* (wiener2Data > 0.6);

imagesc([0 boardSizeX],[0 boardSizeY], wiener2Data);
title("Floor 0.6")
