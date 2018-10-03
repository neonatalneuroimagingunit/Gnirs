function timeplot(~, eventData, GHandle, vIdx)

foregroundColor = GHandle.Preference.Figure.foregroundColor;

Data = eventData.AffectedObject.time2Plot;
lineLabels = Data.Properties.VariableNames(2:end);

nLines = size(Data,2) - 1;% one is the time column
nLines = 20;
for iLines = 1 : nLines 
    GHandle.Viewer(vIdx).timeplot.lines1(iLines) = plot(Data{:,1}, Data{:, iLines + 1},...
							'LineWidth', 1, 'LineStyle', '-',...
							'buttonDownFcn', {@line_callback , GHandle, vIdx},...
							'Color', GHandle.Viewer(vIdx).WatchList.colorLine(iLines,:),...
							'DisplayName', lineLabels{iLines},...
							'Parent', GHandle.Viewer(vIdx).timeplot.bigaxes1);
						
						
						
	
    GHandle.Viewer(vIdx).timeplot.lines2(iLines) = plot(Data{:,1}, Data{:, iLines + 1},...
						'LineWidth', 1, 'LineStyle', '-',...
						'Color', GHandle.Viewer(vIdx).WatchList.colorLine(iLines,:),...
						'buttonDownFcn', {@move_time_window, GHandle, vIdx},...
						'Parent', GHandle.Viewer(vIdx).timeplot.smallaxes);
end

GHandle.Viewer(vIdx).timeplot.bigaxes1.YAxis.Exponent = 0;
GHandle.Viewer(vIdx).timeplot.bigaxes1.XLabel.String = 'Time (s)';
GHandle.Viewer(vIdx).timeplot.bigaxes1.YLabel.String = 'Intensity (a.u.)';

GHandle.Viewer(vIdx).timeplot.bigaxes2.XLabel.String = 'Time (samples)';
GHandle.Viewer(vIdx).timeplot.bigaxes2.YTickLabel = [];
GHandle.Viewer(vIdx).timeplot.bigaxes2.XLim = [1 size(Data,1)];


GHandle.Viewer(vIdx).timeplot.rectangle = rectangle('Parent', GHandle.Viewer(vIdx).timeplot.smallaxes,...
		'Curvature', [0 0], 'EdgeColor', foregroundColor);
GHandle.Viewer(vIdx).timeplot.txt_seconds = text(0, 0, '', 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 8,...
	'Parent', GHandle.Viewer(vIdx).timeplot.smallaxes);
GHandle.Viewer(vIdx).timeplot.txt_samples = text(0, 0, '', 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 8,...
	'Parent', GHandle.Viewer(vIdx).timeplot.smallaxes);

GHandle.Viewer(vIdx).WatchList.edvLine = ones(size(GHandle.Viewer(vIdx).timeplot.lines2));
GHandle.Viewer(vIdx).WatchList.timeLim = [GHandle.CurrentDataSet.Data.reltime(1),...
									GHandle.CurrentDataSet.Data.reltime(end)];

end

