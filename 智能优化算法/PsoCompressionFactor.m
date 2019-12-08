function [xm, fv] = PsoCompressionFactor(fitness, N, c1, c2, Xmax, Xmin, Vmax, Vmin, IterMax, D)
% �������ܣ�ѹ����������Ⱥ�㷨��⺯����Сֵ����
% =======================================================================
% ���룺
%   fitness����Ӧ�Ⱥ��������
%   N����Ⱥ������
%   c1��ѧϰ����1����֪���֣�
%   c2��ѧϰ����2����Ჿ�֣�
%   Xmax��λ�����ֵ��
%   Xmin��λ����Сֵ��
%   Vmax���ٶ����ֵ��
%   Vmin���ٶ���Сֵ��
%   IterMax��������������
%   D������ά�ȣ�δ֪��������
% �����
%   xm���������Ž⣻
%   fv��������Сֵ��
% =======================================================================
phy = c1 + c2;
if phy <= 4
    disp('c1 �� c2 �� �� �� �� �� �� 4 ��');
    xm = NaN;
    fv = NaN;
    return;
end
lamda = 2 / abs(2 - phy - sqrt(phy^2 - 4 * phy));   % ѹ������
%%%%%%%%%%  ��ʼ����Ⱥ���壨�޶�λ�ú��ٶȣ� %%%%%%%%%
x = rand(N, D) .* repmat(Xmax - Xmin, N, 1) + repmat(Xmin, N, 1);
v = rand(N, D) * (Vmax - Vmin) + Vmin;
%%%%%%%%%%  ��ʼ����������λ�ú�����ֵ %%%%%%%%%
p = x;
pbest = ones(N, 1);
for i = 1 : N
   pbest(i) = fitness(x(i, :));
end
%%%%%%%%%%  ��ʼ��ȫ������λ�ú�����ֵ %%%%%%%%%
g = ones(1, D);
gbest = inf;
for i = 1 : N
   if pbest(i) < gbest
      g = p(i, :);
      gbest = pbest(i);
   end
end
%%%%%%%%%%  ���չ�ʽ���ε���ֱ�����㾫�Ȼ��ߵ������� %%%%%%%%%
for i = 1 : IterMax
   for j = 1 : N
      %%%%%%%%%%  ���¸�������λ�ú�����ֵ %%%%%%%%%
      if fitness(x(j, :)) < pbest(j)
         p(j, :) = x(j, :);
         pbest(j) = fitness(x(j, :));
      end
      %%%%%%%%%%  ����ȫ������λ�ú�����ֵ %%%%%%%%%
      if pbest(j) < gbest
         g = p(j, :);
         gbest = pbest(j);
      end
      %%%%%%%%%%  ����λ�ú��ٶ�ֵ %%%%%%%%%
      v(j, :) = lamda * v(j, :) + c1 * rand * (p(j, :) - x(j, :)) + c2 * rand * (g - x(j, :));
      x(j, :) = x(j, :) + v(j, :);
      %%%%%%%%%%  �߽��������� %%%%%%%%%
      for ii = 1 : D
         if (v(j, ii) > Vmax) || (v(j, ii) < Vmin)
            v(j, ii) = rand * (Vmax - Vmin) + Vmin;
         end
         if (x(j, ii) > Xmax(ii)) || (x(j, ii) < Xmin(ii))
            x(j, ii) = rand * (Xmax(ii) - Xmin(ii)) + Xmin(ii);
         end
      end
   end
end
xm = g;
fv = fitness(xm);