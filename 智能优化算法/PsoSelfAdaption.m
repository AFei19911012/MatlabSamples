function [xm, fv] = PsoSelfAdaption(fitness, N, c1, c2, Xmax, Xmin, Vmax, Vmin, Wmax, Wmin, IterMax, D)
% 函数功能：自适应权重粒子群算法求解函数极小值问题
% =======================================================================
% 输入：
%   fitness：适应度函数句柄；
%   N：种群个数；
%   c1：学习因子1，认知部分；
%   c2：学习因子2，社会部分；
%   Xmax：位置最大值；
%   Xmin：位置最小值；
%   Vmax：速度最大值；
%   Vmin：速度最小值；
%   Wmax：权重最大值；
%   Wmin：权重最小值；
%   IterMax：最大迭代次数；
%   D：例子维度，未知数个数；
% 输出：
%   xm：函数最优解；
%   fv：函数最小值；
% =======================================================================
%%%%%%%%%%  初始化种群个体（限定位置和速度） %%%%%%%%%
x = rand(N, D) .* repmat(Xmax - Xmin, N, 1) + repmat(Xmin, N, 1);
v = rand(N, D) * (Vmax - Vmin) + Vmin;
%%%%%%%%%%  初始化个体最优位置和最优值 %%%%%%%%%
p = x;
pbest = ones(N, 1);
for i = 1 : N
   pbest(i) = fitness(x(i, :));
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
%%%%%%%%%%  按照公式依次迭代直到满足精度或者迭代次数 %%%%%%%%%
fvTemp = zeros(1, N);
for i = 1 : IterMax
   for j = 1 : N 
       fvTemp(j) = fitness(x(j, :));
   end
   fvag = mean(fvTemp);
   fmin = min(fvTemp);
   for j = 1 : N
       %%%%%%%%%%  自适应权重 %%%%%%%%%
      if fvTemp(j) <= fvag
          W = Wmin + (fvTemp(j) - fmin) * (Wmax - Wmin) / (fvag - fmin);
      else
          W = Wmax;
      end
      %%%%%%%%%%  更新个体最优位置和最优值 %%%%%%%%%
      if fitness(x(j, :)) < pbest(j)
         p(j, :) = x(j, :);
         pbest(j) = fitness(x(j, :));
      end
      %%%%%%%%%%  更新全局最优位置和最优值 %%%%%%%%%
      if pbest(j) < gbest
         g = p(j, :);
         gbest = pbest(j);
      end
      %%%%%%%%%%  更新位置和速度值 %%%%%%%%%
      v(j, :) = W * v(j, :) + c1 * rand * (p(j, :) - x(j, :)) + c2 * rand * (g - x(j, :));
      x(j, :) = x(j, :) + v(j, :);
      %%%%%%%%%%  边界条件处理 %%%%%%%%%
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


