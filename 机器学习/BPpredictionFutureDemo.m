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
TestSamNum = rowLen;    % ѵ����������
HiddenUnitNum = 9;      % ������
InDim = colLen - 1;     % �����
OutDim = 1;             % �����
p = data(:, 1:InDim)';  % �������ݾ���
t = data(:, colLen)';   % Ŀ�����ݾ���
% [SamIn, minP, maxP, tn, minT, maxT] = premnmx(p, t);   % ԭʼ�����ԣ�������������ʼ��
[SamIn, PSp] = mapminmax(p, -1, 1);   % premnmx (-1��1֮��) �ѱ��滻Ϊ mapminmax
[tn, PSt] = mapminmax(t, -1, 1);
SamOut = tn;         % �������
MaxEpochs = 50000;   % ���ѵ������
lr = 0.05;           % ѧϰ��
E0 = 1e-3;           % Ŀ�����
rng('default');
W1 = rand(HiddenUnitNum, InDim);      % ��ʼ���������������֮���Ȩֵ
B1 = rand(HiddenUnitNum, 1);          % ��ʼ���������������֮�����ֵ
W2 = rand(OutDim, HiddenUnitNum);     % ��ʼ���������������֮���Ȩֵ              
B2 = rand(OutDim, 1);                 % ��ʼ���������������֮�����ֵ
ErrHistory = zeros(MaxEpochs, 1);     
for i = 1 : MaxEpochs   
    HiddenOut = logsig(W1*SamIn + repmat(B1, 1, TestSamNum));   % �������������
    NetworkOut = W2*HiddenOut + repmat(B2, 1, TestSamNum);      % ������������
    Error = SamOut - NetworkOut;       % ʵ��������������֮��
    SSE = sumsqr(Error);               % �������������ƽ���ͣ�
    ErrHistory(i) = SSE;               % ��¼ÿ��ѧϰ�����
    if SSE < E0                        % ����ﵽ�����ֵ���˳�
        break;
    end
    % ����������BP��������ĵĳ���
    % Ȩֵ����ֵ�����������������ݶ��½�ԭ��������ÿһ����̬������
    Delta2 = Error;
    Delta1 = W2' * Delta2 .* HiddenOut .* (1 - HiddenOut);    
    dW2 = Delta2 * HiddenOut';
    dB2 = Delta2 * ones(TestSamNum, 1); 
    dW1 = Delta1 * SamIn';
    dB1 = Delta1 * ones(TestSamNum, 1);
    % ���������������֮���Ȩֵ����ֵ��������
    W2 = W2 + lr*dW2;
    B2 = B2 + lr*dB2;
    % ���������������֮���Ȩֵ����ֵ��������
    W1 = W1 + lr*dW1;
    B1 = B1 + lr*dB1;
end
HiddenOut = logsig(W1*SamIn + repmat(B1, 1, TestSamNum));   % ������������ս��
NetworkOut = W2*HiddenOut + repmat(B2, 1, TestSamNum);      % �����������ս��
% tFit = postmnmx(NetworkOut, minT, maxT);    % ����һ������ԭ���������Ľ��
tFit = mapminmax('reverse', NetworkOut, PSt);
x = 1 : 10;   % ����
subplot(2, 1, 1)
plot(x, t, 'r-o', x, tFit, 'b--*');
xlabel('����');
ylabel('��ֵ');
% ����ѵ���õ��������Ԥ��
% ����Ԥ����� 5 �꣬ÿ��Ԥ�� 1 ��
ForcastSamNum = 1;
preP = zeros(1, 5);
pNew = data(end, 2:end)';    % ���һ�������룬������
for i = 1 : 5
    pnew = pNew;  
%     pnewn = tramnmx(pnew, minP, maxP);  % ��һ������ѧϰ���ݵ������Сֵ
    pnewn = mapminmax('apply', pnew, PSp);
    HiddenOut = logsig(W1*pnewn + repmat(B1, 1, ForcastSamNum));  % ���������Ԥ����
    anewn = W2*HiddenOut + repmat(B2, 1, ForcastSamNum);          % ��������Ԥ����
%     anew = postmnmx(anewn, minT, maxT);   % ����һ��
    anew = mapminmax('reverse', anewn, PSt);
    preP(i) = anew;      % ����Ԥ��ֵ
    pNew = [pNew(2:end); anew];   % ��Ԥ���ֵ��Ϊ��һ�ε�����
end
% �����߻�һ��
hold on 
plot(11:15, preP, 'b--s');
legend('��ʵֵ', '���ֵ', 'Ԥ��ֵ','Location','northwest');
hold off
subplot(2, 1, 2)
plot(x, tFit - t, '--o');
hold on
plot(x, abs(tFit - t) ./ t, '--*')
hold off
legend('�������', '������');
xlabel('����');
ylabel('�������');
% ��ʵֵ
realTfit = tFit * (maxValue - minValue) + minValue;
realPreP = preP * (maxValue - minValue) + minValue;
% disp('Ԥ��ֵ��');
% disp(realPreP);
