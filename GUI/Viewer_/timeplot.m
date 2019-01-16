function timeplot(~, eventData, GHandle, vIdx)

foregroundColor = GHandle.Preference.Theme.foregroundColor;
eventColor = lines(size(GHandle.Viewer(vIdx).Event.Dictionary,1));
eventRatio = 0.8;


Probe =  GHandle.Viewer(vIdx).Probe;
Data = eventData.AffectedObject.time2Plot;
lineLabels = Data.Properties.VariableNames(2:end);




nLines = size(Data,2) - 1;% one is the time column

cla(GHandle.Viewer(vIdx).timeplot.bigaxes1);
cla(GHandle.Viewer(vIdx).timeplot.smallaxes);
%% plot the events
yMax = GHandle.Viewer(vIdx).timeplot.bigaxes1.YLim(2);
nEventType = size(GHandle.Viewer(vIdx).Event.Dictionary,1);
for iEventType = 1 : nEventType
    eventMask = GHandle.Viewer(vIdx).Event.type == iEventType;
    GHandle.Viewer(vIdx).timeplot.Events(iEventType) = stem(GHandle.Viewer(vIdx).timeplot.bigaxes1,...
        GHandle.Viewer(vIdx).Event.startTime(eventMask), eventRatio.*yMax.*ones(size(GHandle.Viewer(vIdx).Event.startTime(eventMask))),...
        'Color',eventColor(iEventType,:), ...
        'Marker', '.', ...
        'MarkerSize', 30, ...
        'LineWidth', 2);
end

%% plot the line in the main and small axes
srcIdx = zeros(nLines,1);
detIdx = zeros(nLines,1);
detLabel = zeros(nLines,1);
srcLabel = zeros(nLines,1);
waveLength = zeros(nLines,1);
for iLines = 1 : nLines
    GHandle.Viewer(vIdx).timeplot.lines1(iLines) = plot(Data{:,1}, Data{:, iLines + 1},...
        'LineWidth', 1, 'LineStyle', '-',...
        'buttonDownFcn', {@line_callback , GHandle, vIdx},...
        'Color', GHandle.Viewer(vIdx).WatchList.colorLine(iLines,:),...
        'DisplayName', lineLabels{iLines},...
        'Tag', lineLabels{iLines},...
        'Parent', GHandle.Viewer(vIdx).timeplot.bigaxes1);
    
    GHandle.Viewer(vIdx).timeplot.lines2(iLines) = plot(Data{:,1}, Data{:, iLines + 1},...
        'LineWidth', 1, 'LineStyle', '-',...
        'Color', GHandle.Viewer(vIdx).WatchList.colorLine(iLines,:),...
        'HitTest', 'off',...
        'Parent', GHandle.Viewer(vIdx).timeplot.smallaxes);
    
    srcIdx(iLines) = str2double(lineLabels{iLines}(11:13));
    detIdx(iLines) = str2double(lineLabels{iLines}(16:18));
    waveLength(iLines) = str2double(lineLabels{iLines}(6:8));
    srcLabel(iLines) = srcIdx(iLines);
    detLabel(iLines) = detIdx(iLines);
    
end
GHandle.Viewer(vIdx).timeplot.lines1((nLines+1):end) = [];
GHandle.Viewer(vIdx).timeplot.lines2((nLines+1):end) = [];

%% resize event height
yVal = GHandle.Viewer(vIdx).timeplot.bigaxes1.YLim(2);
for iEvents = 1 : 1 : nEventType
    GHandle.Viewer(vIdx).timeplot.Events(iEvents).YData = eventRatio.*max(yVal).*ones( [1, length(GHandle.Viewer(vIdx).timeplot.Events(iEvents).XData)]);
end
%% set the axes

GHandle.Viewer(vIdx).timeplot.bigaxes1.YAxis.Exponent = 0;
GHandle.Viewer(vIdx).timeplot.bigaxes1.XLabel.String = 'Time (s)';
GHandle.Viewer(vIdx).timeplot.bigaxes1.YLabel.String = 'Intensity (a.u.)';

GHandle.Viewer(vIdx).timeplot.bigaxes2.XLabel.String = 'Time (samples)';
GHandle.Viewer(vIdx).timeplot.bigaxes2.YTickLabel = [];
GHandle.Viewer(vIdx).timeplot.bigaxes2.XLim = [1 size(Data,1)];


%% build up the small aexes object
GHandle.Viewer(vIdx).timeplot.rectangle = rectangle(...
    'Parent', GHandle.Viewer(vIdx).timeplot.smallaxes,...
    'Curvature', [0 0], 'EdgeColor', foregroundColor,...
    'HitTest', 'off');

GHandle.Viewer(vIdx).timeplot.txt_seconds = text(0, 0, '',...
    'HorizontalAlignment', 'center',...
    'FontWeight', 'bold',...
    'Color', foregroundColor, ...
    'HitTest', 'off',...
    'FontSize', 8,...
    'Parent', GHandle.Viewer(vIdx).timeplot.smallaxes);

GHandle.Viewer(vIdx).timeplot.txt_samples = text(0, 0, '',...
    'HorizontalAlignment', 'center',...
    'FontWeight', 'bold',...
    'Color', foregroundColor, ...
    'HitTest', 'off',...
    'FontSize', 8,...
    'Parent', GHandle.Viewer(vIdx).timeplot.smallaxes);

GHandle.Viewer(vIdx).WatchList.timeLim = [GHandle.CurrentDataSet.Data.Time(1),...
    GHandle.CurrentDataSet.Data.Time(end)];

if isempty(GHandle.Viewer(vIdx).WatchList.edvLine)
    GHandle.Viewer(vIdx).WatchList.edvLine = true(size(GHandle.Viewer(vIdx).timeplot.lines2));
else
    GHandle.Viewer(vIdx).WatchList.edvLine = GHandle.Viewer(vIdx).WatchList.edvLine;
end

%% Channel table
distance =  vecnorm((Probe.source.position(srcIdx,:)-Probe.detector.position(detIdx,:)),2,2);
GHandle.Viewer(vIdx).channelPanel.channeltable.Data = [...
    num2cell(srcLabel), ...
    num2cell(detLabel),...
    num2cell(waveLength),...
    num2cell(distance),...
    lineLabels', ...
    ];

%% Event table
GHandle.Viewer(vIdx).channelPanel.eventtable.Data = [...
    GHandle.Viewer(vIdx).Event.Dictionary(GHandle.Viewer(vIdx).Event.type,2), ...
    GHandle.Viewer(vIdx).Event.Dictionary(GHandle.Viewer(vIdx).Event.type,1), ...
    num2cell(GHandle.Viewer(vIdx).Event.startTime), ...
    num2cell(GHandle.Viewer(vIdx).Event.durationTime), ...
    ];

end


function line_callback(hObject, ~, GHandle, vIdx)

lineIdx = GHandle.Viewer(vIdx).timeplot.lines1 == hObject;


if lineIdx == GHandle.Viewer(vIdx).WatchList.edvLine
    GHandle.Viewer(vIdx).WatchList.edvLine = true(size(GHandle.Viewer(vIdx).WatchList.edvLine));
else
    GHandle.Viewer(vIdx).WatchList.edvLine = lineIdx;
end

end
