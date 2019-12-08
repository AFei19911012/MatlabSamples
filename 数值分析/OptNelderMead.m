function xo = OptNelderMead(func, x0, TolX, TolFun, MaxIter)
%{
函数功能：单纯形法求解多维无约束问题:  min f(x)；
输入：
  func：函数句柄；
  x0：初始点；
  TolX：x 精度阈值；
  TolFun：y 精度阈值；
  MaxIter：最大迭代次数；
输出：
  xo：最小值点；
调用格式：
  clear; clc;
  func = @(x) x(1)^2 + (x(2) - 1)^2 + (x(3) - 2)^2 + (x(4) - 3)^2;
  x = OptNelderMead(func, [0 0 0 0], 1e-6, 1e-8, 1000)
%}
if nargin < 5
    MaxIter = 1000;
end
if nargin < 4
    TolFun = 1e-8;
end
if nargin < 3
    TolX = 1e-6;
end
if nargin < 2
    error('输入参数不足!');
end
% 初始情况
N = length(x0);
if N == 1   %  一维情况，退出
    xo = [];
    return
end
S = eye(N);
for i = 1 : N     % 自变量维数大于2时，重复计算每个子平面的情况
    i1 = i + 1;
    if i1 > N
        i1 = 1;
    end
    abc = [x0; x0 + S(i,:); x0 + S(i1,:)];    % 每一个定向子平面
    fabc = [func(abc(1, :)); func(abc(2, :)); func(abc(3, :))];
    x0 = Nelder0(func, abc, fabc, TolX, TolFun, MaxIter);
    if N < 3     % 二维情况不需重复
        break;
    end 
end
xo = x0;
end

function xo = Nelder0(func, abc, fabc, TolX, TolFun, MaxIter)
% 二维空间中的多边形逼近
if nargin < 6
    MaxIter = 100;
end
if nargin < 5
    TolFun = 1e-8;
end
if nargin < 4
    TolX = 1e-6;
end
%  确定三个顶点a，b，c并且其函数值按从小到大排列
[fabc, I] = sort(fabc);  % 将二维空间中的多边形三个顶点的函数值按从小到大顺序排列
a = abc(I(1), :);
b = abc(I(2), :); 
c = abc(I(3), :);
fa = fabc(1); 
fb = fabc(2);
fc = fabc(3);
% 判断三点或三点函数值的距离是否小于给定阈值.若小于阈值停止循环，得最优解x0=a
fba = fb - fa;     % a，b点函数值之差
fcb = fc - fb;      % b，c点函数值之差
if MaxIter <= 0 || abs(fba) + abs(fcb) < TolFun || max(abs(b - a) + abs(c - b)) < TolX
    xo = a;
else   % 大于阈值，更新多边形顶点
    m = (a + b) / 2; 
    e = 3*m - 2*c;     % 扩展（expansion）
    fe = func(e);
    if fe < fb
        c = e; 
        fc = fe;
    else
        r = (m + e) / 2;     % 反射（reflection）
        fr = func(r);
        if fr < fc
            c = r;
            fc = fr; 
        end
        if fr >= fb
            s = (c + m) / 2;   % 内收缩（inside contraction）
            fs = func(s);
            if fs < fc
                c = s;
                fc = fs;
            else
                b = m;
                c = (a + c) / 2;   % 变小（shrink）
                fb = func(b);
                fc = func(c);
            end
        end
    end
    xo= Nelder0(func, [a; b; c], [fa fb fc], TolX, TolFun, MaxIter - 1);
end
end