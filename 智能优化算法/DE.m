%%%%%%%%%%%%%  差分进化算法求函数极值 %%%%%%%%%%%%%
%%%%%%%%%%%%%  初始化 %%%%%%%%%%%%%
clear; clc;
NP = 50;          % 种群数量
D = 2;            % 变量维度
G = 500;          % 最大进化代数
F0 = 0.4;         % 初始变异算子
CR = 0.1;         % 交叉算子
Xs = 10;          % 上限
Xx = -10;         % 下限
yz = 1e-8;        % 阈值
%%%%%%%%%%%%%  赋初值 %%%%%%%%%%%%%
Ob = zeros(NP, 1);
Ob1 = zeros(NP, 1);
v = zeros(D, NP);         % 变异种群
u = zeros(D, NP);         % 选择种群
x = rand(D, NP) * (Xs - Xx) + Xx;  
%%%%%%%%%%%%%  计算目标函数 %%%%%%%%%%%%%
for m = 1 : NP
   Ob(m) = ObjFun(x(:, m));
end
%%%%%%%%%%%%%  差分进化循环 %%%%%%%%%%%%%
trace = zeros(G, 1);
trace(1) = min(Ob);
for gen = 1 : G
   %%%%%%%%%%%%%  变异操作 %%%%%%%%%%%%%
   %%%%%%%%%%%%%  自适应变异算子 %%%%%%%%%
   lamda = exp(1 - G / (G + 1 - gen));
   F = F0 * 2^lamda;
   %%%%%%%%%%  r1、r2、r3和m互不相同 %%%%%%%%%%
   for m = 1 : NP
      r1 = randi([1, NP], 1);
      while r1 == m
         r1 = randi([1, NP], 1);
      end
      r2 = randi([1, NP], 1);
      while r2 == m || r2 == r1
         r2 = randi([1, NP], 1);
      end
      r3 = randi([1, NP], 1);
      while r3 == m || r3 == r2 || r3 == r1
         r3 = randi([1, NP], 1);
      end
      v(:, m) = x(:, r1) + F*(x(:, r2) - x(:, r3));
   end
   %%%%%%%%%%%%%  交叉操作 %%%%%%%%%%%%%
   r = randi([1, D], 1);
   for n = 1 : D
      cr = rand;
      if cr <= CR || n == r
         u(n, :) = v(n, :);
      else
         u(n, :) = x(n, :);
      end
   end
   %%%%%%%%%%%%%  边界条件的处理 %%%%%%%%%%%%%
%    for n = 1:D
%       for m = 1:NP
%          if u(n, m) < Xx || u(n, m) > Xs
%             u(n, m) = rand*(Xs - Xx) + Xx;
%          end
%       end
%    end
   %%%%%%%%%%%%%  边界吸收 %%%%%%%%%%%%%
   for n = 1 : D
      for m = 1 : NP
         if u(n, m) < Xx
            u(n, m) = Xx;
         end
         if u(n, m) > Xs
            u(n, m) = Xs;
         end
      end
   end
   %%%%%%%%%%%%%  选择操作 %%%%%%%%%%%%%
   for m = 1 : NP
      Ob1(m) = ObjFun(u(:, m));
   end
   for m = 1 : NP
      if Ob1(m) < Ob(m)
         x(:, m) = u(:, m);
      end
   end
   for m = 1:NP
      Ob(m) = ObjFun(x(:, m));
   end
   trace(gen + 1) = min(Ob);
   if min(Ob) < yz
      break;
   end
end
[SortOb, Index] = sort(Ob);
x = x(:, Index);
X = x(:, 1);        % 最优变量
Y = min(Ob);        % 最优值
disp(['最优x：' num2str(X')]);
disp(['最优y：' num2str(Y)]);
subplot(1, 2, 1)
plot(trace, 'LineWidth', 2);
xlabel('迭代次数');
ylabel('适应度值');
title('适应度进化曲线');
len = 50;
xRange = linspace(Xx, Xs, len);
yRange = linspace(Xx, Xs, len);
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
plot3(X(1), X(2), Y, 'o', 'MarkerFaceColor', 'r', 'MarkerSize', 10);
hold off
set(gcf, 'Position', [400, 200, 900, 400]);