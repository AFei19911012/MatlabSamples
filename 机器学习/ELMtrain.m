function [IW, B, LW, TF, TYPE] = ELMtrain(P, T, N, TF, TYPE)
%{
Input:
    P   - Input Matrix of Training Set  (R*Q)
    T   - Output Matrix of Training Set (S*Q)
    N   - Number of Hidden Neurons (default = Q)
    TF  - Transfer Function:
          'sig' for Sigmoidal function (default)
          'sin' for Sine function
          'hardlim' for Hardlim function
    TYPE - Regression (0, default) or Classification (1)
Output:
    IW  - Input Weight Matrix (N*R)
    B   - Bias Matrix  (N*1)
    LW  - Layer Weight Matrix (N*S)
%}
[R, Q] = size(P);
if TYPE  == 1
    T  = ind2vec(T);
end
% Randomly Generate the Input Weight Matrix
IW = rand(N, R) * 2 - 1;
% Randomly Generate the Bias Matrix
B = rand(N, 1);
BiasMatrix = repmat(B, 1, Q);
% Calculate the Layer Output Matrix H
tempH = IW * P + BiasMatrix;
switch TF
    case 'sig'
        H = 1 ./ (1 + exp(-tempH));
    case 'sin'
        H = sin(tempH);
    case 'hardlim'
        H = hardlim(tempH);
end
% Calculate the Output Weight Matrix
LW = pinv(H') * T';