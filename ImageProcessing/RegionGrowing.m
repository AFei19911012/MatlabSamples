function roi = RegionGrowing(imgData, initPos, threshold)
% ������������ȡĿ�����򣺱Ƚ���������������ƽ���Ҷ�ֵ����������صĻҶ�ֵ
% ���룺
%    imgData: ��ά���飬��ֵ��ʾ�Ҷ�ֵ��0~255
%    initPos: ָ�������ӵ�����
%    threshold: ��ֵ��Ĭ��ֵΪ20
% �����
%   roi: ����Ȥ����
% ����ͼ���ά��
[row, col] = size(imgData);  
% ���
roi = zeros(row, col); 
% ��ʼ��
x0 = initPos(1);               
y0 = initPos(2);
% ������ʼ��Ҷ�ֵ
regMean = imgData(x0, y0); 
% ������ʼ������Ϊ 1
roi(x0, y0) = 1;       
% �������������ĻҶ�ֵ�ܺ�
regSum = regMean;   
% �������������ĵ�ĸ���
regNum = 1;  
% ÿ���ж���Χ�˸����з�����������Ŀ
count = 1;      
% ��¼��ѡ��������
regChoose = zeros(row*col, 2); 
regChoose(regNum, :) = initPos;
num = 1;       % ��һ����   
while count > 0
    % ��Χ�˸����з��������ĵ�ĻҶ�ֵ�ܺ�
    sTemp = 0;          
    count = 0;
    % ��������ÿ��������������ظ�
    for k = 1 : num      
        i = regChoose(regNum - num + k, 1);
        j = regChoose(regNum - num +k, 2);
        % ��ȷ���Ҳ��Ǳ߽��ϵĵ�
        if roi(i, j) == 1 && i > 1 && i < row && j > 1 && j < col   
            % ������
            for u =  -1 : 1      
                for v = -1 : 1
                    % δ�������������������ĵ�
                    if roi(i + u, j + v) == 0 && abs(imgData(i + u, j + v) - regMean) <= threshold
                        % ��Ӧ������Ϊ 1
                        roi(i + u, j + v) = 1;           
                        count = count + 1;
                        regChoose(regNum + count, :) = [i + u, j + v];
                        % �Ҷ�ֵ���� sTemp ��
                        sTemp = sTemp + imgData(i + u, j + v);   
                    end
                end
            end
        end
    end
    % �����ĵ�
    num = count;   
    % �������ܵ���
    regNum = regNum + count; 
    % �������ܻҶ�ֵ
    regSum = regSum + sTemp;  
    % ����Ҷ�ƽ��ֵ
    regMean = regSum / regNum;     
end