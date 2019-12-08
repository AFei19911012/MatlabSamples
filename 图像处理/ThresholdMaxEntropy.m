function threshValue = ThresholdMaxEntropy(imgData)
% ����ؼ�����ֵ
% ���룺
%    imgData����ά���飬��ֵ��ʾ�Ҷȣ�
% �����
%    threshValue����ֵ
[X, Y] = size(imgData);
vMax = max(max(imgData));
vMin = min(min(imgData));
T0 = (vMax + vMin) / 2;          % ��ʼ�ָ���ֵ
h = GetImageHist(imgData);       % ����ͼ���ֱ��ͼ
grayp = h / (X * Y);               % ͼ�����ظ���
% �����ʼ��
H0 = 0;
for i = 1 : 256
    if grayp(i) > 0
        H0 = H0 - grayp(i) * log(grayp(i));
    end
end
% ��ʼ��������
cout = 100;      % ��������������
while cout > 0
    Tmax = 0;            % ��ʼ��
    T1 = T0;   
    A1 = 0;              % �ָ�����G1�ĵ���
    A2 = 0;              % �ָ�����G2�ĵ���
    B1 = 0;              % �ָ�����G1�ĻҶ��ܺ�
    B2 = 0;              % �ָ�����G2�Ҷ��ܺ�
    for i = 1 : X        % ����Ҷ�ƽ��ֵ
        for j = 1 : Y
            if(imgData(i, j) <= T1)
                A1 = A1 + 1;
                B1 = B1 + imgData(i, j);
            else
                A2 = A2 + 1;
                B2 = B2 + imgData(i, j);
            end
        end
    end
    M1 = B1 / A1;              % �ָ�����G1��ƽ���Ҷ�
    M2 = B2 / A2;              % �ָ�����G2��ƽ���Ҷ�
    T2 = (M1 + M2) / 2;        % ������ֵ
    TT = floor(T2);
    grayPd = sum(grayp(1 : TT));    % ����ָ�����G1�ĸ��ʺ�
    if grayPd == 0
        grayPd = eps;
    end
    grayPb = 1 - grayPd;
    if grayPb == 0
        grayPb = eps;
    end
    % ����ָ������G1��G2����Ϣ��
    Hd = 0;
    Hb = 0;
    for i = 1 : 256
        if i <= TT
            if grayp(i) > 0
                Hd = Hd - grayp(i) / grayPd * log(grayp(i) / grayPd);
            end
        else
            if grayp(i) > 0
                Hb = Hb - grayp(i) / grayPb * log(grayp(i) / grayPb);
            end
        end
    end
    H1 = Hd + Hb;      % �ܵ���
    % �˳�����
    if abs(H0 - H1) < 0.0001 
        Tmax = T2;
        break;
    else 
        T0 = T2;
        H0 = H1;
    end
    cout = cout - 1;
end
% ������ֵ
threshValue = floor(Tmax);
end

% �Ҷ�ֱ��ͼ
function h = GetImageHist(Imag)
h = zeros(256, 1);
for k = 1 : 256
    h(k) = 0;
    for i = 1 : size(Imag, 2)
        for j = 1 : size(Imag, 2)
            if Imag(i, j) == k - 1
                h(k) = h(k) + 1;
            end
        end
    end
end
end