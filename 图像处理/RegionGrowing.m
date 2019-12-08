function roi = RegionGrowing(imgData, initPos, regMaxdist)
% ������������ȡĿ�����򣺱Ƚ���������������ƽ���Ҷ�ֵ����������صĻҶ�ֵ
% ���룺
%    imgData: ��ά���飬��ֵ��ʾ�Ҷ�ֵ��0~255
%    initPos: ָ�������ӵ�����
%    regMaxdist: ��ֵ��Ĭ��ֵΪ20
% �����
%   roi: ����Ȥ����
[row, col] = size(imgData);          % ����ͼ���ά�� 
roi = zeros(row, col);               % ���
x0 = initPos(1);                     % ��ʼ��
y0 = initPos(2);
reg_mean = imgData(x0, y0);          % ������ʼ��Ҷ�ֵ
roi(x0, y0) = 1;                     % ������ʼ������Ϊ��ɫ
reg_sum = reg_mean;                  % �������������ĻҶ�ֵ�ܺ�
reg_num = 1;                         % �������������ĵ�ĸ���
count = 1;                           % ÿ���ж���Χ�˸����з�����������Ŀ
reg_choose = zeros(row*col, 2);      % ��¼��ѡ��������
reg_choose(reg_num, :) = initPos;
num = 1;       % ��һ����   
while count > 0
    s_temp = 0;          % ��Χ�˸����з��������ĵ�ĻҶ�ֵ�ܺ�
    count = 0;
    for k = 1 : num      % ��������ÿ��������������ظ�
        i = reg_choose(reg_num - num + k, 1);
        j = reg_choose(reg_num - num +k, 2);
        if roi(i, j) == 1 && i > 1 && i < row && j > 1 && j < col   % ��ȷ���Ҳ��Ǳ߽��ϵĵ�
            % ������
            for u =  -1 : 1      
                for v = -1 : 1
                    % δ�������������������ĵ�
                    if roi(i + u, j + v) == 0 && abs(imgData(i + u, j + v) - reg_mean) <= regMaxdist
                        roi(i + u, j + v) = 1;           % ��Ӧ������Ϊ��ɫ
                        count = count + 1;
                        reg_choose(reg_num + count, :) = [i + u, j + v];
                        s_temp = s_temp + imgData(i + u, j + v);   % �Ҷ�ֵ����s_temp��
                    end
                end
            end
        end
    end
    num = count;                      % �����ĵ�
    reg_num = reg_num + count;        % �������ܵ���
    reg_sum = reg_sum + s_temp;       % �������ܻҶ�ֵ
    reg_mean = reg_sum / reg_num;     % ����Ҷ�ƽ��ֵ
end