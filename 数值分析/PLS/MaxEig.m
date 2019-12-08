function [Eigenvalue, Eigenvector] = MaxEig(A, tol)
%{
函数功能：计算由实数矩阵A构成的对称矩阵A'*A的最大特征值和对应的特征向量
输入：
  A：实数矩阵；
  tol：收敛精度，默认1e-6；
输出：
  Eigenvalue：最大特征值；
  Eigenvector：最大特征值对应的特征向量；
调用格式
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
% 最大二范数的列
[~, idx] = max(sum(B));
x = A(:, idx);
% 收敛性判断
x0 = x - x;
% 迭代
while norm(x - x0) > tol
    y = A'*x;            % 特征向量方向 
    y = y/norm(y);       % 归一化    
    x0 = x;              % 更新
    x = A*y;
end
s = x'*x;
Eigenvalue = s;
Eigenvector = y;