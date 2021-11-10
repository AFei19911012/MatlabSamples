# Matlab 常用代码段

文件不更新了，文章持续更新：https://zhuanlan.zhihu.com/p/408388753

[TOC]

# 1. 随机数、随机噪声

```python
% 产生 m 个属于 [1,  n] 的随机整数
randperm(n, m)
% 产生指定数值（默认 -1 和 1）分布的随机数，可指定元素分布概率
randsrc(10, 10, [-3 -1 1 3; 0.1 0.4 0.4 0.1])
% 产生指定范围的随机数
unifrnd(0, 1:5)
% 产生均值为 0.1 方差为 0.1 的随机数
x = 0.1 + sqrt(0.1)*randn(10000， 1);
% 产生 3 个和为 1 的随机数
r = rand(3, 1)；
r = r / sum(r)
% 生成相同的随机数
s = rng;
x = rand(1,5)
rng(s);
y = rand(1,5)
% 每次运行得到相同的结果
% 在使用随机数之前设置
rng('default');
% 添加噪声
y = x + rand(length(x), 1);
y = x + randn(length(x), 1);
```

# 2. 字符串分割

```python
% 直接分割
regexp('Numbers = 2500', '=', 'split')
% 分割得到 cell，需要二次处理
textscan('Numbers = 2500', '%s %d', 'Delimiter', '=')
```

# 3. 数据标准化

```python
y = (x - mean(x)) ./ std(x);
[y, mu, sigma] = zscore(x);
```

# 4. R2 计算

```python
x = 1:10;
y1 = x + rand(1, 10);
p = polyfit(x, y1, 1);
y2 = polyval(p, x);
R2 = sumsqr(y2 - mean(y1)) / sumsqr(y1 - mean(y1))
```

# 5. 鼠标位置、按键

```python
% 相对 Figure 位置
% Button down function: UIFigure
function UIFigureButtonDown(app, event)
    pos = get(app.UIFigure, 'CurrentPoint')
    pos app.UIFigure.CurrentPoint
end

% 相对 Axes 位置
% Button down function: UIAxes
function UIAxesButtonDown(app, event)
	pt = app.UIAxes.CurrentPoint;
    x = pt(1, 1)
    y = pt(1, 2)
end

% 鼠标按键
% normal：左键；alt：右键；extend：中键；open：双击，会触发两次单击
% Button down function: UIFigure
function UIFigureButtonDown(app, event)
    button = get(app.UIFigure, 'SelectionType')
end
```

# 6. 剪切板操作

```python
clear; clc;
x = linspace(0, 2*pi, 20);
y = sin(x);
plot(x, y);
% 把 y 值复制到剪切板
clipboard('copy', y);
% 获取剪切板内容
str = clipboard('paste')
% 把当前 figure 复制到剪切板
hgexport(gcf, '-clipboard')
```

# 7. 打开网址

```python
web('https://www.zhihu.com/people/1105936347')
```

# 8. 选择颜色

```python
% 单颜色
c = uisetcolor([0.6 0.8 1])
% 色条
cmap = uisetcolormap
```

# 9. 符号方程、符号转数值

```python
syms u
f = sym('3');
Eq = sin(f)*u^2 + u + f;
sol = solve(Eq, u)
sol_num = double(sol)
sol_num = vpa(sol)
% 符号替换数字
sol = subs(sol, f, 3)
```

# 10. 公式格式化输出到公式编辑器

```python
% 动态脚本输出，直接复制到公式编辑器
syms x
f = taylor(x*exp(x), x, 'order', 9)
% 复制输出字符串到公式编辑器
latex(f)
```

# 11. 文件读写函数汇总

> load、save
> dlmread、dlmwrite
> csvread、csvwrite
> importdata
> textscan
> fprintf
> readtable、writetable
> https://zhuanlan.zhihu.com/p/129803643
> https://zhuanlan.zhihu.com/p/358793886

# 12. 函数可视化

> fplot
> fimplicit
> fimplicit3
> fsurf
> isosurface
> https://zhuanlan.zhihu.com/p/339790552

# 13. 绘图字体、坐标轴属性设置

```python
clear; clc;                  
t = 6*pi*(0 : 100) / 100;
y = 1 - exp(- 0.3*t) .* cos(0.7*t);
plot(t, y, 'r-', 'LineWidth', 3)
hold on
tt = t(abs(y - 1) > 0.05);
ts = max(tt);
plot(ts, 0.95, 'bo', 'MarkerSize', 10)
hold off
axis([-inf, 6*pi, 0.6, inf])
set(gca, 'Xtick', [2*pi, 4*pi, 6*pi], 'Ytick', [0.95, 1, 1.05, max(y)])
set(gca, 'XtickLabel', {'2*pi'; '4*pi'; '6*pi'})
set(gca, 'YtickLabel', {'0.95'; '1'; '1.05'; 'max(y)'})
grid on
text(13.5, 1.2, '\fontsize{12}{\alpha} = 0.3')
text(13.5, 1.1, '\fontsize{12}{\omega} = 0.7')
cell_string{1} = '\fontsize{12}\uparrow';
cell_string{2} = '\fontsize{16} \fontname{隶书}镇定时间';
cell_string{3} = '\fontsize{6} ';
cell_string{4} = ['\fontsize{14}\rmt_{s} = ' num2str(ts)];
text(ts, 0.85, cell_string, 'Color', 'b', 'HorizontalAlignment', 'Center')
title('\fontsize{14}\it y = 1 - e^{ -\alpha t}cos{\omegat}')
xlabel('\fontsize{14} \bft \rightarrow')
ylabel('\fontsize{14} \bfy \rightarrow')
```

# 14. 三维曲面属性设置

```python
% 光照
clear; clc;                  
[X, Y, Z] = sphere(40);
colormap(jet)
subplot(1, 2, 1)
surf(X, Y, Z)
axis equal off
shading interp
light ('position', [0 -10 1.5], 'style', 'infinite')
lighting phong
material shiny
subplot(1, 2, 2)
surf(X, Y, Z, -Z)
axis equal off
shading flat
light
lighting flat
light('position', [-1, -1, -2], 'color', 'y')
light('position', [-1, 0.5, 1], 'style', 'local', 'color', 'w')
set(gcf, 'Color', 'w')

% 镂空
clear; clc;                  
[X0, Y0, Z0] = sphere(30);
X = 2*X0;
Y = 2*Y0;
Z = 2*Z0;
surf(X0, Y0, Z0);
shading interp
hold on
mesh(X,Y,Z)
colormap(hot)
hold off
hidden off
axis equal
axis off
```

# 15. 获取坐标轴范围

```python
limit = axis
xlim = get(gca, 'xLim')
ylim = get(gca, 'YLim')
```

# 16. 查找绘图对象

```python
% 查找 figure
clear; clc; close all;
x = linspace(0, 2*pi, 20);
y = sin(x);
figure(1)
plot(x, y);
figure(2)
plot(x, y, x, y + 1, '--');
figs = findobj('Type', 'figure')

% 查找线型为 '--' 的线
lines = findobj('Type', 'line', 'LineStyle', '--')
```

# 17. 格式化显示

```python
fprintf('%07.4f\n', 2.334)
% 02.3340
fprintf('%07d\n', 2)
% 0000002
num2str(5.5, '%07.4f')
% ans = '05.5000'
num2str(5.5, '%06.4f')
% ans = '5.5000'
num2str(2, '%06d')
% ans = '000002'
```

# 18. 刻度显示为 10^4 形式

```python
set(gca, 'xlim', [0 10e4]);
set(gca, 'xlim', [0 10e5]);
```

# 19. colorbar 设置指数上标

```matlab
clear;clc;
[x, y, z] = peaks(30);
z = z / 1000;
surf(x, y, z);
cb = colorbar;
cb.Ruler.Exponent = -3;
```

# 20. 坐标轴铺满 figure

```matlab
clear;clc;close all;
x = 0 : 0.1 : 5;
y1 = sin(2*x);
y2 = cos(3*x);
figure
plot(x, y1, 'o:', 'LineWidth', 2)
xlabel('x');
ylabel('y');
set(gca, 'looseInset', [0 0 0 0]);
figure
plot(x, y2, 'o:', 'LineWidth', 2)
xlabel('x');
ylabel('y');
set(gca, 'Position', [0.1 0.1 0.85 0.85]);
```





















