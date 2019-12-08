clear; clc;
% x ��ʾ����y ��ʾ����
imgGrayData = imread('spot.bmp')';  % ͼ��������ݷ���һ��             
[row, col] = size(imgGrayData);            % ȡ��ͼ���С
[X0, Y0] = meshgrid(1 : col, 1 : row);     % ������������
x0 = X0 / 10;
y0 = Y0 / 10;
imgData = double(imgGrayData);                  % uint8 ת��Ϊ double 
% ��ͼ
subplot(2, 1, 1)
surf(x0, y0, imgData);                    
shading interp;        % smooth
% ���Ի�
% f(x, y) = a * exp(-((x - b1)^2 / c1 + (y - b2)^2 / c2));
% ln(f(x, y)) = ln(a) - (x - b1)^2 / c1 - (y - b2)^2 / c2;
% g(x, y) = a * x^2 + b * y^2 + c * x + d * y + e;
% �������
flag = imgGrayData >= 5;
num = sum(flag(:));
xfit = zeros(num, 1);
yfit = zeros(num, 1);
zfit0 = zeros(num, 1);
ind = 1;
for i = 1 : row
    for j = 1 : col
        if flag(i, j) == 1
            xfit(ind) = x0(i, j);
            yfit(ind) = y0(i, j);
            zfit0(ind) = imgData(i, j);
            ind = ind + 1;
        end
    end
end
zfit = log(zfit0);
% ϵ������
xfit2 = xfit .* xfit;
yfit2 = yfit .* yfit;
A = [xfit2, yfit2, xfit, yfit, ones(num, 1)];
result = A \ zfit;
disp(result);
% ��ԭ
sigmaX = sqrt(-0.5 / result(1));
sigmaY = sqrt(-0.5 / result(2));
centerX = sigmaX * sigmaX * result(3);
centerY = sigmaY * sigmaY * result(4);
Amplitude = exp(result(5) + 0.5 * centerX * result(3) + 0.5 * centerY * result(4));
% centerX = round(centerX * 10);
% centerY = round(centerY * 10);
coeFit = [Amplitude; centerX; sigmaX; centerY; sigmaY];
disp(coeFit);
% ��ͼ
subplot(2, 1, 2)
imgDataFit = coeFit(1) * exp(-(x0 - coeFit(2)).^2 / (2 * coeFit(3) * coeFit(3)) - (y0 - coeFit(4)).^2 / (2 * coeFit(5) * coeFit(5)));
surf(x0, y0, imgDataFit); 
shading interp