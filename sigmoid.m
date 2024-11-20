function [S] = sigmoid(x)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
S = 1./(1+exp(-x));
end