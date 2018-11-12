function change_width(~,evnt,GHandle, vIdx)

colorBackground = [200 200 200]/255;
alphaBackground = 0.1;
alphaForeground = 1;
lineWidth = 1;
linewidthFactor = 2;
eventRatio = 0.8;

edvLine = evnt.AffectedObject.edvLine;
if all(edvLine)
    linewidthBackground = lineWidth;
    linewidthForeground = lineWidth;
else
    linewidthForeground = lineWidth*linewidthFactor;
    linewidthBackground = lineWidth/linewidthFactor;
end

color = GHandle.Viewer(vIdx).WatchList.colorLine;

for lineIdx = 1 : length(edvLine)
    if (edvLine(lineIdx))
        GHandle.Viewer(vIdx).timeplot.lines1(:,lineIdx).Color = [color(lineIdx,:), alphaForeground];
        GHandle.Viewer(vIdx).timeplot.lines1(:,lineIdx,:).LineWidth = lineWidth;
        
        GHandle.Viewer(vIdx).spectrumplot.lines1(:,lineIdx).Color = [color(lineIdx,:), alphaForeground];
        GHandle.Viewer(vIdx).spectrumplot.lines1(:,lineIdx,:).LineWidth = lineWidth;
    else
        GHandle.Viewer(vIdx).timeplot.lines1(:,lineIdx).Color = [colorBackground, alphaBackground];
        GHandle.Viewer(vIdx).timeplot.lines1(:,lineIdx).LineWidth = linewidthBackground;
        
        GHandle.Viewer(vIdx).spectrumplot.lines1(:,lineIdx).Color = [colorBackground, alphaBackground];
        GHandle.Viewer(vIdx).spectrumplot.lines1(:,lineIdx).LineWidth = linewidthBackground;
    end
end

if sum(edvLine) == 1
    GHandle.Viewer(vIdx).timefrequencyplot.bigaxes.Visible = 'on';
    cla(GHandle.Viewer(vIdx).timefrequencyplot.bigaxes);
    GHandle.Viewer(vIdx).timefrequencyplot.text.Visible = 'off';
    GHandle.Viewer(vIdx).WatchList.timefreq2Plot = edvLine;
    
    GHandle.Viewer(vIdx).timeplot.lines1(edvLine).LineWidth = linewidthForeground;
    uistack(GHandle.Viewer(vIdx).timeplot.lines1(edvLine),'top');
    
    GHandle.Viewer(vIdx).spectrumplot.lines1(edvLine).LineWidth = linewidthForeground;
    uistack(GHandle.Viewer(vIdx).spectrumplot.lines1(edvLine),'top'); 
else
    GHandle.Viewer(vIdx).timefrequencyplot.bigaxes.Visible = 'off';
    cla(GHandle.Viewer(vIdx).timefrequencyplot.bigaxes);
    GHandle.Viewer(vIdx).timefrequencyplot.text.Visible = 'on';
    %GHandle.Viewer(vIdx).timeplot.bigaxes1.YLimMode = 'auto';
end

xRange = GHandle.Viewer(vIdx).timeplot.bigaxes1.XLim;
xVal = cat(1,GHandle.Viewer(vIdx).timeplot.lines1(edvLine).XData)';
yVal = cat(1,GHandle.Viewer(vIdx).timeplot.lines1(edvLine).YData)';
mask = any((xVal>xRange(1) & xVal<xRange(2)),2);
yLimit = [min(yVal(mask,:),[],'all'), max(yVal(mask,:),[],'all')];
GHandle.Viewer(vIdx).timeplot.bigaxes1.YLim = yLimit;
nEvents = length(GHandle.Viewer(vIdx).timeplot.Events);

for iEvents = 1 : 1 : nEvents
    GHandle.Viewer(vIdx).timeplot.Events(iEvents).YData = eventRatio.*yLimit(2).*ones( [1, length(GHandle.Viewer(vIdx).timeplot.Events(iEvents).XData)]);
end

GHandle.Viewer.WatchList.timeLim = xRange;
end

