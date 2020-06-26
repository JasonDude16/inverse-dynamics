%% Lab 3 Main Script
clear all
close all
clc 
addpath('/Users/JasonDude/Desktop/Code/Biomechanics/Lab-3-Matlab')

%% Create and apply a summary function for both data files
n = load('normal.mat');
f = load('fast.mat');

[nGRF, nankleForce, nankleMoment, nanklePower, nkneeForce, nkneeMoment,...
 nkneePower, nhipForce, nhipMoment, nhipPower, nstrideLength, ncadence,... 
 nmax] = dataSummary(n.analogdata, n.markerposition);

[fGRF, fankleForce, fankleMoment, fanklePower, fkneeForce, fkneeMoment,...
 fkneePower, fhipForce, fhipMoment, fhipPower, fstrideLength, fcadence,... 
 fmax]= dataSummary(f.analogdata, f.markerposition);

% %% Load data
% load('normal.mat')
% [GRF, COPx, COPz] = analogfilter_v2(analogdata);
% [filterdata] = markerfilter(markerposition);
% 
% %% Assign markers to anatomical joints
% rShldr = filterdata(:, :, 2);
% rTroch = filterdata(:, :, 4);
% rKnee = filterdata(:, :, 5);
% rAnkle = filterdata(:, :, 6);
% rHeel = filterdata(:, :, 7);
% rToe = filterdata(:, :, 8);
% 
% trunkAngle = segmentangle(rShldr, rTroch);
% thighAngle = segmentangle(rTroch, rKnee);
% shankAngle = segmentangle(rKnee, rAnkle);
% footAngle = segmentangle(rHeel, rToe);
% 
% %% Calculate segment angular velocities and accelerations
% Fs = 100; 
% [trunkAngleVel, trunkAngleAcc] = angVelAcc(trunkAngle, Fs);
% [thighAngleVel, thighAngleAcc] = angVelAcc(thighAngle, Fs);
% [shankAngleVel, shankAngleAcc] = angVelAcc(shankAngle, Fs);
% [footAngleVel, footAngleAcc] = angVelAcc(footAngle, Fs);
% 
% %% Calculate joint angular velocities
% hipAngleVel = thighAngleVel - trunkAngleVel;
% kneeAngleVel = shankAngleVel - thighAngleVel;
% ankleAngleVel = footAngleVel - shankAngleVel;
% 
% %% Calculate COM acceleration for each segment
% thighCOM = 0.3612 * (rKnee - rTroch) + rTroch;
% shankCOM = 0.4416 * (rAnkle - rKnee) + rKnee;
% footCOM = 0.4014 * (rToe - rHeel) + rHeel;
% 
% [thighVel, thighAcc] = velAcc(thighCOM, Fs);
% [shankVel, shankAcc] = velAcc(shankCOM, Fs);
% [footVel, footAcc] = velAcc(footCOM, Fs);
% 
% %% Mass and inertia terms
% thighMass = 49.9 .* 0.1478; 
% thighLength = rKnee - rTroch;
% thighInertia = [thighMass .* (thighLength(1,:) .* 0.364).^2;
%                 thighMass .* (thighLength(2,:) .* 0.162).^2;
%                 thighMass .* (thighLength(3,:) .* 0.369).^2];
% 
% 
% shankMass = 49.9 * 0.0481;
% shankLength = rAnkle - rKnee;
% shankInertia = [shankMass .* (shankLength(1,:) .* 0.267).^2;
%                 shankMass .* (shankLength(2,:) .* 0.093).^2;
%                 shankMass .* (shankLength(3,:) .* 0.271).^2];
%                
% footMass = 49.9 * 0.0129;
% footLength = rToe - rAnkle;
% footInertia = [footMass .* (footLength(1,:) .* 0.279).^2;
%                footMass .* (footLength(2,:) .* 0.139).^2;
%                footMass .* (footLength(3,:) .* 0.299).^2];
%             
% %% Perform inverse dynamics
% [ankleForce, ankleMoment] = invDynamics(footMass, footAcc, GRF(1:3,:), ...
% zeros(3, size(GRF, 2)), footInertia, footAngleAcc, footAngleVel, ... 
% footCOM, rAnkle, [COPx'; zeros(1, size(GRF, 2)); COPz']);
%  
% [kneeForce, kneeMoment] = invDynamics(shankMass, shankAcc, ...
% (ankleForce .* -1),(ankleMoment .* -1), shankInertia, shankAngleAcc, ...
% shankAngleVel, shankCOM, rKnee, rAnkle);
% 
% [hipForce, hipMoment] = invDynamics(thighMass, thighAcc, ...
% (kneeForce * -1), (kneeMoment .* -1), thighInertia, thighAngleAcc, ...
% thighAngleVel, thighCOM, rTroch, rKnee);
% 
%% Calculate stride length and cadence
% max1 = rHeel(1,:)-rTroch(1,:);
% max2 = find(islocalmax(max1));
% strideLength = max(max1) + max(max1 .* -1);
% cadence = 60 ./ (((max2(:,2) - max2(:,1)) ./ 2) ./ Fs);
% 
% %% Joint power
% hipPower = dot(hipAngleVel, hipMoment);
% kneePower = dot(kneeAngleVel, kneeMoment);
% anklePower = dot(ankleAngleVel, ankleMoment);

%% Normal moment
plot(nankleMoment(3, (nmax(:,1):nmax(:,2))'));
hold on
plot(nkneeMoment(3, (nmax(:,1):nmax(:,2))'));
hold on
plot(nhipMoment(3, (nmax(:,1):nmax(:,2))'));

%% Fast moment
plot(fankleMoment(3, (fmax(:,1):fmax(:,2))'));
hold on
plot(fkneeMoment(3, (fmax(:,1):fmax(:,2))'));
hold on
plot(fhipMoment(3, (fmax(:,1):fmax(:,2))'));

%% Normal power
plot(nanklePower((nmax(:,1):nmax(:,2))'));
hold on
plot(nkneePower((nmax(:,1):nmax(:,2))'));
hold on
plot(nhipPower((nmax(:,1):nmax(:,2))'));

%% Fast power
plot(fanklePower((fmax(:,1):fmax(:,2))'));
hold on
plot(fkneePower((fmax(:,1):fmax(:,2))'));
hold on
plot(fhipPower((fmax(:,1):fmax(:,2))'));
