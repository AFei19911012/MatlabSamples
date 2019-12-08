% RBF Network approximation
clear; clc;
% 网络学习参数
alfa = 0.07;    % 动量因子
xite = 0.9;      % 学习因子
x = [0, 0]';
b = 1.35*ones(4, 1);    % 基宽
c = 0.65*ones(2, 4);    % 中心点
rng('default');
w = rands(4, 1);
w_1 = w;
w_2 = w_1;
c_1 = c;
c_2 = c_1;
b_1 = b;
b_2 = b_1;
d_w = 0*w;
d_b = 0*b;
y_1 = 0;
ts = 0.001;
M = 10000;
time = zeros(M, 1);
u = zeros(M, 1);
y = zeros(M, 1);
ym = zeros(M, 1);
em = zeros(M, 1);
dyu = zeros(M, 1);
h = zeros(1, 4);
d_c = zeros(2, 4);
for k = 1 : M
    time(k) = k*ts;
    u(k) = 0.350*sin(3*pi*k*ts);
    y(k) = u(k)^3 + y_1/(1 + y_1^2);
    x(1) = u(k);    % 初值
    x(2) = y(k);
    for j = 1 : 4
        h(j)=exp(-norm(x - c(:, j))^2 / (2*b(j)*b(j)));   % 高斯基函数
    end
    ym(k) = h*w;
    em(k) = y(k) - ym(k);
    for j=1 : 4
        d_w(j) = xite*em(k)*h(j);
        d_b(j) = xite*em(k)*w(j)*h(j)*(b(j)^-3)*norm(x - c(:, j))^2;
        for i = 1 : 2
            d_c(i, j) = xite*em(k)*w(j)*h(j)*(x(i) - c(i, j))*(b(j)^-2);
        end
    end
    w = w_1 + d_w + alfa*(w_1 - w_2);
    b = b_1 + d_b + alfa*(b_1 - b_2);
    c = c_1 + d_c + alfa*(c_1 - c_2);
    % Jacobian 信息
    yu = 0;
    for j = 1 : 4
        yu = yu + w(j)*h(j)*(c(1,  j) - x(1)) / b(j)^2;      % 敏感度
    end
    dyu(k) = yu;
    y_1 = y(k);
    w_2 = w_1;
    w_1 = w;
    c_2 = c_1;
    c_1 = c;
    b_2 = b_1;
    b_1 = b;
end
subplot(3, 1, 1)
plot(time, y, 'r', time, ym, 'b', 'LineWidth', 2);       % RBF网络辨识结果
xlabel('time(s)');
ylabel('y and ym');
title('RBF 网络辨识结果')
subplot(3, 1, 2)
plot(time, y - ym, 'r', 'LineWidth', 2);      % RBF网络辨识误差
xlabel('time(s)');
ylabel('identification error');
title('RBF 网络辨识误差')
subplot(3, 1, 3)
plot(time, dyu, 'r', 'LineWidth', 2);      % RBF网络敏感度Jacobian信息
xlabel('times');
ylabel('dyu');
title('RBF 网络敏感度Jacobian 信息')