clear; clc;
n = 1000;
[x, y, z] = peaks(n);
subplot(1, 2, 1)
surf(x, y, z);
shading interp
view(0, 90)
for i = 1:n
    for j = 1:n
        if x(i, j)^2 + 2 * y(i, j)^2 > 6 && 2 * x(i, j)^2 + y(i, j)^2 < 6
            z(i, j) = NaN;
        end
    end
%     z(randi(n, 1):end, i)=NaN;
end
subplot(1, 2, 2)
surf(x, y, z);
shading interp
view(0, 90)