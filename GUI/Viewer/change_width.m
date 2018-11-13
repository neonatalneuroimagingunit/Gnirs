function change_width(~,evnt,GHandle, vIdx)

colorBackground = [200 200 200]/255;
alphaBackground = 0.03;
alphaForeground = 1;
lineWidth = 1;
linewidthFactor = 2;
eventRatio = 0.8;
edvMarkerSize = 30;
notEdvMarkerSize = 15;
edvLineWidth = 3;
notEdvLineWidth = 1;
notEdvColor = 'k';

edvLine = evnt.AffectedObject.edvLine;
idxLine = find(edvLine);
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
end

 xRange = GHandle.Viewer(vIdx).timeplot.bigaxes1.XLim;
if  GHandle.Viewer(vIdx).Preference.YAutoscale.Value
   
    xVal = cat(1,GHandle.Viewer(vIdx).timeplot.lines1(edvLine).XData)';
    yVal = cat(1,GHandle.Viewer(vIdx).timeplot.lines1(edvLine).YData)';
    mask = any((xVal>xRange(1) & xVal<xRange(2)),2);
    yLimit = [min(yVal(mask,:),[],'all'), max(yVal(mask,:),[],'all')];
    GHandle.Viewer(vIdx).timeplot.bigaxes1.YLim = yLimit;
    nEvents = length(GHandle.Viewer(vIdx).timeplot.Events);
    
    for iEvents = 1 : 1 : nEvents
        GHandle.Viewer(vIdx).timeplot.Events(iEvents).YData = eventRatio.*yLimit(2).*ones( [1, length(GHandle.Viewer(vIdx).timeplot.Events(iEvents).XData)]);
    end
end

GHandle.Viewer(vIdx).WatchList.timeLim = xRange;


%% edv the probe
if all(edvLine)
    set(GHandle.Viewer(vIdx).probeplot.source , 'MarkerSize', notEdvMarkerSize);
    set(GHandle.Viewer(vIdx).probeplot.detector, 'MarkerSize', notEdvMarkerSize);
    set(GHandle.Viewer(vIdx).probeplot.channel, 'LineWidth', notEdvLineWidth, 'Color', notEdvColor);
else
    srcTag = {GHandle.Viewer(vIdx).probeplot.source.Tag}';
    detTag = {GHandle.Viewer(vIdx).probeplot.detector.Tag}';
    chTag = strcat(srcTag(GHandle.Viewer(vIdx).Probe.channel.pairs(:,1)),'_',detTag(GHandle.Viewer(vIdx).Probe.channel.pairs(:,2)));
    lineTag = {GHandle.Viewer(vIdx).timeplot.lines1(edvLine).Tag}';
    for iSource = 1 : length(srcTag)
        maxSrc = sum(contains({GHandle.Viewer(vIdx).timeplot.lines1.Tag},srcTag(iSource)));
        mask = contains(lineTag,srcTag(iSource));
        if sum(mask) == maxSrc
            GHandle.Viewer(vIdx).probeplot.source(iSource).MarkerSize = edvMarkerSize;
        else
            GHandle.Viewer(vIdx).probeplot.source(iSource).MarkerSize = notEdvMarkerSize;
        end
    end
    for iDetector = 1 : length(detTag)
        maxDet = sum(contains({GHandle.Viewer(vIdx).timeplot.lines1.Tag},detTag(iDetector)));
        mask = contains(lineTag,detTag(iDetector));
        if sum(mask) == maxDet
            GHandle.Viewer(vIdx).probeplot.detector(iDetector).MarkerSize = edvMarkerSize;
        else
            GHandle.Viewer(vIdx).probeplot.detector(iDetector).MarkerSize = notEdvMarkerSize;
        end
    end
    for iChannel = 1 : length(chTag)
        mask = contains(lineTag,chTag(iChannel));
        if sum(mask)>1
            GHandle.Viewer(vIdx).probeplot.channel(iChannel).LineWidth = edvLineWidth;
        else
            GHandle.Viewer(vIdx).probeplot.channel(iChannel).LineWidth = notEdvLineWidth;
        end
        
        if sum(mask)== 1
            GHandle.Viewer(vIdx).probeplot.channel(iChannel).Color = GHandle.Viewer(vIdx).timeplot.lines1(idxLine(mask)).Color;
        else
            GHandle.Viewer(vIdx).probeplot.channel(iChannel).Color = notEdvColor;
        end
    end
end


end

