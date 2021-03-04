function [Pm, Fm] = RegionBoundary(Jm)
% ����������ȷ������ı߽�
% ���룺
%    Jm������Ȥ����ֵΪ1�����ಿ��ֵΪ��
% �����
%    Pm���߽����꣬��һ��Ϊ���򣬵ڶ���Ϊ����
%    Fm���߽��
[xlen, ylen] = size(Jm);
Je = zeros(xlen + 2, ylen + 2);   % ��ֹ���ֱ߽�����
for i = 2 : xlen + 1
    for j = 2 : ylen + 1
        Je(i, j) = Jm(i - 1, j - 1);
    end
end
% ��� Je ���Ѿ�ѡ��ı߽��
F = zeros(xlen + 2, ylen + 2);      
% �߽�����
P = zeros((xlen + 2)*(ylen + 2), 2);   
% ȷ����һ���߽��A������ѡ�񣬴�������
flag = 0;
for i = 1 : xlen + 2
    for j = 1 : ylen + 2
        if Je(i, j) == 1 
            m = i;     % ��ʼ��
            n = j;
            flag = 1;
            break;
        end
    end
    if flag
        break;
    end
end
% ��ʼ��
i = m;
j = n;
dir = 7;
flag = 1;
count = 0;
% �ӳ�ʼ�㿪ʼ������ֱ�������˳�����
while 1   
    xx = i;
    yy = j;
    if mod(dir, 2) == 0
        dir = mod(dir + 7, 8);
    else
        dir = mod(dir + 6, 8);
    end
    switch dir
        case 0
            j = j + 1;
        case 1
            i = i - 1;
            j = j + 1;
        case 2
            i = i - 1;
        case 3
            i = i - 1;
            j = j - 1;
        case 4
            j = j - 1;
        case 5
            i = i + 1;
            j = j - 1;
        case 6
            i = i + 1;
        case 7
            i = i + 1;
            j = j + 1;
    end
    while abs(Je(i, j) - 1) > 0.1
        dir = mod(dir + 1, 8);
        i = xx;
        j = yy;
        switch dir
            case 0
                j = j + 1;
            case 1
                i = i - 1;
                j = j + 1;
            case 2
                i = i - 1;
            case 3
                i = i - 1;
                j = j - 1;
            case 4
                j = j - 1;
            case 5
                i = i + 1;
                j = j - 1;
            case 6
                i = i + 1;
            case 7
                i = i + 1;
                j = j + 1;
        end    
    end
    if flag == 1
        p = i;
        q = j;
        xx = i;
        yy = j;
        flag = 0;
    end
    F(i, j) = 1;
    xxx = i;
    yyy = j;
    count = count + 1;
    P(count, 2) = xxx;
    P(count, 1) = yyy;
    if m == xx && n == yy && p == xxx && q == yyy
        break;
    end
end
% �����ʱ��ԭһ��
Fm = F(2 : end - 1, 2 : end - 1);
Pm = P(P(:, 1) > 0, :) - 1;