function x = LinearEquationsSolverSSOR(A, b, x0, w, MaxIters, err)
%{
�������ܣ��Գ��ɳڵ�����������Է����飻
���룺
  A��ϵ������
  b����������
  x0����ʼ�⣻
  w���ɳ����ӣ�0~1��
  MaxIters��������������
  err��������ֵ��
�����
  x�����ƽ⣻
ʾ����
clear; clc;
A = [1, 1, 1; 1, 2, 3; 2, 1, 3];
b = [3; 6; 6];
x0 = [0; 0; 0];
MaxIters = 1000;
err = 1e-6;
w = 0.5;
x1 = LinearEquationsSolverSSOR(A, b, x0, w, MaxIters, err);
x2 = A\b;   % Matlab���
%} 
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
if nargin < 6
   err = 1e-6;
end
if nargin < 5
   MaxIters = 1000;
end
if nargin < 4
   w = 0.5;
end
if nargin < 3
   error('����������㣡');
end
n = length(x0);
x1 = x0;
x2 = zeros(n, 1); 
x3 = zeros(n, 1);
r = max(abs(b - A*x1));
k = 0;
while r > err
    for i = 1 : n
        temp = 0;
        for j = 1 : n
            if j > i
                temp = temp + A(i, j) * x1(j);
            elseif j < i
                temp = temp + A(i, j) * x2(j);
            end
        end
        x2(i) = (1 - w)*x1(i) + w*(b(i) - temp) / (A(i, i) + eps);
    end
    for i = n : -1 : 1
        temp = 0;
        for j = 1 : n
            if j > i
                temp = temp + A(i, j) * x3(j);
            elseif j < i
                temp = temp + A(i, j) * x2(j);
            end
        end
        x3(i) = (1 - w) * x2(i) + w * (b(i) - temp) / A(i, i);
    end
    r = max(abs(x3 - x1));
    x1 = x3;
    k = k + 1;
    if k > MaxIters
        x = x1;
        return;
    end
end
x = x1;