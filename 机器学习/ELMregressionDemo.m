% 极限学习机(Extreme Learning Machine, ELM)在回归拟合问题中的应用研究
clear; clc;
% 导入数据
load data_regression.mat  input output
% 随机生成训练集、测试集
k = randperm(size(input,1));
% 训练集—1900个样本
P_train = input(k(1 : 1900), :)';
T_train = output(k(1 : 1900));
% 测试集—100个样本
P_test = input(k(1901 : 2000),:)';
T_test = output(k(1901 : 2000));
% ELM
% 归一化
% 训练集
[Pn_train, inputps] = mapminmax(P_train, -1, 1);
Pn_test = mapminmax('apply', P_test, inputps);
% 测试集
[Tn_train, outputps] = mapminmax(T_train, -1, 1);
% ELM创建、训练
[IW, B, LW, TF, TYPE] = ELMtrain(Pn_train, Tn_train, 20, 'sig', 0);
% ELM仿真测试
Tn_sim = ELMpredict(Pn_test, IW, B, LW, TF, TYPE);
% 反归一化
T_sim = mapminmax('reverse', Tn_sim, outputps);
% 结果对比
% 均方误差
E = mse(T_sim - T_test);
disp(['均方误差：', num2str(E)]);
% 决定系数
N = length(T_test);
% r2 = corrcoef(T_sim, T_test);
% R2 = r2(1, 2);
R2 = (N*sum(T_sim .* T_test) - sum(T_sim) * sum(T_test))^2 / ...
         ((N*sum((T_sim) .^ 2) - (sum(T_sim))^2) * (N*sum((T_test) .^2 ) - (sum(T_test))^2));
disp(['决定系数：', num2str(R2)]);
% 绘图
subplot(2, 1, 1)
plot(T_test, 'r*', 'LineWidth', 2)
hold on
plot(T_sim, 'b:o', 'LineWidth', 2)
hold off
xlabel('测试集样本编号')
ylabel('测试集输出')
title('ELM测试集输出')
legend('期望输出', '预测输出')
subplot(2, 1, 2)
plot(T_test - T_sim, 'r-*', 'LineWidth', 2)
xlabel('测试集样本编号')
ylabel('绝对误差')
title('ELM测试集预测误差')