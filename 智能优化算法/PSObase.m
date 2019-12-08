%%%%%%%%%%%%%  粒子群算法求函数极值 %%%%%%%%%%%%%
clear; clc;
N = 200;              % 群体例子个数
D = 2;                % 粒子维度
T = 200;              % 最大迭代次数
c1 = 1.5;             % 学习因子1  
c2 = 1.5;             % 学习因子2
wMax = 0.8;           % 惯性权重最大值
wMin = 0.4;           % 惯性权重最小值
xMax = [10, 10];        % 位置最大值
xMin =  [-10, -10];     % 位置最小值
vMax = 1;             % 速度最大值
vMin = -1;            % 速度最小值
%%%%%%%%%%  初始化种群个体（限定位置和速度） %%%%%%%%%
x = rand(N, D) .* repmat(xMax - xMin, N, 1) + repmat(xMin, N, 1);
v = rand(N, D) * (vMax - vMin) + vMin;
%%%%%%%%%%  初始化个体最优位置和最优值 %%%%%%%%%
p = x;
pbest = ones(N, 1);
for i = 1 : N
   pbest(i) = ObjFun(x(i, :));
end
%%%%%%%%%%  初始化全局最优位置和最优值 %%%%%%%%%
g = ones(1, D);
gbest = inf;
for i = 1 : N
   if pbest(i) < gbest
      g = p(i, :);
      gbest = pbest(i);
   end
end
gb = ones(1, T);
%%%%%%%%%%  按照公式依次迭代直到满足精度或者迭代次数 %%%%%%%%%
for i = 1 : T
   for j = 1 : N
      %%%%%%%%%%  更新个体最优位置和最优值 %%%%%%%%%
      if ObjFun(x(j, :)) < pbest(j)
         p(j, :) = x(j, :);
         pbest(j) = ObjFun(x(j, :));
      end
      %%%%%%%%%%  更新全局最优位置和最优值 %%%%%%%%%
      if pbest(j) < gbest
         g = p(j, :);
         gbest = pbest(j);
      end
      %%%%%%%%%%  动态计算惯性权重值 %%%%%%%%%
      w = wMax - (wMax - wMin)*i/T;
%       w = Wmin + (Wmax - Wmin)*rand;
      %%%%%%%%%%  更新位置和速度值 %%%%%%%%%
      v(j, :) = w*v(j, :) + c1*rand*(p(j, :) - x(j, :)) + c2*rand*(g - x(j, :));
      x(j, :) = x(j, :) + v(j, :);
      %%%%%%%%%%  边界条件处理 %%%%%%%%%
      for ii = 1:D
         if (v(j, ii) > vMax) || (v(j, ii) < vMin)
            v(j, ii) = rand*(vMax - vMin) + vMin;
         end
         if (x(j, ii) > xMax(ii)) || (x(j, ii) < xMin(ii))
            x(j, ii) = rand*(xMax(ii) - xMin(ii)) + xMin(ii);
         end
      end
   end
      %%%%%%%%%%  记录历代全局最优值 %%%%%%%%%
      gb(i) = gbest;
end
disp(['最优个体：' num2str(g)]);
disp(['最优值：' num2str(gb(end))]);
subplot(1, 2, 1)
plot(gb, 'LineWidth', 2);
xlabel('迭代次数');
ylabel('适应度值');
title('适应度进化曲线');
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