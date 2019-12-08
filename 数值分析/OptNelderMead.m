function xo = OptNelderMead(func, x0, TolX, TolFun, MaxIter)
%{
�������ܣ������η�����ά��Լ������:  min f(x)��
���룺
  func�����������
  x0����ʼ�㣻
  TolX��x ������ֵ��
  TolFun��y ������ֵ��
  MaxIter��������������
�����
  xo����Сֵ�㣻
���ø�ʽ��
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
    error('�����������!');
end
% ��ʼ���
N = length(x0);
if N == 1   %  һά������˳�
    xo = [];
    return
end
S = eye(N);
for i = 1 : N     % �Ա���ά������2ʱ���ظ�����ÿ����ƽ������
    i1 = i + 1;
    if i1 > N
        i1 = 1;
    end
    abc = [x0; x0 + S(i,:); x0 + S(i1,:)];    % ÿһ��������ƽ��
    fabc = [func(abc(1, :)); func(abc(2, :)); func(abc(3, :))];
    x0 = Nelder0(func, abc, fabc, TolX, TolFun, MaxIter);
    if N < 3     % ��ά��������ظ�
        break;
    end 
end
xo = x0;
end

function xo = Nelder0(func, abc, fabc, TolX, TolFun, MaxIter)
% ��ά�ռ��еĶ���αƽ�
if nargin < 6
    MaxIter = 100;
end
if nargin < 5
    TolFun = 1e-8;
end
if nargin < 4
    TolX = 1e-6;
end
%  ȷ����������a��b��c�����亯��ֵ����С��������
[fabc, I] = sort(fabc);  % ����ά�ռ��еĶ������������ĺ���ֵ����С����˳������
a = abc(I(1), :);
b = abc(I(2), :); 
c = abc(I(3), :);
fa = fabc(1); 
fb = fabc(2);
fc = fabc(3);
% �ж���������㺯��ֵ�ľ����Ƿ�С�ڸ�����ֵ.��С����ֵֹͣѭ���������Ž�x0=a
fba = fb - fa;     % a��b�㺯��ֵ֮��
fcb = fc - fb;      % b��c�㺯��ֵ֮��
if MaxIter <= 0 || abs(fba) + abs(fcb) < TolFun || max(abs(b - a) + abs(c - b)) < TolX
    xo = a;
else   % ������ֵ�����¶���ζ���
    m = (a + b) / 2; 
    e = 3*m - 2*c;     % ��չ��expansion��
    fe = func(e);
    if fe < fb
        c = e; 
        fc = fe;
    else
        r = (m + e) / 2;     % ���䣨reflection��
        fr = func(r);
        if fr < fc
            c = r;
            fc = fr; 
        end
        if fr >= fb
            s = (c + m) / 2;   % ��������inside contraction��
            fs = func(s);
            if fs < fc
                c = s;
                fc = fs;
            else
                b = m;
                c = (a + c) / 2;   % ��С��shrink��
                fb = func(b);
                fc = func(c);
            end
        end
    end
    xo= Nelder0(func, [a; b; c], [fa fb fc], TolX, TolFun, MaxIter - 1);
end
end