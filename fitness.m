function [calcfitness,cartpoledata] = fitness(genotype,biasrange,weightrange,nNeurons,stepsize,duration,initialforce)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

[W,bias] = makePhenotype(genotype,biasrange,weightrange,nNeurons);
cartpoledata = cartpole(nNeurons,bias,W,duration,stepsize,initialforce);

%calcfitness = sum(bias)+sum(sum(W));
%calcfitness = sum(sum(cartpoledata.^2*[-0.1;0;1;0;-0.1;-0.01]))/(duration/stepsize);  
        % observation = [x x_dot cos(theta) theta theta_dot action];
%calcfitness = (-0.1*sum(cartpoledata(:,1).^2)-0.1*sum(cartpoledata(:,6).^2)+sum(cartpoledata(:,3)))/(duration/stepsize);
calcfitness = 1 + (-0.1*sum(cartpoledata(:,1).^2)-0.005*sum(cartpoledata(:,6).^2)-0.5*sum(cartpoledata(:,4).^2))/(duration/stepsize);
%calcfitness = 1 -sum(cartpoledata(:,4).^2)/(duration/stepsize);

end