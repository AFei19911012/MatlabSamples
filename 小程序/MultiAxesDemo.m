% ����������ʾ
clear; clc;
x = 0 : 0.1 : 2 * pi;
% �������������ͬ��Χ������
y1 = x.^2;
y2 = sin(x);
y3 = 5 * cos(x);
% ���� aies �Ĵ�С��λ��
h1 = axes('position', [0.1 0.1 0.5 0.5]);    
% �����߻��Ƶ�һ��ע�����ݶ���׼���� y1 ��Χ
plot(x, y1, 'k', x, y2 * max(y1) / max(y2), 'r', x, y3 * max(y1) / max(y3), 'b')
ylabel('test1');
% �������������յ�������
h2 = axes('position', [0.65 0.1 0.01 0.5], 'color', 'r'); 
plot(x, y2, 'w')
set(h2, 'ycolor', 'r')
box off
ylabel('test2');
set(h2, 'yaxislocation', 'right', 'xtick', [])
h3 = axes('position', [0.75 0.1 0.01 0.5]); 
plot(x, y3, 'w')
set(h3, 'ycolor', 'b')
box off
ylabel('test3');
set(h3, 'yaxislocation', 'right', 'xtick', [])
% ����һ����ɫ
set(h1, 'color','none')
set(h2, 'color','none')
set(h3, 'color','none')
set(gcf,'color','white')