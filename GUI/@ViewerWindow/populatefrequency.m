function populatefrequency(obj,~, eventData)
%SPECTRUMPLOT Summary of this function goes here

foregroundColor = obj.Preference.foregroundColor;
Data = eventData.AffectedObject.spectrum2Plot;
lineLabels = Data.Properties.VariableNames(2:end);
nLines = size(Data,2) - 1;% one is the time column

cla(obj.Panel.Plot.Frequency.MainAxes);
cla(obj.Panel.Plot.Frequency.SmallAxes);

for iLines = 1 : nLines
    obj.Panel.Plot.Frequency.Lines(iLines) = plot(Data{:,1}, Data{:, iLines + 1},...
        'LineWidth', 1, 'LineStyle', '-',...
        'buttonDownFcn', {@line_callback , obj},...
        'Color', obj.WatchList.colorLine(iLines,:),...
        'DisplayName', lineLabels{iLines},...
        'Tag', lineLabels{iLines},...
        'Parent', obj.Panel.Plot.Frequency.MainAxes);
    
    obj.Panel.Plot.Frequency.SmallLines(iLines) = plot(Data{:,1}, Data{:, iLines + 1},...
        'LineWidth', 1, 'LineStyle', '-',...
        'Color', obj.WatchList.colorLine(iLines,:),...
        'HitTest', 'off',...
        'Parent', obj.Panel.Plot.Frequency.SmallAxes);
end
obj.Panel.Plot.Frequency.Lines((nLines+1):end) = [];
obj.Panel.Plot.Frequency.SmallLines((nLines+1):end) = [];

obj.Panel.Plot.Frequency.MainAxes.XLabel.String = 'Frequency (Hz)';
obj.Panel.Plot.Frequency.MainAxes.YLabel.String = 'Power (%)';

obj.Panel.Plot.Frequency.Rectangle = rectangle(obj.Panel.Plot.Frequency.SmallAxes,...
    'Curvature', [0 0],...
    'EdgeColor', foregroundColor);

obj.WatchList.edvLine = obj.WatchList.edvLine;
obj.WatchList.freqLim = [Data{1,1},Data{end,1}];
end


function line_callback(hObject, ~, obj)
lineIdx = obj.Panel.Plot.Frequency.Lines == hObject;
if lineIdx == obj.WatchList.edvLine
    obj.WatchList.edvLine = ones(size(obj.WatchList.edvLine));
else
    obj.WatchList.edvLine = lineIdx;
end
end
