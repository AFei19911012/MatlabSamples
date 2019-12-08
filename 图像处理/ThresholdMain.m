clear; clc;
I = imread('cameraman.tif');
subplot(1, 3, 1)
imshow(I);
xlabel('ԭʼͼ��');
II = double(I);
level = ThresholdMaxEntropy(II);      % ʹ������ؼ�����ֵ
BW = imbinarize(I, level / 255);     
subplot(1, 3, 2)
imshow(BW);
xlabel(['�����: ', num2str(level)]);
T = ThresholdOtsu(II);                % ʹ�ô�򷨼�����ֵ
BW = imbinarize(I, T / 255);
subplot(1, 3, 3)
imshow(BW);
xlabel(['���Otsu: ', num2str(T)]);