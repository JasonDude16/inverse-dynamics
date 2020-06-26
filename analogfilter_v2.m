%Filter FP analog data
function [GRF,COPx,COPz]= analogfilter_v2(analogdata)
%load('normal.mat');
h=.002;
%filter analog force plate data
[a,b]=butter(2,10/500);
filterdata=filtfilt(a,b,analogdata);
DSfilterdata=downsample(filterdata,10);
RawData=DSfilterdata/2;
% Forceplate calibration matrix
c = [ 863.0   -11.2    -5.5    0.1    2.5   -3.3;...
       22.6   855.5   -13.4   -7.5    6.0   -3.7;...
      -37.3     -.5  1805.6   -1.6  -11.2  -17.1;...
       -3.4   -72.9    -2.6  908.3   -2.7    2.8;...
       73.8    -3.3     0.1   -1.5  908.9    6.5;...
        1.8    -5.0     1.4    3.8    3.3  302.1];


Force=c*RawData';

for n=1:length(Force)
    if Force(3,n)>45.4
        COP_exists(n,1)=1;
        y(n,1)=(-h*Force(2,n)+Force(4,n))/Force(3,n);
        x(n,1)=(-h*Force(1,n)-Force(5,n))/Force(3,n);
    else
        COP_exists(n,1)=0;
        x(n,1)=0;
        y(n,1)=0;
    end

end


COPx=-x+.45;
COPz=-y+.45;
F2V=[0  -1  0   0   0   0;
    -1  0   0   0   0   0;
    0   0   -1  0   0   0;
    0   0   0   0   -1  0;
    0   0   0   -1  0   0;
    0   0   0   0   0   -1];
V2I=[0  1   0   0   0   0;
    0   0   1   0   0   0;
    1   0   0   0   0   0;
    0   0   0   0   1   0;
    0   0   0   0   0   1;
    0   0   0   1   0   0];
ForceGCS = V2I*F2V*Force;
GRF=-ForceGCS;
for m=1:length(COP_exists)
    if COP_exists(m,1)<=0;
        COPx(m,1)=0;
        COPz(m,1)=0;
        for q=1:6;
            GRF(q,m)=0;
        end
    end
end
%{
figure(1)
plot(x)
title('COP X')
figure(2)
plot(y)
title('COP Y')

%calculate GRF
figure(3)
%Fx
plot(GRF(2,:))
figure(4)
%Fy
plot(GRF(1,:))
figure(5)
%Fz
plot(GRF(3,:))
%}
end