
%<!-- saved from url=(0104)https://scholar.vt.edu/access/content/group/1cace063-fe6c-4db4-999a-b6080e2f60d2/week%209/markerviewer.m -->
%<html><head><meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"></head><body><pre style="word-wrap: break-word; white-space: pre-wrap;">% markerviewer
% This script views marker positions in the global coordinate system.
%close all;
fprintf('Press or hold ''enter'' to scroll through data.\n');
%delay = .05;  %increase this number to slow down animation
numofmarkers=size(markerposition,2);
%tl=size(markerposition,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% setup figure to view data
figure(12);
ssize = get(0,'ScreenSize');
cax=newplot;
set(cax,'DataAspectRatio',[1 1 1]);
set(cax,'XLim',[-2 3],'YLim',[0 2]);
cf=get(cax,'Parent');
set(cf,'Position',[.5*ssize(3) (.05*ssize(4)) .5*ssize(3) .35*ssize(4)]);
set(cf,'DoubleBuffer','on');
set(cax,'NextPlot','replacechildren');
cla;  % clears axes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plots marker data (side view)
for i=1:1:size(markerposition,1),
  	plot(markerposition(i,1:numofmarkers,2),markerposition(i,1:numofmarkers,3),'ko',...
        markerposition(i,4:8,2),markerposition(i,4:8,3),'ro');
    text(0,.1,num2str(i));
  	drawnow;
  	pause;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear extraneous variables

clear a b cax cf ds i marker markerstobeviewed ssize numofmarkers
clear tl delay view
%</pre></body></html>