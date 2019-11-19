generateNoiseImages

% Original Image
subplot(1, 5, 1)
imagesc([0 boardSizeX],[0 boardSizeY], sensedData');
title("Original Image")

% Wiener2
subplot(1, 5, 2)
wiener2Data = wiener2(sensedData', [5 5]);
imagesc([0 boardSizeX],[0 boardSizeY], wiener2Data);
title("Noise removal using wiener filter")

% Wiener2
subplot(1, 5, 3)
wiener2Data = wiener2(sensedData', [8 8]);
imagesc([0 boardSizeX],[0 boardSizeY], wiener2Data);
title("Noise removal using wiener filter")

% Wiener2
subplot(1, 5, 4)
wiener2Data = wiener2(sensedData', [10 10]);
imagesc([0 boardSizeX],[0 boardSizeY], wiener2Data);
title("Noise removal using wiener filter")

% Wiener2
subplot(1, 5, 5)
wiener2Data = wiener2(sensedData', [2 2]);
imagesc([0 boardSizeX],[0 boardSizeY], wiener2Data);
title("Noise removal using wiener filter")