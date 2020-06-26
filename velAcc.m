function [v, a] = velAcc(pos, Fs)

%% This function will calculate the linear velocity and linear acceleration
%% based on positional data pos and sampling frequency Fs

dt = 1/Fs; 
[s1, s2] = size (pos);
v = NaN(s1, s2);
a = NaN(s1, s2);

for t = 2:s2 - 1
    
    v(:,t) = (pos(:, t + 1) - pos(:, t - 1))./ (2*dt); 
    a(:,t) = (pos(:, t + 1) - 2.*(pos(:,t)) + pos(:, t - 1))./ (dt^2); 
end
end
