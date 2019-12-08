% ����ѧϰ��(Extreme Learning Machine, ELM)�ڻع���������е�Ӧ���о�
clear; clc;
% ��������
load data_regression.mat  input output
% �������ѵ���������Լ�
k = randperm(size(input,1));
% ѵ������1900������
P_train = input(k(1 : 1900), :)';
T_train = output(k(1 : 1900));
% ���Լ���100������
P_test = input(k(1901 : 2000),:)';
T_test = output(k(1901 : 2000));
% ELM
% ��һ��
% ѵ����
[Pn_train, inputps] = mapminmax(P_train, -1, 1);
Pn_test = mapminmax('apply', P_test, inputps);
% ���Լ�
[Tn_train, outputps] = mapminmax(T_train, -1, 1);
% ELM������ѵ��
[IW, B, LW, TF, TYPE] = ELMtrain(Pn_train, Tn_train, 20, 'sig', 0);
% ELM�������
Tn_sim = ELMpredict(Pn_test, IW, B, LW, TF, TYPE);
% ����һ��
T_sim = mapminmax('reverse', Tn_sim, outputps);
% ����Ա�
% �������
E = mse(T_sim - T_test);
disp(['������', num2str(E)]);
% ����ϵ��
N = length(T_test);
% r2 = corrcoef(T_sim, T_test);
% R2 = r2(1, 2);
R2 = (N*sum(T_sim .* T_test) - sum(T_sim) * sum(T_test))^2 / ...
         ((N*sum((T_sim) .^ 2) - (sum(T_sim))^2) * (N*sum((T_test) .^2 ) - (sum(T_test))^2));
disp(['����ϵ����', num2str(R2)]);
% ��ͼ
subplot(2, 1, 1)
plot(T_test, 'r*', 'LineWidth', 2)
hold on
plot(T_sim, 'b:o', 'LineWidth', 2)
hold off
xlabel('���Լ��������')
ylabel('���Լ����')
title('ELM���Լ����')
legend('�������', 'Ԥ�����')
subplot(2, 1, 2)
plot(T_test - T_sim, 'r-*', 'LineWidth', 2)
xlabel('���Լ��������')
ylabel('�������')
title('ELM���Լ�Ԥ�����')