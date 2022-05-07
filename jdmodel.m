%% Lab 3 Main Script
clear all
close all
clc 
cd('/Users/jason/Documents/projects/Biomechanics-Lab-3')

%% Create and apply a summary function for both data files
n = load('normal.mat');
f = load('fast.mat');

[nGRF, nankleForce, nankleMoment, nanklePower, nkneeForce, nkneeMoment,...
 nkneePower, nhipForce, nhipMoment, nhipPower, nstrideLength, ncadence,... 
 nmax] = dataSummary(n.analogdata, n.markerposition);

[fGRF, fankleForce, fankleMoment, fanklePower, fkneeForce, fkneeMoment,...
 fkneePower, fhipForce, fhipMoment, fhipPower, fstrideLength, fcadence,... 
 fmax]= dataSummary(f.analogdata, f.markerposition);

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
