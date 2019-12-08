clear; clc;
func = @ObjFun;
[xm1, fv1] = PsoCompressionFactor(func, 50, 2.05, 2.05, [10, 10], [-10, -10], 1, -1, 1000, 2);
[xm2, fv2] = PsoSelfAdaption(func, 50, 2, 2, [10, 10], [-10, -10], 1, -1, 0.9, 0.6, 1000, 2);
[xm3, fv3] = PsoNatrualSelection(func, 50, 2, 2, [10, 10], [-10, -10], 1, -1, 0.8, 1000, 2);
% »­Í¼
len = 50;
xRange = linspace(-10, 10, len);
yRange = linspace(-10, 10, len);
[xMap, yMap] = meshgrid(xRange, yRange);
zMap = zeros(len);
for i = 1 : len
    for j = 1 : len
        zMap(i, j) = ObjFun([xMap(i, j), yMap(i, j)]);
    end
end
surf(xRange, yRange, zMap);
colorbar;
view(-45, -45);
shading interp
hold on
plot3(xm1(1), xm1(2), fv1, 'o', 'MarkerFaceColor', 'r', 'MarkerSize', 10);
plot3(xm2(1), xm2(2), fv2, 'o', 'MarkerFaceColor', 'b', 'MarkerSize', 10);
plot3(xm3(1), xm3(2), fv3, 'o', 'MarkerFaceColor', 'm', 'MarkerSize', 10);
hold off