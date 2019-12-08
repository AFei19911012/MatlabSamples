function threshValue = ThresholdMaxEntropy(imgData)
% 最大熵计算阈值
% 输入：
%    imgData：二维数组，数值表示灰度；
% 输出：
%    threshValue：阈值
[X, Y] = size(imgData);
vMax = max(max(imgData));
vMin = min(min(imgData));
T0 = (vMax + vMin) / 2;          % 初始分割阈值
h = GetImageHist(imgData);       % 计算图像的直方图
grayp = h / (X * Y);               % 图像像素概率
% 计算初始熵
H0 = 0;
for i = 1 : 256
    if grayp(i) > 0
        H0 = H0 - grayp(i) * log(grayp(i));
    end
end
% 开始迭代计算
cout = 100;      % 设置最大迭代次数
while cout > 0
    Tmax = 0;            % 初始化
    T1 = T0;   
    A1 = 0;              % 分割区域G1的点数
    A2 = 0;              % 分割区域G2的点数
    B1 = 0;              % 分割区域G1的灰度总和
    B2 = 0;              % 分割区域G2灰度总和
    for i = 1 : X        % 计算灰度平均值
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
    M1 = B1 / A1;              % 分割区域G1的平均灰度
    M2 = B2 / A2;              % 分割区域G2的平均灰度
    T2 = (M1 + M2) / 2;        % 更新阈值
    TT = floor(T2);
    grayPd = sum(grayp(1 : TT));    % 计算分割区域G1的概率和
    if grayPd == 0
        grayPd = eps;
    end
    grayPb = 1 - grayPd;
    if grayPb == 0
        grayPb = eps;
    end
    % 计算分割后区域G1和G2的信息熵
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
    H1 = Hd + Hb;      % 总的熵
    % 退出条件
    if abs(H0 - H1) < 0.0001 
        Tmax = T2;
        break;
    else 
        T0 = T2;
        H0 = H1;
    end
    cout = cout - 1;
end
% 返回阈值
threshValue = floor(Tmax);
end

% 灰度直方图
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