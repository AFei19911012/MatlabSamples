clear; clc;
x = 0:.2:12;
h1 = plot(x,besselj(1,x),'-ok');
hold on 
h2 = plot(x,besselj(2,x),'-*k');
h3 = plot(x,besselj(3,x),'-sk');
% 重新绘制一遍，会覆盖上面的曲线
h4 = plot(x,besselj(1,x),'-ob');
h5 = plot(x,besselj(2,x),'-*m');
h6 = plot(x,besselj(3,x),'-sr');
% 只会显示前面三条曲线的legend
legend('First', 'second', 'third');
% 如果想显示特定曲线的legend
% legend([h1, h3, h5], 'First', 'second', 'third');
hold off