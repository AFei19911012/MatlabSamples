function root = NonLinearEquationHalf(fun, a, b, err)
%{
�������ܣ����ַ��������Է��̵ĸ���
���룺
  fun�����̾����
  a�������������ޣ�
  b���Ѷ��������ޣ�
  err��������ֵ��
�����
  root�����ƽ⣻
ʾ����
clear; clc;
fun = @(x) x + 6 * sin(4 * x) + 9 * cos(5 * x);
root = NonLinearEquationHalf(fun, 3, 4, 1e-6)
fplot(fun, [3, 4]);
hold on
plot([3, 4], [0, 0], root, fun(root), 'p');
hold off
%} 
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
if nargin < 4
   err = 1e-6;  % Ĭ�Ͼ���
end
if nargin < 3
   error('����������㣡');
end
% ��ʼ���
root = NaN;   %  ���ط���
if fun(a) == 0
   root = a;
end;
if fun(b) == 0
   root = b;
end
if fun(a)*fun(b) > 0
   disp('���˵㺯��ֵ�˻�����0���޽⣡');
   return;
else 
   root = FindRoot(fun, a, b, err);
end

function r = FindRoot(fun, a, b, err)
fa = fun(a);
x = 0.5 * (a + b);
fx = fun(x);
if fa * fx > 0                     % a ���е�֮��û�и�
   t = 0.5 * (a + b);
   r = FindRoot(fun, t, b, err);
else
   if fa * fx == 0
      r = 0.5 * (a + b);           % �����
   else
      if abs(b - a) <= err
         r = 0.25 * (b + 3 * a);
      else                         % a���е�֮���и�  
         s = 0.5 * (a + b);
         r = FindRoot(fun, a, s, err);
      end
   end
end  