figure('Position', [0 0 2000 200])

generateNoiseImages

% Original Image
subplot(1, 5, 1)
imagesc([0 boardSizeX],[0 boardSizeY], sensedData');
title("Original Image")

% Wiener2
subplot(1, 5, 3)
wiener2Data = wiener2(sensedData', [5 5]);
imagesc([0 boardSizeX],[0 boardSizeY], wiener2Data);
title("3 x 3")

% Wiener2
subplot(1, 5, 4)
wiener2Data = wiener2(sensedData', [8 8]);
imagesc([0 boardSizeX],[0 boardSizeY], wiener2Data);
title("8 x 8")

% Wiener2
subplot(1, 5, 5)
wiener2Data = wiener2(sensedData', [10 10]);
imagesc([0 boardSizeX],[0 boardSizeY], wiener2Data);
title("10 x 10")

% Wiener2
subplot(1, 5, 2)
wiener2Data = wiener2(sensedData', [2 2]);
imagesc([0 boardSizeX],[0 boardSizeY], wiener2Data);
title("2 x 2")