function [Q, R] = QRHouseholder(A)
% ����Householder�任��������A�ֽ�ΪA = QR������QΪ��������RΪ��������
%
% ����˵��
% A����Ҫ����QR�ֽ�ķ���
% Q���ֽ�õ�����������
% R���ֽ�õ�����������
%{
% ʵ��˵��
clear; clc;
A=[-12, 3, 3; 3, 1, -2; 3, -2, 7];
[Q, R] = qr(A)                % ����MATLAB�Դ���QR�ֽ⺯��������֤
[q, r] = QRHouseholder(A)     % ���ñ���������QR�ֽ�
q*r - A     % ��֤ A = QR
q'*q      % ��֤ q ��������
norm(q) % ��֤q�ı�׼����������������1
%} 
% ���Դ�������֪ʶ
% 1. B = P*A*inv(P)����A��B���ƣ����ƾ��������ͬ������ֵ
% 2. Q*Q' = I����QΪ����������������ĳ˻���Ϊ��������
%
n = size(A, 1);
R = A;
Q = eye(n);
for i = 1 : n - 1
    x = R(i : n, i);
    y = [1; zeros(n - i, 1)];
    Ht = Householder(x, y);
    H = blkdiag(eye(i - 1), Ht);
    Q = Q * H;
    R = H * R;
end

function [H, rho] = Householder(x, y)
% ��������ԳƵ�Householder ����H��ʹHx=rho*y������rho=-sign(x(1))*||x||/||y||
% ����˵��
% x��������
% y����������x ��y ���������ͬ��ά��
% ���� HouseHolder �任
% 1. H=I-2vv'������||v||=1�����ǳ�H Ϊ����(HouseHolder)������֤H �Գ�������
% 2. ���||x||=||y||����ô����HouseHolder ����H=I-2vv������v=��(x-y)/||x-y||��ʹHx=y
% 3. ���||x||��||y||����ô����HouseHolder ����H��ʹHx=rho*y������rho=-sign(x(1))*||x||/||y||
% 4. Householder ���󣬳����ڽ�һ������A ͨ�������任�Խ���
x = x(:);
y = y(:);
if length(x) ~= length(y)
    error('The Column Vectors X and Y Must Have The Same Length!');
end
rho = -sign(x(1)) * norm(x) / norm(y);
y = rho * y;
v = (x - y) / norm(x - y);
I = eye(length(x));
H = I - 2 * (v*v');