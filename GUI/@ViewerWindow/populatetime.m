function populatetime(obj , ~, eventData)

foregroundColor = obj.Preference.foregroundColor;
eventColor = lines(size(obj.Dataset.Event.Dictionary,1));
eventRatio = 0.8;
showEvents = {'off', 'on'};

Probe =  obj.Dataset.Probe;
Data = eventData.AffectedObject.time2Plot;
lineLabels = Data.Properties.VariableNames(2:end);

nLines = size(Data,2) - 1; % one is the time column

cla(obj.Panel.Plot.Time.MainAxes);
cla(obj.Panel.Plot.Time.SmallAxes);

%% Plot events
yMax = obj.Panel.Plot.Time.MainAxes.YLim(2);
nEventType = size(obj.Dataset.Event.Dictionary,1);
for iEventType = 1 : nEventType
    eventMask = obj.Dataset.Event.type == iEventType;
    obj.Panel.Plot.Time.Events(iEventType) = stem(obj.Panel.Plot.Time.MainAxes,...
        obj.Dataset.Event.startTime(eventMask), eventRatio.*yMax.*ones(size(obj.Dataset.Event.startTime(eventMask))),...
        'Color', eventColor(iEventType,:), ...
        'Marker', '.', ...
        'MarkerSize', 30, ...
        'ShowBaseLine', 'off', ...
        'Visible', showEvents{obj.Panel.Preference.ShowEvent.Value + 1}, ...
        'LineWidth', 2);
end

%% Plot lines in main and support axes
for iLines = 1 : nLines
     obj.Panel.Plot.Time.Lines(iLines) = plot(Data{:,1}, Data{:, iLines + 1},...
        'LineWidth', 1, 'LineStyle', '-',...
        'buttonDownFcn', {@line_callback obj},...
        'Color', obj.WatchList.colorLine(iLines,:),...
        'DisplayName', lineLabels{iLines},...
        'Tag', lineLabels{iLines},...
        'Parent', obj.Panel.Plot.Time.MainAxes);
    
    obj.Panel.Plot.Time.SmallLines(iLines) = plot(Data{:,1}, Data{:, iLines + 1},...
        'LineWidth', 1, 'LineStyle', '-',...
        'Color', obj.WatchList.colorLine(iLines,:),...
        'HitTest', 'off',...
        'Parent', obj.Panel.Plot.Time.SmallAxes);
end
obj.Panel.Plot.Time.Lines((nLines+1):end) = [];
obj.Panel.Plot.Time.SmallLines((nLines+1):end) = [];

%% Resize event height
yVal = obj.Panel.Plot.Time.MainAxes.YLim(2);
for iEvents = 1:1:nEventType
    obj.Panel.Plot.Time.Events(iEvents).YData = ...
        eventRatio.*max(yVal).*ones( [1, length(obj.Panel.Plot.Time.Events(iEvents).XData)]);
end
%% Set axes properties
obj.Panel.Plot.Time.MainAxes.YAxis.Exponent = 0;
obj.Panel.Plot.Time.Time.MainAxes.XLabel.String = 'Time (s)';
obj.Panel.Plot.Time.Time.MainAxes.YLabel.String = 'Intensity (a.u.)';

obj.Panel.Plot.Time.Time.SupportAxes.XLabel.String = 'Time (samples)';
obj.Panel.Plot.Time.Time.SupportAxes.YTickLabel = [];
obj.Panel.Plot.Time.Time.SupportAxes.XLim = [1 size(Data,1)];

%% Create stuff in support axes
obj.Panel.Plot.Time.Rectangle = rectangle(...
    'Parent', obj.Panel.Plot.Time.SmallAxes,...
    'Curvature', [0 0], 'EdgeColor', foregroundColor,...
    'HitTest', 'off');

obj.Panel.Plot.Time.TxtSeconds = text(0, 0, '',...
    'HorizontalAlignment', 'center',...
    'FontWeight', 'bold',...
    'Color', foregroundColor, ...
    'HitTest', 'off',...
    'FontSize', 8,...
    'Parent',obj.Panel.Plot.Time.SmallAxes);

obj.Panel.Plot.Time.TxtSamples = text(0, 0, '',...
    'HorizontalAlignment', 'center',...
    'FontWeight', 'bold',...
    'Color', foregroundColor, ...
    'HitTest', 'off',...
    'FontSize', 8,...
    'Parent', obj.Panel.Plot.Time.SmallAxes);


%% Channel table
srcIdx = zeros(nLines,1);
detIdx = zeros(nLines,1);
detLabel = zeros(nLines,1);
srcLabel = zeros(nLines,1);
waveLength = zeros(nLines,1);
distance = zeros(nLines,1);

if ~isempty(Probe)
    for iLines = 1:1:nLines
        srcIdx(iLines) = str2double(lineLabels{iLines}(11:13));
        detIdx(iLines) = str2double(lineLabels{iLines}(16:18));
        waveLength(iLines) = str2double(lineLabels{iLines}(6:8));
        srcLabel(iLines) = srcIdx(iLines);
        detLabel(iLines) = detIdx(iLines);
    end
    distance =  vecnorm((Probe.source.position(srcIdx,:)-Probe.detector.position(detIdx,:)),2,2);
end

obj.Panel.Data.Track.Table.Data = [...
    num2cell(srcLabel), ...
    num2cell(detLabel),...
    num2cell(waveLength),...
    num2cell(distance),...
    lineLabels', ...
    ];

%% Event table
obj.Panel.Data.Event.Table.Data = [...
    obj.Dataset.Event.Dictionary(obj.Dataset.Event.type,2), ...
    obj.Dataset.Event.Dictionary(obj.Dataset.Event.type,1), ...
    num2cell(obj.Dataset.Event.startTime), ...
    num2cell(obj.Dataset.Event.durationTime), ...
    ];

obj.WatchList.timeLim = [obj.Dataset.Data.Time.Time(1),...
    obj.Dataset.Data.Time.Time(end)];

if isempty(obj.WatchList.edvLine)
   obj.WatchList.edvLine = true(size(obj.Panel.Plot.Time.SmallLines));
else
    obj.WatchList.edvLine = obj.WatchList.edvLine;
end
end

function line_callback(hObject, ~, obj)
lineIdx = obj.Panel.Plot.Time.Lines == hObject;
if lineIdx == obj.WatchList.edvLine
    obj.WatchList.edvLine = true(size(obj.WatchList.edvLine));
else
    obj.WatchList.edvLine = lineIdx;
end

end
