clear; clc;
I = imread('cameraman.tif');
subplot(1, 3, 1)
imshow(I);
xlabel('原始图像');
II = double(I);
level = ThresholdMaxEntropy(II);      % 使用最大熵计算阈值
BW = imbinarize(I, level / 255);     
subplot(1, 3, 2)
imshow(BW);
xlabel(['最大熵: ', num2str(level)]);
T = ThresholdOtsu(II);                % 使用大津法计算阈值
BW = imbinarize(I, T / 255);
subplot(1, 3, 3)
imshow(BW);
xlabel(['大津法Otsu: ', num2str(T)]);