clear;clc;
filename = '表情包.gif';  % 保存文件名
for i = 1:5
    str = [num2str(i), '.bmp'];   % 当前路径下有五张图
    Img = imread(str);
    Img = imresize(Img, [256, 256]);
    imshow(Img);
    set(gcf, 'visible', 'off');   % 不显示窗口
    q = get(gca, 'position');
    q(1) = 0;     % 设置左边距离值为零
    q(2) = 0;     % 设置右边距离值为零
    set(gca, 'position',q);
    frame = getframe(gcf, [0, 0, 200, 200]);
    im = frame2im(frame);   % 制作gif文件，图像必须是index索引图像
    imshow(im);
    [I, map] = rgb2ind(im, 256);
    if i == 1
        imwrite(I, map, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.3);
    else
        imwrite(I, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.3);
    end
end