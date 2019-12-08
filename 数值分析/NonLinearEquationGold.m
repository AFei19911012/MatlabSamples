function root = NonLinearEquationGold(fun, a, b, err)
%{
�������ܣ��ƽ�ָ�������Է��̵ĸ���
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
root = NonLinearEquationGold(fun, 3, 4, 1e-6)
fplot(fun, [3, 4]);
hold on
plot([3, 4], [0, 0], root, fun(root), 'p');
hold off
%} 
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
if nargin < 4
   err = 1e-6;   % Ĭ�Ͼ���
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
if fun(a) * fun(b) > 0
   disp('���˵㺯��ֵ�˻�����0���޽⣡');
   return;
else
   x1 = a + 0.382*(b - a);
   x2 = a + 0.618*(b - a);
   f1 = fun(x1);
   f2 = fun(x2);
   while abs(b - a) > err        %  ���ƾ���
      if f1 * f2 < 0             %  �������˵㶼����
         a = x1;
         b = x2;
      else
         fa = fun(a);
         if f1 * fa > 0          %  ��˵�a��x1֮��û�и���������˵��ֵ
            a = x2;
         else
            b = x1;              %  ��˵�a��x1֮���и��������Ҷ˵��ֵ
         end
      end
      x1 = a + 0.382 * (b - a);
      x2 = a + 0.618 * (b - a);
      f1 = fun(x1);
      f2 = fun(x2);  
   end
   root = (b + a) / 2;       % �����   
end