clear; clc;
x = 0:.2:12;
h1 = plot(x,besselj(1,x),'-ok');
hold on 
h2 = plot(x,besselj(2,x),'-*k');
h3 = plot(x,besselj(3,x),'-sk');
% ���»���һ�飬�Ḳ�����������
h4 = plot(x,besselj(1,x),'-ob');
h5 = plot(x,besselj(2,x),'-*m');
h6 = plot(x,besselj(3,x),'-sr');
% ֻ����ʾǰ���������ߵ�legend
legend('First', 'second', 'third');
% �������ʾ�ض����ߵ�legend
% legend([h1, h3, h5], 'First', 'second', 'third');
hold off