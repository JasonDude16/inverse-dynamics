# Biomechanics-Lab-3
The scripts in this repository calculate inverse dynamics from analog and marker position data, which each had a sampling frequency of 100 Hz. 

The jdmodel.m is the main script file. This file loads the data, creates a data summary and creates the plots that are depicted below. The plots show the power and moments of the ankle, knee, and hip throughout the gait cycle during normal and fast walking speeds. The dataSummary function assigns markers to anatomical joints, calculates segment angular velocities and accelerations, joint angular velocities, center of mass acceleration for each segment, mass and inertia terms, stride length, cadence, and joint power.

This analysis can be created, but the file path (which is listed in the jdmodel.m file) will need to be changed by the user. 

![moments](images/moments.jpg)
![power](images/power.jpg)
![power_fast](images/power_fast.jpg)
