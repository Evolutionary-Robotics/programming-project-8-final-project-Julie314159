function [W,bias] = makePhenotype(genotype,biasrange,weightrange,nNeurons)
%UNTITLED Summary of this function goes here
%   Converts a 1xn array into a phenotype with weights and biases, scaling
%   them accordingly

W = zeros(nNeurons,nNeurons);

bias = biasrange*genotype(1:nNeurons); %should be a column
for i=1:nNeurons
    W(i,:) = weightrange*genotype(i*nNeurons +1 : (i+1)*nNeurons);
end

% alteration = 1-ones(nNeurons,nNeurons);
% W = W.*alterattion; %removes recursive connections