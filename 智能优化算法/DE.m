%%%%%%%%%%%%%  ��ֽ����㷨������ֵ %%%%%%%%%%%%%
%%%%%%%%%%%%%  ��ʼ�� %%%%%%%%%%%%%
clear; clc;
NP = 50;          % ��Ⱥ����
D = 2;            % ����ά��
G = 500;          % ����������
F0 = 0.4;         % ��ʼ��������
CR = 0.1;         % ��������
Xs = 10;          % ����
Xx = -10;         % ����
yz = 1e-8;        % ��ֵ
%%%%%%%%%%%%%  ����ֵ %%%%%%%%%%%%%
Ob = zeros(NP, 1);
Ob1 = zeros(NP, 1);
v = zeros(D, NP);         % ������Ⱥ
u = zeros(D, NP);         % ѡ����Ⱥ
x = rand(D, NP) * (Xs - Xx) + Xx;  
%%%%%%%%%%%%%  ����Ŀ�꺯�� %%%%%%%%%%%%%
for m = 1 : NP
   Ob(m) = ObjFun(x(:, m));
end
%%%%%%%%%%%%%  ��ֽ���ѭ�� %%%%%%%%%%%%%
trace = zeros(G, 1);
trace(1) = min(Ob);
for gen = 1 : G
   %%%%%%%%%%%%%  ������� %%%%%%%%%%%%%
   %%%%%%%%%%%%%  ����Ӧ�������� %%%%%%%%%
   lamda = exp(1 - G / (G + 1 - gen));
   F = F0 * 2^lamda;
   %%%%%%%%%%  r1��r2��r3��m������ͬ %%%%%%%%%%
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
   %%%%%%%%%%%%%  ������� %%%%%%%%%%%%%
   r = randi([1, D], 1);
   for n = 1 : D
      cr = rand;
      if cr <= CR || n == r
         u(n, :) = v(n, :);
      else
         u(n, :) = x(n, :);
      end
   end
   %%%%%%%%%%%%%  �߽������Ĵ��� %%%%%%%%%%%%%
%    for n = 1:D
%       for m = 1:NP
%          if u(n, m) < Xx || u(n, m) > Xs
%             u(n, m) = rand*(Xs - Xx) + Xx;
%          end
%       end
%    end
   %%%%%%%%%%%%%  �߽����� %%%%%%%%%%%%%
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
   %%%%%%%%%%%%%  ѡ����� %%%%%%%%%%%%%
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
X = x(:, 1);        % ���ű���
Y = min(Ob);        % ����ֵ
disp(['����x��' num2str(X')]);
disp(['����y��' num2str(Y)]);
subplot(1, 2, 1)
plot(trace, 'LineWidth', 2);
xlabel('��������');
ylabel('��Ӧ��ֵ');
title('��Ӧ�Ƚ�������');
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