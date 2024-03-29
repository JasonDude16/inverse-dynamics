# Inverse Dynamics Analysis
The scripts in this repository calculate inverse dynamics from analog and marker position data. The [jdmodel.m](jdmodel.m) is the main script file. This file loads the data, assigns markers to anatomical joints and calculates segment angular velocities and accelerations, joint angular velocities, center of mass acceleration for each segment, mass and inertia terms, stride length, cadence, and joint power. The plots show the power and moments of the ankle, knee, and hip during one complete gait cycle during normal and fast walking speeds of one participant. 

### Moment during normal and fast gait cycle
![moments](images/moments.jpg)

### Power during normal and fast gait cycle
![power](images/power.jpg)
![power_fast](images/power_fast.jpg)