function x = SolveEquations(A, y)
[m, n] = size(A);
[u, s, v] = svd(A);
s(s < 1e-10) = 0;
for i = 1 : min(m, n)
    if s(i, i) > 0
        s(i, i) = 1 / s(i, i);
    end
end
x = v * s' * u' * y;