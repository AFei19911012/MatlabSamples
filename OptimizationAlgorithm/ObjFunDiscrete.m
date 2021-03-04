function result = ObjFunDiscrete(x, xMax, xMin)
%%%%%%%%%%  ��Ӧ�Ⱥ���  %%%%%%%%%%%
m = 0;
D = length(x);
for j = 1:D
   m = m + x(j) * 2^(j - 1);
end
% �����ʮ������
f = xMin + m * (xMax - xMin) / (2^D - 1);    
fit = f + 6 * sin(4 * f) + 9 * cos(5 * f);
result = fit;