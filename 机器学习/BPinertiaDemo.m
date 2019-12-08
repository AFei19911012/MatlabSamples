% 输入为[1 -1 1]'，希望的输出为[1 1]'
clear; clc;
% 两层 BP 算法的第一阶段—学习期（训练加权系数 Wki，Wij）
% 初始化
lr = 0.05;        % 学习速率；
err_goal = 1e-3;  % 期望误差最小值
max_epoch = 1000; % 训练的最大次数
alpha = 0.9;   % 惯性系数
% 提供一组训练集和目标值（3输入2输出）
X = [1; -1; 1];
T = [1; 1];
M = 3;  % 输入层
q = 8;  % 隐含层
L = 2;  % 输出层
rng('default');
Wij = rand(q, M);
Wki = rand(L, q);
Wij0 = zeros(size(Wij));
Wki0 = zeros(size(Wki));
Oi = zeros(q, 1);     % 隐含层各神经元输出
Ok = zeros(L, 1);     % 输出层各神经元输出
for epoch = 1 : max_epoch
    % 计算隐含层各神经元输出
    NETi = Wij * X;
    for i = 1 : q
        Oi(i) = 2 / (1 + exp(-NETi(i))) - 1;  % 激活函数
    end
    % 计算输出层各神经元输出
    NETk = Wki * Oi;
    for k = 1 : L
        Ok(k) = 2 / (1 + exp(-NETk(k))) - 1;
    end
    %计算误差函数
    E = norm(T - Ok);
    if E < err_goal
        break;
    end
    % 调整输出层加权系数
    deltak = Ok .* (1 - Ok).*(T - Ok);
    W = Wki;
    Wki = Wki + lr*deltak * Oi' + alpha * (Wki - Wki0);   % 加惯性系数
    Wki0 = W;
    % 调整隐含层加权系数
    deltai = Oi .* (1 - Oi) .* (deltak' * Wki)';
    W = Wij;
    Wij = Wij + lr * deltai * X' + alpha * (Wij - Wij0);
    Wij0 = W;
end
% BP 算法的第二阶段—工作期（根据训练好的Wki、Wij和给定的输入计算输出）
X1 = X;    % 给定输入
% 计算隐含层各神经元输出
NETi = Wij * X1;
for i = 1 : q
    Oi(i) = 2/(1 + exp(-NETi(i))) - 1;
end
% 计算输出层各神经元输出
NETk = Wki * Oi;
for k = 1 : L
    Ok(k) = 2/(1 + exp(-NETk(k))) - 1;
end
disp(epoch);   % 显示计算次数
disp(Ok);      % 显示网络输出层的输出