function [outputNeuron,y] = ctrnn(nNeurons,bias,W,observation,calcduration,dt,prevstates)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%y=zeros(1,nNeurons); %row
%y=2*rand(1,nNeurons)-1;

observation(4) = sin(observation(4));
%TODO: move this to the cartpole function

y=prevstates;
output = sigmoid(y.'+ bias);

Ii = zeros(1,nNeurons); %Should be a row
%Ii(1:3) = [observation(1) observation(3) observation(6)]; %Use for 4
%neurons or more
Ii(1:6) = observation; %Use for 7 neurons or more
Tau = ones(1,nNeurons);


yhist = zeros(nNeurons,calcduration/dt);
outputhist = zeros(nNeurons,calcduration/dt);

for i=1:calcduration/dt
     y = y + (dt*1./Tau).*(-y + (W*output).'+Ii);
    yhist(:,i) = y;
    output = sigmoid(y.'+bias);
    outputhist(:,i) = output;
end
outputNeuron = output(nNeurons); %output is the last neuron
end


