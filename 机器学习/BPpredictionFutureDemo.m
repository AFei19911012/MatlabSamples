clear; clc;
data = [0         0.0252    0.0550    0.1104    0.1480
        0.0252    0.0550    0.1104    0.1480    0.2111
        0.0550    0.1104    0.1480    0.2111    0.3369
        0.1104    0.1480    0.2111    0.3369    0.5482
        0.1480    0.2111    0.3369    0.5482    0.6612
        0.2111    0.3369    0.5482    0.6612    0.7127
        0.3369    0.5482    0.6612    0.7127    0.7598
        0.5482    0.6612    0.7127    0.7598    0.7720
        0.6612    0.7127    0.7598    0.7720    0.8274
        0.7127    0.7598    0.7720    0.8274    1.0000];
minValue = 320.9;
maxValue = 8338;
[rowLen, colLen] = size(data);
TestSamNum = rowLen;    % 训练样本数量
HiddenUnitNum = 9;      % 隐含层
InDim = colLen - 1;     % 输入层
OutDim = 1;             % 输出层
p = data(:, 1:InDim)';  % 输入数据矩阵
t = data(:, colLen)';   % 目标数据矩阵
% [SamIn, minP, maxP, tn, minT, maxT] = premnmx(p, t);   % 原始样本对（输入和输出）初始化
[SamIn, PSp] = mapminmax(p, -1, 1);   % premnmx (-1到1之间) 已被替换为 mapminmax
[tn, PSt] = mapminmax(t, -1, 1);
SamOut = tn;         % 输出样本
MaxEpochs = 50000;   % 最大训练次数
lr = 0.05;           % 学习率
E0 = 1e-3;           % 目标误差
rng('default');
W1 = rand(HiddenUnitNum, InDim);      % 初始化输入层与隐含层之间的权值
B1 = rand(HiddenUnitNum, 1);          % 初始化输入层与隐含层之间的阈值
W2 = rand(OutDim, HiddenUnitNum);     % 初始化输出层与隐含层之间的权值              
B2 = rand(OutDim, 1);                 % 初始化输出层与隐含层之间的阈值
ErrHistory = zeros(MaxEpochs, 1);     
for i = 1 : MaxEpochs   
    HiddenOut = logsig(W1*SamIn + repmat(B1, 1, TestSamNum));   % 隐含层网络输出
    NetworkOut = W2*HiddenOut + repmat(B2, 1, TestSamNum);      % 输出层网络输出
    Error = SamOut - NetworkOut;       % 实际输出与网络输出之差
    SSE = sumsqr(Error);               % 能量函数（误差平方和）
    ErrHistory(i) = SSE;               % 记录每次学习的误差
    if SSE < E0                        % 如果达到误差阈值就退出
        break;
    end
    % 以下六行是BP网络最核心的程序
    % 权值（阈值）依据能量函数负梯度下降原理所作的每一步动态调整量
    Delta2 = Error;
    Delta1 = W2' * Delta2 .* HiddenOut .* (1 - HiddenOut);    
    dW2 = Delta2 * HiddenOut';
    dB2 = Delta2 * ones(TestSamNum, 1); 
    dW1 = Delta1 * SamIn';
    dB1 = Delta1 * ones(TestSamNum, 1);
    % 对输出层与隐含层之间的权值和阈值进行修正
    W2 = W2 + lr*dW2;
    B2 = B2 + lr*dB2;
    % 对输入层与隐含层之间的权值和阈值进行修正
    W1 = W1 + lr*dW1;
    B1 = B1 + lr*dB1;
end
HiddenOut = logsig(W1*SamIn + repmat(B1, 1, TestSamNum));   % 隐含层输出最终结果
NetworkOut = W2*HiddenOut + repmat(B2, 1, TestSamNum);      % 输出层输出最终结果
% tFit = postmnmx(NetworkOut, minT, maxT);    % 反归一化，还原网络输出层的结果
tFit = mapminmax('reverse', NetworkOut, PSt);
x = 1 : 10;   % 序列
subplot(2, 1, 1)
plot(x, t, 'r-o', x, tFit, 'b--*');
xlabel('序列');
ylabel('数值');
% 利用训练好的网络进行预测
% 滚动预测后续 5 年，每次预测 1 年
ForcastSamNum = 1;
preP = zeros(1, 5);
pNew = data(end, 2:end)';    % 最后一行是输入，竖着排
for i = 1 : 5
    pnew = pNew;  
%     pnewn = tramnmx(pnew, minP, maxP);  % 归一化，用学习数据的最大最小值
    pnewn = mapminmax('apply', pnew, PSp);
    HiddenOut = logsig(W1*pnewn + repmat(B1, 1, ForcastSamNum));  % 隐含层输出预测结果
    anewn = W2*HiddenOut + repmat(B2, 1, ForcastSamNum);          % 输出层输出预测结果
%     anew = postmnmx(anewn, minT, maxT);   % 反归一化
    anew = mapminmax('reverse', anewn, PSt);
    preP(i) = anew;      % 保存预测值
    pNew = [pNew(2:end); anew];   % 新预测的值作为下一次的输入
end
% 两条线画一起
hold on 
plot(11:15, preP, 'b--s');
legend('真实值', '拟合值', '预测值','Location','northwest');
hold off
subplot(2, 1, 2)
plot(x, tFit - t, '--o');
hold on
plot(x, abs(tFit - t) ./ t, '--*')
hold off
legend('绝对误差', '相对误差');
xlabel('序列');
ylabel('绝对误差');
% 真实值
realTfit = tFit * (maxValue - minValue) + minValue;
realPreP = preP * (maxValue - minValue) + minValue;
% disp('预测值：');
% disp(realPreP);
