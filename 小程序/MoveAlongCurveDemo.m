clear; clc;
x = - 5 : 0.5 : 5;
y = x.^2;
minX = min(x);
maxX = max(x);
minY = min(y);
maxY = max(y);
h1 = axes('position', [0.1, 0.1, 0.8, 0.8]);
plot(x, y);
xlim([minX, maxX]);
ylim([minY, maxY]);
sizeDog = 0.05;
posX = 0.1;
poxY = 0.85;
% 图像的位置
h2 = axes('position', [posX poxY sizeDog sizeDog]);
imshow('dog.jpg');
for i = 1 : length(x)
    posX = (x(i) - minX) / (maxX - minX) * 0.8 + 0.1;
    posY = (y(i) - minY) / (maxY - minY) * 0.8 + 0.1;
    delete(h2);
    h2 = axes('position', [posX posY sizeDog sizeDog]); 
    imshow('dog.jpg');
    % 暂停以显示动态过程
    pause(0.1);
end