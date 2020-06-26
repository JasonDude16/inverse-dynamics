function [proxF, proxM] = invDynamics(mass, acc, distalF, distM, ... 
                                      inertia, angAcc, angVel, posCoM, ... 
                                      posProxJoint, posDistJoint)

%% This function performns inverse dynamics when given the appropriate
%% inputs

i = inertia;

rP = posProxJoint - posCoM;
rD = posDistJoint - posCoM;
    
proxF = [(mass .* acc(1,:)) - distalF(1,:);
         (mass .* acc(2,:)) - distalF(2,:) - (mass .* (-9.81));
         (mass .* acc(3,:)) - distalF(3,:)];

proxMF = cross(rP, proxF);
distMF = cross(rD, distalF);

proxM = [(i(1,:) .* angAcc(1,:)) + (i(3,:) - i(2,:)) .* (angVel(2,:) .* angVel(3,:)) - proxMF(1,:) - distM(1,:) - distMF(1,:);
         (i(2,:) .* angAcc(2,:)) + (i(1,:) - i(3,:)) .* (angVel(3,:) .* angVel(1,:)) - proxMF(2,:) - distM(2,:) - distMF(2,:);
         (i(3,:) .* angAcc(3,:)) + (i(2,:) - i(1,:)) .* (angVel(1,:) .* angVel(2,:)) - proxMF(3,:) - distM(3,:) - distMF(3,:)];

end



