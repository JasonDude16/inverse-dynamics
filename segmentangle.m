function [segAngle] = segmentangle(proximal, distal)

% This function will solve for the orientation angle of a segment with
% respet to the global reference system. For lab 3 in KINES 6390, all
% motion is restricted to the sagittal plane, therefore the z-axis is
% aligned with the global reference frame at all times

[s1,s2,s3] = size(proximal); % s2 is time, if using filtered data

sagittalPlane = [1 0 0;
                0 1 0;
                0 0 0];

for n = 1:s2
    
    p = sagittalPlane * proximal(:,n);
    d = sagittalPlane * distal(:,n);
    
    %% Define anatomical frame
    
    zA = [0; 0; 1];
    yA = p - d;
    xA = cross(yA, zA);
    zA = cross(xA, yA);
    
    G2A = [xA./(norm(xA)), yA./(norm(yA)), zA./(norm(zA))]';
    
    theta(2) = asin(G2A(3,1));
    theta(1) = acos(G2A(3,3)./cos(theta(2)));
    theta(3) = asin(G2A(2,1)./(-cos(theta(2))));
    
    segAngle(:,n) = theta;
    
end

minTheta = min(segAngle(3,:));
maxTheta = max(segAngle(3,:));

if minTheta > 0 && maxTheta > pi/4
    
    for n = 1:s2
        
        p = sagittalPlane * proximal(:,n);
        d = sagittalPlane * distal(:,n);
        
        %% Define anatomical frame
        
        zA = [0; 0; 1];
        yA = p - d;
        xA = cross(yA, zA);
        zA = cross(xA, yA);
        
        G2A = [xA./norm(xA), yA./norm(yA), zA./norm(zA)]';
        
        theta(2) = asin(G2A(3,1));
        theta(1) = acos(G2A(3,3)./cos(theta(2)));
        theta(3) = acos(G2A(1,1)./(cos(theta(2))));
       
        segAngle(:,n) = theta;
        
    end
    
end

end
    