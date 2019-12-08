% ����Ϊ[1 -1 1]'��ϣ�������Ϊ[1 1]'
clear; clc;
% ���� BP �㷨�ĵ�һ�׶Ρ�ѧϰ�ڣ�ѵ����Ȩϵ�� Wki��Wij��
% ��ʼ��
lr = 0.05;        % ѧϰ���ʣ�
err_goal = 1e-3;  % ���������Сֵ
max_epoch = 1000; % ѵ����������
alpha = 0.9;   % ����ϵ��
% �ṩһ��ѵ������Ŀ��ֵ��3����2�����
X = [1; -1; 1];
T = [1; 1];
M = 3;  % �����
q = 8;  % ������
L = 2;  % �����
rng('default');
Wij = rand(q, M);
Wki = rand(L, q);
Wij0 = zeros(size(Wij));
Wki0 = zeros(size(Wki));
Oi = zeros(q, 1);     % ���������Ԫ���
Ok = zeros(L, 1);     % ��������Ԫ���
for epoch = 1 : max_epoch
    % �������������Ԫ���
    NETi = Wij * X;
    for i = 1 : q
        Oi(i) = 2 / (1 + exp(-NETi(i))) - 1;  % �����
    end
    % ������������Ԫ���
    NETk = Wki * Oi;
    for k = 1 : L
        Ok(k) = 2 / (1 + exp(-NETk(k))) - 1;
    end
    %��������
    E = norm(T - Ok);
    if E < err_goal
        break;
    end
    % ����������Ȩϵ��
    deltak = Ok .* (1 - Ok).*(T - Ok);
    W = Wki;
    Wki = Wki + lr*deltak * Oi' + alpha * (Wki - Wki0);   % �ӹ���ϵ��
    Wki0 = W;
    % �����������Ȩϵ��
    deltai = Oi .* (1 - Oi) .* (deltak' * Wki)';
    W = Wij;
    Wij = Wij + lr * deltai * X' + alpha * (Wij - Wij0);
    Wij0 = W;
end
% BP �㷨�ĵڶ��׶Ρ������ڣ�����ѵ���õ�Wki��Wij�͸�����������������
X1 = X;    % ��������
% �������������Ԫ���
NETi = Wij * X1;
for i = 1 : q
    Oi(i) = 2/(1 + exp(-NETi(i))) - 1;
end
% ������������Ԫ���
NETk = Wki * Oi;
for k = 1 : L
    Ok(k) = 2/(1 + exp(-NETk(k))) - 1;
end
disp(epoch);   % ��ʾ�������
disp(Ok);      % ��ʾ�������������