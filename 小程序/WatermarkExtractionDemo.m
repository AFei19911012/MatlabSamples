clear; clc;
imData = imread('test.jpg');
[m, n, r] = size(imData);
reData = imData;
for i = 1 : m
    for j = 1 : n
        mini = min(imData(i,j,:));
        maxi = max(imData(i,j,:));
        if maxi - mini < 10   % 根据实际情况修改         
            reData(i, j, 1) = 255;
            reData(i, j, 2) = 255;
            reData(i, j, 3) = 255;
        elseif maxi - mini < 100
            reData(i, j, 1) = 255;
        else
            reData(i, j, 1) = 255;
            reData(i, j, 2) = 50;
            reData(i, j, 3) = 50;
        end
    end
end
subplot(1, 2, 1)
imshow(imData)
subplot(1, 2, 2)
imshow(reData)