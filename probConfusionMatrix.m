function [probMatrices] = probConfusionMatrix(matrices)
%PROBCONFUSIONMATRIX Summary of this function goes here
%   Detailed explanation goes here
probMatrices = {};
for i = 1:length(matrices)
    m = matrices{i};
    total0 = m(1,1)+m(2,1);
    total1 = m(1,2)+m(2,2);
    newM(1,1) = m(1,1)/total0;
    newM(1,2) = m(1,2)/total1;
    newM(2,1) = m(2,1)/total0;
    newM(2,2) = m(2,2)/total1;
    probMatrices{i} = newM;
end
end

