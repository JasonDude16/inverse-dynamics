function [omega, alpha] = angVelAcc(theta, Fs)

% This functinon will calculate the instantaneous angular velocity and
% accleration of a segment given the segment's orientation angle theta and
% the sampling frequency Fs

dt = 1/Fs;

[s1, s2] = size(theta);
omega = NaN(s1, s2); 
alpha = NaN(s1, s2);


for t = 2:s2-1
    
    thetaDot = (theta(:, t + 1) - theta(:, t - 1))./ (dt * 2);
    
    rotMat = [cos(theta(2,t)).*cos(theta(3,t)), sin(theta(3,t)), 0;
             -cos(theta(2,t)).*sin(theta(3,t)), cos(theta(3,t)), 0;
             sin(theta(2,t)),                  0              , 1];
    
    omega(:,t) = rotMat * thetaDot;
    
end


for t = 2:s2 - 1
    
    omegaDot = (omega(:,t + 1) - omega(:, t - 1))./ (dt * 2);
    
    alpha(:,t) = omegaDot;
    
end


end

             
            
            
