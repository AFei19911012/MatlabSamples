clear; clc;
x = 0 : 0.1 : 5;
y = sin(x);
plot(x, y, 'o:', 'LineWidth', 2)
xlabel('x');
ylabel('y');
set(gca, 'looseInset', [0 0 0 0]);
% set(gca, 'Position', [0.1 0.1 0.85 0.85]);