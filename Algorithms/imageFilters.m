figure('Position', [0 0 2000 200])

generateNoiseImages

% Original Image
subplot(1, 5, 1)
imagesc([0 boardSizeX],[0 boardSizeY], sensedData');
title("Original Image")

% Wiener2
subplot(1, 5, 2)
wiener2Data = wiener2(sensedData', [5 5]);
imagesc([0 boardSizeX],[0 boardSizeY], wiener2Data);
title("Wiener Filter")

% Box Blur
subplot(1, 5, 3)
boxBlurData = imboxfilt(sensedData', [5 5]);
imagesc([0 boardSizeX],[0 boardSizeY], boxBlurData);
title("Box Blur")

% Sharpen then Wiener2
subplot(1, 5, 4)
sharpCoeff = [0 0 0;0 1 0;0 0 0]-fspecial('laplacian',0.2);
wienerSharpenData = imfilter(sensedData',sharpCoeff,'symmetric');
wienerSharpenData = wiener2(wienerSharpenData, [2 2]);
imagesc([0 boardSizeX],[0 boardSizeY], wienerSharpenData);
title("Sharpen then Wiener Filter")

net = denoisingNetwork('DnCNN');

% Neural Network Denoiser
subplot(1, 5, 5)
denoisedI = denoiseImage(sensedData',net);
imagesc([0 boardSizeX],[0 boardSizeY], denoisedI);
title("Denoiser Neural Network")

