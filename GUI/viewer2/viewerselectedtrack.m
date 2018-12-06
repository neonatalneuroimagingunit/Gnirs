function viewerselectedtrack(~,evnt, GHandle, vIdx, viewerC)

colorBackground = [200 200 200]/255;
alphaBackground = 0.03;
alphaForeground = 1;
lineWidth = 1;
linewidthFactor = 2;
eventRatio = 0.8;
edvMarkerSize = 30;
notEdvMarkerSize = 15;
edvLineWidth = 3;
notEdvLineWidth = 0.5;
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
        GHandle.Viewer(vIdx).PlotPanel.Time.Lines(:,lineIdx).Color = [color(lineIdx,:), alphaForeground];
        GHandle.Viewer(vIdx).PlotPanel.Time.Lines(:,lineIdx,:).LineWidth = lineWidth;
        
        GHandle.Viewer(vIdx).PlotPanel.Frequency.Lines(:,lineIdx).Color = [color(lineIdx,:), alphaForeground];
        GHandle.Viewer(vIdx).PlotPanel.Frequency.Lines(:,lineIdx,:).LineWidth = lineWidth;
    else
        GHandle.Viewer(vIdx).PlotPanel.Time.Lines(:,lineIdx).Color = [colorBackground, alphaBackground];
        GHandle.Viewer(vIdx).PlotPanel.Time.Lines(:,lineIdx).LineWidth = linewidthBackground;
        
        GHandle.Viewer(vIdx).PlotPanel.Frequency.Lines(:,lineIdx).Color = [colorBackground, alphaBackground];
        GHandle.Viewer(vIdx).PlotPanel.Frequency.Lines(:,lineIdx).LineWidth = linewidthBackground;
    end
end

if sum(edvLine) == 1
    GHandle.Viewer(vIdx).PlotPanel.TimeFrequency.MainAxes.Visible = 'on';
    cla(GHandle.Viewer(vIdx).PlotPanel.TimeFrequency.MainAxes);
    GHandle.Viewer(vIdx).PlotPanel.TimeFrequency.Text.Visible = 'off';
    GHandle.Viewer(vIdx).WatchList.timefreq2Plot = edvLine;
    
    GHandle.Viewer(vIdx).PlotPanel.Time.Lines(edvLine).LineWidth = linewidthForeground;
    uistack(GHandle.Viewer(vIdx).PlotPanel.Time.Lines(edvLine),'top');
    
    GHandle.Viewer(vIdx).PlotPanel.Frequency.Lines(edvLine).LineWidth = linewidthForeground;
    uistack(GHandle.Viewer(vIdx).PlotPanel.Frequency.Lines(edvLine),'top');
else
    GHandle.Viewer(vIdx).PlotPanel.TimeFrequency.MainAxes.Visible = 'off';
    cla(GHandle.Viewer(vIdx).PlotPanel.TimeFrequency.MainAxes);
    GHandle.Viewer(vIdx).PlotPanel.TimeFrequency.Text.Visible = 'on';
end

xRange = GHandle.Viewer(vIdx).PlotPanel.Time.MainAxes.XLim;
if  GHandle.Viewer(vIdx).PreferencePanel.YAutoscale.Value
    
    xVal = cat(1,GHandle.Viewer(vIdx).PlotPanel.Time.Lines(edvLine).XData)';
    yVal = cat(1,GHandle.Viewer(vIdx).PlotPanel.Time.Lines(edvLine).YData)';
    mask = any((xVal>xRange(1) & xVal<xRange(2)),2);
    yLimit = [min(yVal(mask,:),[],'all'), max(yVal(mask,:),[],'all')];
    GHandle.Viewer(vIdx).PlotPanel.Time.MainAxes.YLim = yLimit;
    nEvents = length(GHandle.Viewer(vIdx).PlotPanel.Time.Events);
    
    for iEvents = 1 : 1 : nEvents
        GHandle.Viewer(vIdx).PlotPanel.Time.Events(iEvents).YData = ...
            eventRatio.*yLimit(2).*ones( [1, length(GHandle.Viewer(vIdx).PlotPanel.Time.Events(iEvents).XData)]);
    end
end

GHandle.Viewer(vIdx).WatchList.timeLim = xRange;


%% edv the probe
if all(edvLine)
    set(GHandle.Viewer(vIdx).ProbePanel.Source, 'MarkerSize', notEdvMarkerSize);
    set(GHandle.Viewer(vIdx).ProbePanel.Detector, 'MarkerSize', notEdvMarkerSize);
    set(GHandle.Viewer(vIdx).ProbePanel.Channel, 'LineWidth', notEdvLineWidth, 'Color', notEdvColor);
else
    srcTag = {GHandle.Viewer(vIdx).ProbePanel.Source.Tag}';
    detTag = {GHandle.Viewer(vIdx).ProbePanel.Detector.Tag}';
    chTag = strcat(srcTag(viewerC.Probe.channel.pairs(:,1)), '_', detTag(viewerC.Probe.channel.pairs(:,2)));
    lineTag = {GHandle.Viewer(vIdx).PlotPanel.Time.Lines(edvLine).Tag}';
    for iSource = 1:length(srcTag)
        maxSrc = sum(contains({GHandle.Viewer(vIdx).PlotPanel.Time.Lines.Tag}, srcTag(iSource)));
        mask = contains(lineTag, srcTag(iSource));
        if sum(mask) == maxSrc
            GHandle.Viewer(vIdx).ProbePanel.Source(iSource).MarkerSize = edvMarkerSize;
        else
            GHandle.Viewer(vIdx).ProbePanel.Source(iSource).MarkerSize = notEdvMarkerSize;
        end
    end
    for iDetector = 1:length(detTag)
        maxDet = sum(contains({GHandle.Viewer(vIdx).PlotPanel.Time.Lines.Tag}, detTag(iDetector)));
        mask = contains(lineTag, detTag(iDetector));
        if sum(mask) == maxDet
            GHandle.Viewer(vIdx).ProbePanel.Detector(iDetector).MarkerSize = edvMarkerSize;
        else
            GHandle.Viewer(vIdx).ProbePanel.Detector(iDetector).MarkerSize = notEdvMarkerSize;
        end
    end
    for iChannel = 1:length(chTag)
        mask = contains(lineTag,chTag(iChannel));
        if sum(mask)>1
            GHandle.Viewer(vIdx).ProbePanel.Channel(iChannel).LineWidth = edvLineWidth;
        else
            GHandle.Viewer(vIdx).ProbePanel.Channel(iChannel).LineWidth = notEdvLineWidth;
        end
        
        if sum(mask)== 1
            GHandle.Viewer(vIdx).ProbePanel.Channel(iChannel).Color = GHandle.Viewer(vIdx).PlotPanel.Time.Lines(idxLine(mask)).Color;
        else
            GHandle.Viewer(vIdx).ProbePanel.Channel(iChannel).Color = notEdvColor;
        end
    end
end
end

