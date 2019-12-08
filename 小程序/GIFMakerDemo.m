clear;clc;
filename = '�����.gif';  % �����ļ���
for i = 1:5
    str = [num2str(i), '.bmp'];   % ��ǰ·����������ͼ
    Img = imread(str);
    Img = imresize(Img, [256, 256]);
    imshow(Img);
    set(gcf, 'visible', 'off');   % ����ʾ����
    q = get(gca, 'position');
    q(1) = 0;     % ������߾���ֵΪ��
    q(2) = 0;     % �����ұ߾���ֵΪ��
    set(gca, 'position',q);
    frame = getframe(gcf, [0, 0, 200, 200]);
    im = frame2im(frame);   % ����gif�ļ���ͼ�������index����ͼ��
    imshow(im);
    [I, map] = rgb2ind(im, 256);
    if i == 1
        imwrite(I, map, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.3);
    else
        imwrite(I, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.3);
    end
end