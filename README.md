# Biomechanics-Lab-3
These scripts were created for an Advanced Biomechanics (6390) lab assignment at the University of Utah.

The scripts in this repository calculate inverse dynamics from analog and marker position data, which each had a sampling frequency (Fs) of 100 Hz.

The [jdmodel.m](jdmodel.m) is the main script file. This file loads the data, creates a data summary and creates the plots that are depicted below. The plots show the power and moments of the ankle, knee, and hip during one complete gait cycle during normal and fast walking speeds of one participant. 

The [dataSummary](dataSummary.m) function assigns markers to anatomical joints, and calculates: segment angular velocities and accelerations, joint angular velocities, center of mass acceleration for each segment, mass and inertia terms, stride length, cadence, and joint power.

![moments](images/moments.jpg)
![power](images/power.jpg)
![power_fast](images/power_fast.jpg)

