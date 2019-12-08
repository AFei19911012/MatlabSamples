function [Eigenvalue, Eigenvector] = MaxEig(A, tol)
%{
�������ܣ�������ʵ������A���ɵĶԳƾ���A'*A���������ֵ�Ͷ�Ӧ����������
���룺
  A��ʵ������
  tol���������ȣ�Ĭ��1e-6��
�����
  Eigenvalue���������ֵ��
  Eigenvector���������ֵ��Ӧ������������
���ø�ʽ
clear; clc;
A = rand(5, 3);
tol = 1e-6;
[Eigenvalue, Eigenvector] = MaxEig(A, tol);
B = A'*A;
[V, D] = eig(B);
[d, idx] = max(diag(D));
disp(norm(min(Eigenvalue - d, Eigenvalue + d)));
disp(norm(min(Eigenvector - V(:, idx), Eigenvector + V(:, idx))));
%}
% ================================================================
if nargin < 2
    tol = 1e-6;
end
B = A'*A;
% ������������
[~, idx] = max(sum(B));
x = A(:, idx);
% �������ж�
x0 = x - x;
% ����
while norm(x - x0) > tol
    y = A'*x;            % ������������ 
    y = y/norm(y);       % ��һ��    
    x0 = x;              % ����
    x = A*y;
end
s = x'*x;
Eigenvalue = s;
Eigenvector = y;