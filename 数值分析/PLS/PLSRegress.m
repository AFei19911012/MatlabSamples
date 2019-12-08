function [sol, yhat] = PLSRegress(x, y)
% �������ܣ�ƫ��С���˻ع�
% =============================================================
% ���룺
%   x���Ա�����
%   y���������
% �����
%   sol���ع�ϵ����ÿһ����һ���ع鷽�̣��ҵ�һ��Ԫ���ǳ����
%   yhat�����ֵ
% ���ø�ʽ��
%{
clear;clc;
% x = [4 9 6 7 7 8 3 2;6 15 10 15 17 22 9 4;8 21 14 23 27 36 15 6;
% 10 21 14 13 11 10 3 4; 12 27 18 21 21 24 9 6; 14 33 22 29 31 38 15 8;
% 16 33 22 19 15 12 3 6; 18 39 26 27 25 26 9 8;20 45 30 35 35 40 15 10];
% y = [1 1;3 1;5 1;1 3;3 3;5 3;1 5;3 5;5 5];
% pz = load('pz3_3.txt');
% x = pz(:, 1:3);
% y = pz(:, 4:6);
pz = load('zdj10_1.txt');
x = pz(:, 1:10);
y = pz(:, 1);
[sol, yhat] = PLSRegress(x, y);
bar([y(:, 1), yhat(:, 1)]);
%}
% =============================================================
[rX, n] = size(x);           % �Ա�������
[rY, m] = size(y);           % ���������
assert(rX == rY, 'x��y�ĺ���ά�Ȳ�һ�£�');
%%% ��׼������
xmean = mean(x);    % ÿһ�о�ֵ
xstd = std(x);      % ÿһ�б�׼��
ymean = mean(y);    % ÿһ�о�ֵ
ystd = std(y);      % ÿһ�б�׼��
e0 = (x - xmean(ones(rX, 1), :)) ./ xstd(ones(rX, 1), :);
f0 = (y - ymean(ones(rY, 1), :)) ./ ystd(ones(rY, 1), :);
%%% ��������
chg = eye(n);          % w��w*�任����ĳ�ʼ��
w = zeros(n, n);
w_star = zeros(n, n);
t = zeros(rX, n);
ss = zeros(1, n);
press_i = zeros(1, rX);
press = zeros(1, n);
Q_h2 = zeros(1, n);
for i = 1:n
    % ���¼���w��w*��t�ĵ÷�����
    % ��ȡ�������ֵ�Ͷ�Ӧ����������
    w(:, i) = MaxEig(f0'*e0);
    w_star(:, i) = chg * w(:, i);             % ����w*��ȡֵ
    t(:, i) = e0*w(:, i);                     % ����ɷ�ti�ĵ÷�
    alpha = e0'*t(:, i)/(t(:, i)'*t(:, i));   % ����alpha_i
    chg = chg*(eye(n) - w(:, i)*alpha');      % ����w��w*�ı任����
    e = e0 - t(:, i)*alpha';                  % ����в�
    e0 = e;
    % ���¼���ss(i)��ֵ
    beta = SolveEquations([t(:, 1:i), ones(rX, 1)], f0); % ��ع鷽�̵�ϵ��
%     beta = [t(:, 1:i), ones(rX, 1)] \ f0;     % ��ع鷽�̵�ϵ��
    beta(end, :) = [];                        % ɾ���ع�����ĳ�����
    cancha = f0 - t(:, 1:i)*beta;             % �в�
    ss(i) = norm(cancha)^2;                   % ���ƽ����
    % ���¼���press(i)
    for j = 1:rX
        t1 = t(:, 1:i);
        f1 = f0;
        she_t = t1(j, :);               % ������ȥ�ĵ�j��������
        she_f = f1(j, :);
        t1(j, :) = [];                  % ɾ����j���۲�ֵ
        f1(j, :) = [];
        beta1 = SolveEquations([t1, ones(rX - 1, 1)], f1); % ��ع鷽�̵�ϵ��
%         beta1 = [t1, ones(rX - 1, 1)]\f1;  % ��ع������ϵ��
        beta1(end, :) = [];                % ɾ���ع�����ĳ�����
        cancha = she_f - she_t * beta1;      % �в�
        press_i(j) = norm(cancha)^2;             
    end
    press(i) = sum(press_i);
    if i > 1
        Q_h2(i) = 1 - press(i) / ss(i - 1);
    else
        Q_h2(i) = 1;
    end
    if Q_h2(i) < 0.0975
        fprintf('����ĳɷָ���r = %d\n', i);
        r = i;
        break;
    end
end
beta_z = SolveEquations([t(:, 1:r), ones(rX, 1)], f0);  % ��Y����t�Ļع�ϵ��
% beta_z = [t(:, 1:r), ones(rX, 1)]\f0;   % ��Y����t�Ļع�ϵ��
beta_z(end, :) = [];                      % ɾ��������
xishu = w_star(:, 1:r) * beta_z;          % ��Y���ڱ�׼����X�Ļع�ϵ����ÿһ����һ���ع鷽��
% ����ԭʼ���ݵĻع鷽�̵ĳ�����
ch0 = zeros(1, m);
for i = 1:m
    ch0(i) = ymean(i) - xmean ./ xstd * ystd(i) * xishu(:, i);    
end
% ����ԭʼ���ݵĻع鷽�̵�ϵ����ÿһ����һ���ع鷽��
xish = zeros(n, m);
for i = 1:m
    xish(:, i) = xishu(:, i) ./ xstd' * ystd(i);    
end
sol = [ch0; xish];    
yhat = [ones(size(x, 1), 1), x] * sol;
end