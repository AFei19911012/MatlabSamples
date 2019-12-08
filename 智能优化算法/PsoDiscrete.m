%%%%%%%%%%%%%  ��ɢ����Ⱥ�㷨������ֵ %%%%%%%%%%%%%
clear;clc;
N = 100;            % Ⱥ�����Ӹ���
D = 20;             % ����ά��
T = 200;            % ����������
c1 = 1.5;           % ѧϰ����1  
c2 = 1.5;           % ѧϰ����2
wMax = 0.8;         % ����Ȩ�����ֵ
wMin = 0.4;         % ����Ȩ����Сֵ
xMax = 9;           % λ�����ֵ
xMin =  0;          % λ����Сֵ
vMax = 10;          % �ٶ����ֵ
vMin = -10;         % �ٶ���Сֵ
%%%%%%%%%%  ��ʼ����Ⱥ���壨�޶�λ�ú��ٶȣ� %%%%%%%%%
x = randi([0, 1], N, D);   % �����ö����Ʊ���ĳ�ʼ��Ⱥ
v = rand(N, D) * (vMax - vMin) + vMin;
%%%%%%%%%%  ��ʼ����������λ�ú�����ֵ %%%%%%%%%
p = x;
pbest = ones(N, 1);
for i = 1:N
   pbest(i) = ObjFunDiscrete(x(i, :), xMax, xMin);
end
%%%%%%%%%%  ��ʼ��ȫ������λ�ú�����ֵ %%%%%%%%%
g = ones(1, D);
gbest = inf;
for i = 1:N
   if pbest(i) < gbest
      g = p(i, :);
      gbest = pbest(i);
   end
end
gb = ones(1, T);
vx = zeros(N, D);
%%%%%%%%%%  ���չ�ʽ���ε���ֱ�����㾫�Ȼ��ߵ������� %%%%%%%%%
for i = 1:T
   for j = 1:N
      %%%%%%%%%%  ���¸�������λ�ú�����ֵ %%%%%%%%%
      if ObjFunDiscrete(x(j, :), xMax, xMin) < pbest(j)
         p(j, :) = x(j, :);
         pbest(j) = ObjFunDiscrete(x(j, :), xMax, xMin);
      end
      %%%%%%%%%%  ����ȫ������λ�ú�����ֵ %%%%%%%%%
      if pbest(j) < gbest
         g = p(j, :);
         gbest = pbest(j);
      end
      %%%%%%%%%%  ��̬�������Ȩ��ֵ %%%%%%%%%
      w = wMax - (wMax - wMin) * i / T;
      %%%%%%%%%%  ����λ�ú��ٶ�ֵ %%%%%%%%%
      v(j, :) = w * v(j, :) + c1 * rand * (p(j, :) - x(j, :)) + c2 * rand * (g - x(j, :));
      x(j, :) = x(j, :) + v(j, :);
      %%%%%%%%%%  �߽��������� %%%%%%%%%
      for ii = 1:D
         if (v(j, ii) > vMax) || (v(j, ii) < vMin)
            v(j, ii) = rand * (vMax - vMin) + vMin;
         end
      end
      vx(j, :) = 1 ./ (1 + exp(-v(j, :)));
      for jj = 1 : D
         if vx(j, jj) > rand
            x(j, jj) = 1;
         else
            x(j, jj) = 0;
         end
      end
   end
      %%%%%%%%%%  ��¼����ȫ������ֵ %%%%%%%%%
      gb(i) = gbest;
end
m = 0;
for j = 1:D
   m = m + g(j) * 2^(j - 1);
end
f1 = xMin + m * (xMax - xMin)/(2^D - 1);
disp(['���Ÿ��壺' num2str(f1)]);
disp(['����ֵ��' num2str(gb(end))]);
subplot(1, 2, 1);
plot(gb, 'LineWidth', 2);
xlabel('��������');
ylabel('��Ӧ��ֵ');
title('��Ӧ�Ƚ�������');
subplot(1, 2, 2)
xRange = linspace(xMin, xMax, 100);
yRange = xRange + 6 * sin(4 * xRange) + 9 * cos(5 * xRange);
plot(xRange, yRange, 'LineWidth', 2);
hold on;
plot(f1, gb(end),'o', 'MarkerFaceColor', 'r', 'MarkerSize', 10);
hold off;
set(gcf, 'Position', [400, 200, 900, 400]);