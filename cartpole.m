function [observationhist] = cartpole(nNeurons,bias,W,duration,stepsize,action)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

gravity = 9.8;
masscart = 1.0;
masspole = 0.1;
length = 0.5;
total_mass = masspole+masscart;
polemass_length = masspole+length;
x = 0;
x_dot = 0;
theta = 0.0;
theta_dot = 0.0;
force_mag = 10.0;
theta_threshold_radians = 24*(2*pi/360);
x_threshold = 4.8;

neuronstates = zeros(1,nNeurons);

numsteps = duration/stepsize;
observationhist = zeros(numsteps,6);

for i=1:duration/stepsize
    force=action*force_mag;

    costheta=cos(theta);
    sintheta=sin(theta);
    temp = (force+polemass_length*theta_dot*theta_dot*sintheta)/total_mass;
    thetaacc = (gravity*sintheta -costheta*temp)/(length*(4.0/3.0 - masspole*costheta*costheta/total_mass));
    xacc = temp - polemass_length*thetaacc*costheta/total_mass;
    x = x + stepsize*x_dot;
    x_dot = x_dot + stepsize*xacc;
    theta = theta + stepsize*theta_dot;
    theta_dot = theta_dot + stepsize*thetaacc;

    %Slightly modify the values to fit reality
    if theta>pi
        theta = theta-2*pi;
    elseif theta<(-1*pi)
        theta = theta+2*pi;
    end
    theta_dot = clip(theta_dot, -theta_threshold_radians,theta_threshold_radians);
    x_dot = clip(x_dot,-x_threshold,x_threshold); %cartpole cannot physically go faster than some value
    
    observation = [x x_dot cos(theta) theta theta_dot action];
    [action,neuronstates] = ctrnn(nNeurons,bias,W,observation,stepsize, stepsize/10,neuronstates);

    observationhist(i,:) = observation;
end

end