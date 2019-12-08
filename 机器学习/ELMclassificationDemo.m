% 极限学习机(Extreme Learning Machine, ELM)在分类问题中的应用研究
clear; clc;
% 导入数据
load data_classification.mat data
% 随机生成训练集、测试集
rng('default');
a = randperm(569);
% 训练集—500个样本
Train = data(a(1 : 500), :);
% 测试集—69个样本
Test = data(a(501 : end), :);
% 训练数据
P_train = Train(:, 3 : end)';
T_train = Train(:, 2)';
% 测试数据
P_test = Test(:, 3 : end)';
T_test = Test(:, 2)';
% ELM
%  ELM创建、训练
[IW, B, LW, TF, TYPE] = ELMtrain(P_train, T_train, 100, 'sig', 1);
% ELM仿真测试
T_sim_1 = ELMpredict(P_train, IW, B, LW, TF, TYPE);
T_sim_2 = ELMpredict(P_test, IW, B, LW, TF, TYPE);
% 结果对比
% 训练集正确率
k1 = length(find(T_train == T_sim_1));
n1 = length(T_train);
Accuracy_1 = k1 / n1 * 100;
disp(['训练集正确率Accuracy = ' num2str(Accuracy_1) '%(' num2str(k1) '/' num2str(n1) ')'])
% 测试集正确率
k2 = length(find(T_test == T_sim_2));
n2 = length(T_test);
Accuracy_2 = k2 / n2 * 100;
disp(['测试集正确率Accuracy = ' num2str(Accuracy_2) '%(' num2str(k2) '/' num2str(n2) ')'])
% 显示
count_B = length(find(T_train == 1));
count_M = length(find(T_train == 2));
total_B = length(find(data(:,2) == 1));
total_M = length(find(data(:,2) == 2));
number_B = length(find(T_test == 1));
number_M = length(find(T_test == 2));
number_B_sim = length(find(T_sim_2 == 1 & T_test == 1));
number_M_sim = length(find(T_sim_2 == 2 & T_test == 2));
disp(['病例总数：' num2str(569)  '  良性：' num2str(total_B)  '  恶性：' num2str(total_M)]);
disp(['训练集病例总数：' num2str(500) '  良性：' num2str(count_B) '  恶性：' num2str(count_M)]);
disp(['测试集病例总数：' num2str(69) '  良性：' num2str(number_B) '  恶性：' num2str(number_M)]);
disp(['良性乳腺肿瘤确诊：' num2str(number_B_sim) '  误诊：' num2str(number_B - number_B_sim) '  确诊率p1=' num2str(number_B_sim/number_B*100) '%']);
disp(['恶性乳腺肿瘤确诊：' num2str(number_M_sim) '  误诊：' num2str(number_M - number_M_sim) '  确诊率p2=' num2str(number_M_sim/number_M*100) '%']);
%  隐含层神经元个数影响
R = zeros(10, 2);
for i = 1 : 10
    % ELM创建、训练
    [IW, B, LW, TF, TYPE] = ELMtrain(P_train, T_train, 50*i, 'sig', 1);
    % ELM仿真测试
    T_sim_1 = ELMpredict(P_train, IW, B, LW, TF, TYPE);
    T_sim_2 = ELMpredict(P_test, IW, B, LW, TF, TYPE);
    % 结果对比
    % 训练集正确率
    k1 = length(find(T_train == T_sim_1));
    n1 = length(T_train);
    Accuracy_1 = k1 / n1 * 100;
    % 测试集正确率
    k2 = length(find(T_test == T_sim_2));
    n2 = length(T_test);
    Accuracy_2 = k2 / n2 * 100;
    R(i, :) = [Accuracy_1 Accuracy_2];
end
plot(50*(1 : 10), R(:, 2), 'b:o', 'LineWidth', 2)
xlabel('隐含层神经元个数')
ylabel('测试集预测正确率（%）')
title('隐含层神经元个数对ELM性能的影响')
