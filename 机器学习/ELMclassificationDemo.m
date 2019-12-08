% ����ѧϰ��(Extreme Learning Machine, ELM)�ڷ��������е�Ӧ���о�
clear; clc;
% ��������
load data_classification.mat data
% �������ѵ���������Լ�
rng('default');
a = randperm(569);
% ѵ������500������
Train = data(a(1 : 500), :);
% ���Լ���69������
Test = data(a(501 : end), :);
% ѵ������
P_train = Train(:, 3 : end)';
T_train = Train(:, 2)';
% ��������
P_test = Test(:, 3 : end)';
T_test = Test(:, 2)';
% ELM
%  ELM������ѵ��
[IW, B, LW, TF, TYPE] = ELMtrain(P_train, T_train, 100, 'sig', 1);
% ELM�������
T_sim_1 = ELMpredict(P_train, IW, B, LW, TF, TYPE);
T_sim_2 = ELMpredict(P_test, IW, B, LW, TF, TYPE);
% ����Ա�
% ѵ������ȷ��
k1 = length(find(T_train == T_sim_1));
n1 = length(T_train);
Accuracy_1 = k1 / n1 * 100;
disp(['ѵ������ȷ��Accuracy = ' num2str(Accuracy_1) '%(' num2str(k1) '/' num2str(n1) ')'])
% ���Լ���ȷ��
k2 = length(find(T_test == T_sim_2));
n2 = length(T_test);
Accuracy_2 = k2 / n2 * 100;
disp(['���Լ���ȷ��Accuracy = ' num2str(Accuracy_2) '%(' num2str(k2) '/' num2str(n2) ')'])
% ��ʾ
count_B = length(find(T_train == 1));
count_M = length(find(T_train == 2));
total_B = length(find(data(:,2) == 1));
total_M = length(find(data(:,2) == 2));
number_B = length(find(T_test == 1));
number_M = length(find(T_test == 2));
number_B_sim = length(find(T_sim_2 == 1 & T_test == 1));
number_M_sim = length(find(T_sim_2 == 2 & T_test == 2));
disp(['����������' num2str(569)  '  ���ԣ�' num2str(total_B)  '  ���ԣ�' num2str(total_M)]);
disp(['ѵ��������������' num2str(500) '  ���ԣ�' num2str(count_B) '  ���ԣ�' num2str(count_M)]);
disp(['���Լ�����������' num2str(69) '  ���ԣ�' num2str(number_B) '  ���ԣ�' num2str(number_M)]);
disp(['������������ȷ�' num2str(number_B_sim) '  ���' num2str(number_B - number_B_sim) '  ȷ����p1=' num2str(number_B_sim/number_B*100) '%']);
disp(['������������ȷ�' num2str(number_M_sim) '  ���' num2str(number_M - number_M_sim) '  ȷ����p2=' num2str(number_M_sim/number_M*100) '%']);
%  ��������Ԫ����Ӱ��
R = zeros(10, 2);
for i = 1 : 10
    % ELM������ѵ��
    [IW, B, LW, TF, TYPE] = ELMtrain(P_train, T_train, 50*i, 'sig', 1);
    % ELM�������
    T_sim_1 = ELMpredict(P_train, IW, B, LW, TF, TYPE);
    T_sim_2 = ELMpredict(P_test, IW, B, LW, TF, TYPE);
    % ����Ա�
    % ѵ������ȷ��
    k1 = length(find(T_train == T_sim_1));
    n1 = length(T_train);
    Accuracy_1 = k1 / n1 * 100;
    % ���Լ���ȷ��
    k2 = length(find(T_test == T_sim_2));
    n2 = length(T_test);
    Accuracy_2 = k2 / n2 * 100;
    R(i, :) = [Accuracy_1 Accuracy_2];
end
plot(50*(1 : 10), R(:, 2), 'b:o', 'LineWidth', 2)
xlabel('��������Ԫ����')
ylabel('���Լ�Ԥ����ȷ�ʣ�%��')
title('��������Ԫ������ELM���ܵ�Ӱ��')
