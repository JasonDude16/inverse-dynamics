function [filterdata] = markerfilter(markerposition)

% Filter motion capture marker data using 5 Hz low pass, 4th order
% phaseless butterworth filter. This function will also rotate the
% markerposition to align with the global ISB coordinate system 

%% Filter data
[b,a]=butter(2,5/(100/2));
markersFiltered = filtfilt(b,a,markerposition);

%% Permuting filtered data matrix
markersPermuted = permute(markersFiltered, [3,1,2]);

%% Align with ISB
V2I=[0  1   0;
    0   0   1;
    1   0   0];

[j,k, nmarkers] = size(markersPermuted);

    for n=1:nmarkers
    
        filterdata(:,:,n) = V2I * markersPermuted(:,:,n);

    end
end