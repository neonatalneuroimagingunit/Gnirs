function setselectedtrack(obj, ~, evnt)

colorBackground = [200 200 200]/255;
alphaBackground = 0.3;
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

xRange = obj.Panel.Plot.Time.MainAxes.XLim;

if all(edvLine)
    linewidthBackground = lineWidth;
    linewidthForeground = lineWidth;
else
    linewidthForeground = lineWidth*linewidthFactor;
    linewidthBackground = lineWidth/linewidthFactor;
end

color = obj.WatchList.colorLine;

for lineIdx = 1:1:length(edvLine)
    if (edvLine(lineIdx))
        obj.Panel.Plot.Time.Lines(lineIdx).Color = [color(lineIdx,:), alphaForeground];
        obj.Panel.Plot.Time.Lines(lineIdx).LineWidth = lineWidth;
        
        obj.Panel.Plot.Frequency.Lines(lineIdx).Color = [color(lineIdx,:), alphaForeground];
        obj.Panel.Plot.Frequency.Lines(lineIdx).LineWidth = lineWidth;
    else
        obj.Panel.Plot.Time.Lines(lineIdx).Color = [colorBackground, alphaBackground];
        obj.Panel.Plot.Time.Lines(lineIdx).LineWidth = linewidthBackground;
        
        obj.Panel.Plot.Frequency.Lines(lineIdx).Color = [colorBackground, alphaBackground];
        obj.Panel.Plot.Frequency.Lines(lineIdx).LineWidth = linewidthBackground;
    end
end

if sum(edvLine) == 1
    obj.Panel.Plot.TimeFrequency.MainAxes.Visible = 'on';
    cla(obj.Panel.Plot.TimeFrequency.MainAxes);
    obj.Panel.Plot.TimeFrequency.Text.Visible = 'off';
    obj.WatchList.timefreq2Plot = edvLine;
    
    obj.Panel.Plot.Time.Lines(edvLine).LineWidth = linewidthForeground;
    obj.Panel.Plot.Frequency.Lines(edvLine).LineWidth = linewidthForeground;
else
    obj.Panel.Plot.TimeFrequency.MainAxes.Visible = 'off';
    cla(obj.Panel.Plot.TimeFrequency.MainAxes);
    obj.Panel.Plot.TimeFrequency.Text.Visible = 'on';
end
uistack(obj.Panel.Plot.Time.Lines(edvLine),'top');
uistack(obj.Panel.Plot.Frequency.Lines(edvLine),'top');

if  obj.Panel.Preference.CheckBoxYAutoscale.Value
    xVal = cat(1,obj.Panel.Plot.Time.Lines(edvLine).XData)';
    yVal = cat(1,obj.Panel.Plot.Time.Lines(edvLine).YData)';
    mask = any((xVal>=xRange(1) & xVal<=xRange(2)),2);
    yLimit = [min(yVal(mask,:),[],'all'), max(yVal(mask,:),[],'all')];
    obj.Panel.Plot.Time.MainAxes.YLim = yLimit;
    nEvents = length(obj.Panel.Plot.Time.Events);
    
    for iEvents = 1:1:nEvents
        obj.Panel.Plot.Time.Events(iEvents).YData = ...
            eventRatio.*yLimit(2).*ones( [1, length(obj.Panel.Plot.Time.Events(iEvents).XData)]);
    end
end

obj.WatchList.timeLim = xRange;

%% Update probe
if ~isempty(obj.Dataset.Probe)
    if all(edvLine)
        set(obj.Panel.Probe.Source, 'MarkerSize', notEdvMarkerSize);
        set(obj.Panel.Probe.Detector, 'MarkerSize', notEdvMarkerSize);
        set(obj.Panel.Probe.Channel, 'LineWidth', notEdvLineWidth, 'Color', notEdvColor);
    else
        srcTag = {obj.Panel.Probe.Source.Tag}';
        detTag = {obj.Panel.Probe.Detector.Tag}';
        chTag = strcat(srcTag(obj.Dataset.Probe.channel.pairs(:,1)), '_', detTag(obj.Dataset.Probe.channel.pairs(:,2)));
        lineTag = {obj.Panel.Plot.Time.Lines(edvLine).Tag}';
        
        for iChannel = 1:length(chTag)
            mask = contains(lineTag,chTag(iChannel));
            if sum(mask)>1
                obj.Panel.Probe.Channel(iChannel).LineWidth = edvLineWidth;
            else
                obj.Panel.Probe.Channel(iChannel).LineWidth = notEdvLineWidth;
            end
            
            if sum(mask)== 1
                obj.Panel.Probe.Channel(iChannel).Color = obj.Panel.Plot.Time.Lines(idxLine(mask)).Color;
                uistack(obj.Panel.Probe.Channel(iChannel), 'top');
            else
                obj.Panel.Probe.Channel(iChannel).Color = notEdvColor;
            end
        end
        for iSource = 1:length(srcTag)
            maxSrc = sum(contains({obj.Panel.Plot.Time.Lines.Tag}, srcTag(iSource)));
            mask = contains(lineTag, srcTag(iSource));
            if sum(mask) == maxSrc
                obj.Panel.Probe.Source(iSource).MarkerSize = edvMarkerSize;
            else
                obj.Panel.Probe.Source(iSource).MarkerSize = notEdvMarkerSize;
            end
        end
        for iDetector = 1:length(detTag)
            maxDet = sum(contains({obj.Panel.Plot.Time.Lines.Tag}, detTag(iDetector)));
            mask = contains(lineTag, detTag(iDetector));
            if sum(mask) == maxDet
                obj.Panel.Probe.Detector(iDetector).MarkerSize = edvMarkerSize;
            else
                obj.Panel.Probe.Detector(iDetector).MarkerSize = notEdvMarkerSize;
            end
        end
        
    end
end

%% Update channel table
% tableIdx = find(contains(GHandle.Viewer.DataPanel.TrackTable.Data(:,end),{GHandle.Viewer.PlotPanel.Time.Lines(edvLine).Tag}));
% for iRow = 1:size(obj.Panel.Data.Track.Table.Data,1)
%     lineMask = strcmp({obj.Panel.Plot.Time.Lines.Tag}, obj.Panel.Data.Track.Table.Data(iRow,end));
%     for iCol = 1:5
%         GHandle.Viewer.DataPanel.Track.Table.setCellColor(iRow,iCol,GHandle.Viewer.PlotPanel.Time.Lines(lineMask).Color);
%     end
% end
end

