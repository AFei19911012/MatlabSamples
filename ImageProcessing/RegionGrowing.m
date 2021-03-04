function roi = RegionGrowing(imgData, initPos, threshold)
% 区域生长法提取目标区域：比较新像素所在区域平均灰度值与各领域像素的灰度值
% 输入：
%    imgData: 二维数组，数值表示灰度值，0~255
%    initPos: 指定的种子点坐标
%    threshold: 阈值，默认值为20
% 输出：
%   roi: 感兴趣区域
% 输入图像的维数
[row, col] = size(imgData);  
% 输出
roi = zeros(row, col); 
% 初始点
x0 = initPos(1);               
y0 = initPos(2);
% 生长起始点灰度值
regMean = imgData(x0, y0); 
% 生长起始点设置为 1
roi(x0, y0) = 1;       
% 符合生长条件的灰度值总和
regSum = regMean;   
% 符合生长条件的点的个数
regNum = 1;  
% 每次判断周围八个点中符合条件的数目
count = 1;      
% 记录已选择点的坐标
regChoose = zeros(row*col, 2); 
regChoose(regNum, :) = initPos;
num = 1;       % 第一个点   
while count > 0
    % 周围八个点中符合条件的点的灰度值总和
    sTemp = 0;          
    count = 0;
    % 对新增的每个点遍历，避免重复
    for k = 1 : num      
        i = regChoose(regNum - num + k, 1);
        j = regChoose(regNum - num +k, 2);
        % 已确定且不是边界上的点
        if roi(i, j) == 1 && i > 1 && i < row && j > 1 && j < col   
            % 八邻域
            for u =  -1 : 1      
                for v = -1 : 1
                    % 未处理且满足生长条件的点
                    if roi(i + u, j + v) == 0 && abs(imgData(i + u, j + v) - regMean) <= threshold
                        % 对应点设置为 1
                        roi(i + u, j + v) = 1;           
                        count = count + 1;
                        regChoose(regNum + count, :) = [i + u, j + v];
                        % 灰度值存入 sTemp 中
                        sTemp = sTemp + imgData(i + u, j + v);   
                    end
                end
            end
        end
    end
    % 新增的点
    num = count;   
    % 区域内总点数
    regNum = regNum + count; 
    % 区域内总灰度值
    regSum = regSum + sTemp;  
    % 区域灰度平均值
    regMean = regSum / regNum;     
end