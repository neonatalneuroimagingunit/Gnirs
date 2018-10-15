function spectrumplot(~, eventData, GHandle, vIdx)
%SPECTRUMPLOT Summary of this function goes here

foregroundColor = GHandle.Preference.Figure.foregroundColor;

Data = eventData.AffectedObject.spectrum2Plot;
lineLabels = Data.Properties.VariableNames(2:end);

nLines = size(Data,2) - 1;% one is the time column

cla(GHandle.Viewer(vIdx).spectrumplot.bigaxes1);
cla(GHandle.Viewer(vIdx).spectrumplot.smallaxes);


for iLines = 1 : nLines 
   GHandle.Viewer(vIdx).spectrumplot.lines1(iLines) = plot(Data{:,1}, Data{:, iLines + 1},...
							'LineWidth', 1, 'LineStyle', '-',...
							'buttonDownFcn', {@line_callback , GHandle, vIdx},...
							'Color', GHandle.Viewer(vIdx).WatchList.colorLine(iLines,:),...
							'DisplayName', lineLabels{iLines},...
							'Tag', lineLabels{iLines},...
							'Parent', GHandle.Viewer(vIdx).spectrumplot.bigaxes1);
					
    GHandle.Viewer(vIdx).spectrumplot.lines2(iLines) = plot(Data{:,1}, Data{:, iLines + 1},...
						'LineWidth', 1, 'LineStyle', '-',...
						'Color', GHandle.Viewer(vIdx).WatchList.colorLine(iLines,:),...
						'HitTest', 'off',...
						'Parent', GHandle.Viewer(vIdx).spectrumplot.smallaxes);
end
 GHandle.Viewer(vIdx).spectrumplot.lines1((nLines+1):end) = [];
 GHandle.Viewer(vIdx).spectrumplot.lines2((nLines+1):end) = [];

GHandle.Viewer(vIdx).spectrumplot.bigaxes1.XLabel.String = 'Frequency (Hz)';
GHandle.Viewer(vIdx).spectrumplot.bigaxes1.YLabel.String = 'Power (%)';

GHandle.Viewer(vIdx).spectrumplot.rectangle = rectangle(GHandle.Viewer(vIdx).spectrumplot.smallaxes,...
			'Curvature', [0 0],...
			'EdgeColor', foregroundColor);

GHandle.Viewer(vIdx).WatchList.freqLim = [Data{1,1},Data{end,1}];

end


function line_callback(hObject, ~, GHandle, vIdx)

	lineIdx = GHandle.Viewer(vIdx).spectrumplot.lines1 == hObject;
	

	if lineIdx == GHandle.Viewer(vIdx).WatchList.edvLine
		GHandle.Viewer(vIdx).WatchList.edvLine = ones(size(GHandle.Viewer(vIdx).WatchList.edvLine));
	else
		GHandle.Viewer(vIdx).WatchList.edvLine = lineIdx;
	end

end
