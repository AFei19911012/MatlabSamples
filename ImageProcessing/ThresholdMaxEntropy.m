function threshValue = ThresholdMaxEntropy(imgData)
% ����ؼ�����ֵ
% ���룺
%    imgData����ά���飬��ֵ��ʾ�Ҷȣ�
% �����
%    threshValue����ֵ
[X, Y] = size(imgData);
vMax = max(imgData(:));
vMin = min(imgData(:));
% ��ʼ�ָ���ֵ
T0 = (vMax + vMin) / 2;       
% ����ͼ���ֱ��ͼ
h = GetImageHist(imgData);   
% ͼ�����ظ���
grayP = h / (X * Y);               
% �����ʼ��
H0 = 0;
for i = 1 : 256
    if grayP(i) > 0
        H0 = H0 - grayP(i) * log(grayP(i));
    end
end
% ��ʼ��������
% ��������������
cout = 100;      
while cout > 0
    % ��ʼ��
    Tmax = 0;            
    T1 = T0;   
    % �ָ����� G1 �ĵ���
    A1 = 0;   
    % �ָ����� G2 �ĵ���
    A2 = 0;     
    % �ָ����� G1 �ĻҶ��ܺ�
    B1 = 0;    
    % �ָ����� G2 �Ҷ��ܺ�
    B2 = 0;      
    % ����Ҷ�ƽ��ֵ
    for i = 1 : X        
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
    % �ָ�����G1��ƽ���Ҷ�
    M1 = B1 / A1;     
    % �ָ�����G2��ƽ���Ҷ�
    M2 = B2 / A2;   
    % ������ֵ
    T2 = (M1 + M2) / 2;        
    TT = floor(T2);
    % ����ָ�����G1�ĸ��ʺ�
    grayPd = sum(grayP(1 : TT));    
    if grayPd == 0
        grayPd = eps;
    end
    grayPb = 1 - grayPd;
    if grayPb == 0
        grayPb = eps;
    end
    % ����ָ������ G 1�� G2 ����Ϣ��
    Hd = 0;
    Hb = 0;
    for i = 1 : 256
        if i <= TT
            if grayP(i) > 0
                Hd = Hd - grayP(i) / grayPd * log(grayP(i) / grayPd);
            end
        else
            if grayP(i) > 0
                Hb = Hb - grayP(i) / grayPb * log(grayP(i) / grayPb);
            end
        end
    end
    % �ܵ���
    H1 = Hd + Hb;      
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