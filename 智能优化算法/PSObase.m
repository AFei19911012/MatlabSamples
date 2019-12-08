%%%%%%%%%%%%%  ����Ⱥ�㷨������ֵ %%%%%%%%%%%%%
clear; clc;
N = 200;              % Ⱥ�����Ӹ���
D = 2;                % ����ά��
T = 200;              % ����������
c1 = 1.5;             % ѧϰ����1  
c2 = 1.5;             % ѧϰ����2
wMax = 0.8;           % ����Ȩ�����ֵ
wMin = 0.4;           % ����Ȩ����Сֵ
xMax = [10, 10];        % λ�����ֵ
xMin =  [-10, -10];     % λ����Сֵ
vMax = 1;             % �ٶ����ֵ
vMin = -1;            % �ٶ���Сֵ
%%%%%%%%%%  ��ʼ����Ⱥ���壨�޶�λ�ú��ٶȣ� %%%%%%%%%
x = rand(N, D) .* repmat(xMax - xMin, N, 1) + repmat(xMin, N, 1);
v = rand(N, D) * (vMax - vMin) + vMin;
%%%%%%%%%%  ��ʼ����������λ�ú�����ֵ %%%%%%%%%
p = x;
pbest = ones(N, 1);
for i = 1 : N
   pbest(i) = ObjFun(x(i, :));
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
gb = ones(1, T);
%%%%%%%%%%  ���չ�ʽ���ε���ֱ�����㾫�Ȼ��ߵ������� %%%%%%%%%
for i = 1 : T
   for j = 1 : N
      %%%%%%%%%%  ���¸�������λ�ú�����ֵ %%%%%%%%%
      if ObjFun(x(j, :)) < pbest(j)
         p(j, :) = x(j, :);
         pbest(j) = ObjFun(x(j, :));
      end
      %%%%%%%%%%  ����ȫ������λ�ú�����ֵ %%%%%%%%%
      if pbest(j) < gbest
         g = p(j, :);
         gbest = pbest(j);
      end
      %%%%%%%%%%  ��̬�������Ȩ��ֵ %%%%%%%%%
      w = wMax - (wMax - wMin)*i/T;
%       w = Wmin + (Wmax - Wmin)*rand;
      %%%%%%%%%%  ����λ�ú��ٶ�ֵ %%%%%%%%%
      v(j, :) = w*v(j, :) + c1*rand*(p(j, :) - x(j, :)) + c2*rand*(g - x(j, :));
      x(j, :) = x(j, :) + v(j, :);
      %%%%%%%%%%  �߽��������� %%%%%%%%%
      for ii = 1:D
         if (v(j, ii) > vMax) || (v(j, ii) < vMin)
            v(j, ii) = rand*(vMax - vMin) + vMin;
         end
         if (x(j, ii) > xMax(ii)) || (x(j, ii) < xMin(ii))
            x(j, ii) = rand*(xMax(ii) - xMin(ii)) + xMin(ii);
         end
      end
   end
      %%%%%%%%%%  ��¼����ȫ������ֵ %%%%%%%%%
      gb(i) = gbest;
end
disp(['���Ÿ��壺' num2str(g)]);
disp(['����ֵ��' num2str(gb(end))]);
subplot(1, 2, 1)
plot(gb, 'LineWidth', 2);
xlabel('��������');
ylabel('��Ӧ��ֵ');
title('��Ӧ�Ƚ�������');
len = 50;
xRange = linspace(xMin(1), xMax(1), len);
yRange = linspace(xMin(2), xMax(2), len);
[xMap, yMap] = meshgrid(xRange, yRange);
zMap = zeros(len);
for i = 1 : len
    for j = 1 : len
        zMap(i, j) = ObjFun([xMap(i, j), yMap(i, j)]);
    end
end
subplot(1, 2, 2)
surf(xRange, yRange, zMap);
colorbar;
view(-45, -45);
shading interp
hold on
plot3(g(1), g(2), ObjFun(g), 'o', 'MarkerFaceColor', 'r', 'MarkerSize', 10);
hold off
set(gcf, 'Position', [400, 200, 900, 400]);