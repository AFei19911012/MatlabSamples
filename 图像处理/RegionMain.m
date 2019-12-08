clear; clc;
img = imread('region.bmp');
subplot(1, 2, 1)
imshow(img);
if length(size(img)) > 2
    I = rgb2gray(img); 
else
    I = img;
end
I = double(I);
% x = 190;
% y = 190;
p1 = ginput(1);
x = round(p1(2));
y = round(p1(1));
J = RegionGrowing(I, [x, y], 50);
[bound, F] = RegionBoundary(J);
subplot(1, 2, 2)
imshow(J)
hold on 
plot(y, x, 'pm', 'MarkerSize', 10, 'MarkerFaceColor', 'm')
plot(bound(:, 1), bound(:, 2), 'r', 'LineWidth', 2)
hold off