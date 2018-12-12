function viewerpopulatefrequency(~, eventData, GHandle, vIdx, viewerC)
%SPECTRUMPLOT Summary of this function goes here

foregroundColor = viewerC.foregroundColor;
Data = eventData.AffectedObject.spectrum2Plot;
lineLabels = Data.Properties.VariableNames(2:end);
nLines = size(Data,2) - 1;% one is the time column

cla(GHandle.Viewer(vIdx).PlotPanel.Frequency.MainAxes);
cla(GHandle.Viewer(vIdx).PlotPanel.Frequency.SmallAxes);

for iLines = 1 : nLines
    GHandle.Viewer(vIdx).PlotPanel.Frequency.Lines(iLines) = plot(Data{:,1}, Data{:, iLines + 1},...
        'LineWidth', 1, 'LineStyle', '-',...
        'buttonDownFcn', {@line_callback , GHandle, vIdx},...
        'Color', GHandle.Viewer(vIdx).WatchList.colorLine(iLines,:),...
        'DisplayName', lineLabels{iLines},...
        'Tag', lineLabels{iLines},...
        'Parent', GHandle.Viewer(vIdx).PlotPanel.Frequency.MainAxes);
    
    GHandle.Viewer(vIdx).PlotPanel.Frequency.SmallLines(iLines) = plot(Data{:,1}, Data{:, iLines + 1},...
        'LineWidth', 1, 'LineStyle', '-',...
        'Color', GHandle.Viewer(vIdx).WatchList.colorLine(iLines,:),...
        'HitTest', 'off',...
        'Parent', GHandle.Viewer(vIdx).PlotPanel.Frequency.SmallAxes);
end
GHandle.Viewer(vIdx).PlotPanel.Frequency.Lines((nLines+1):end) = [];
GHandle.Viewer(vIdx).PlotPanel.Frequency.SmallLines((nLines+1):end) = [];

GHandle.Viewer(vIdx).PlotPanel.Frequency.MainAxes.XLabel.String = 'Frequency (Hz)';
GHandle.Viewer(vIdx).PlotPanel.Frequency.MainAxes.YLabel.String = 'Power (%)';

GHandle.Viewer(vIdx).PlotPanel.Frequency.Rectangle = rectangle(GHandle.Viewer(vIdx).PlotPanel.Frequency.SmallAxes,...
    'Curvature', [0 0],...
    'EdgeColor', foregroundColor);

GHandle.Viewer(vIdx).WatchList.freqLim = [Data{1,1},Data{end,1}];
end


function line_callback(hObject, ~, GHandle, vIdx)
lineIdx = GHandle.Viewer(vIdx).PlotPanel.Frequency.Lines == hObject;
if lineIdx == GHandle.Viewer(vIdx).WatchList.edvLine
    GHandle.Viewer(vIdx).WatchList.edvLine = ones(size(GHandle.Viewer(vIdx).WatchList.edvLine));
else
    GHandle.Viewer(vIdx).WatchList.edvLine = lineIdx;
end
end
