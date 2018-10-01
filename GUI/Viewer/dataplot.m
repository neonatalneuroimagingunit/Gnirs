function dataplot(~, eventData, GHandle, vIdx)

foregroundColor = GHandle.Preference.Figure.foregroundColor;

Data = eventData.AffectedObject.data2Plot;
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

%% Spectrum plot
% Main plot
axes(GHandle.Viewer(vIdx).spectrumplot.bigaxes1)
axis tight
cla;
hold on
aa = 1;

xdata = GHandle.CurrentDataSet.Data.reltime;
ydata = nirsdata;

[power, f] = pspectrum(ydata, GHandle.CurrentDataSet.Measure.updateRate);
GHandle.CurrentDataSet.power = power;
GHandle.CurrentDataSet.freq = f;

for ii = 1:1:nchannels
    %temp = smooth(power(:,ii), 5);
    temp = power(:,ii);
    %temp = power(:,ii)/maxpower(ii);
    GHandle.Viewer(vIdx).spectrumplot.lines1(ii) = plot(f, temp, 'LineWidth', 1, 'LineStyle', '-');
    GHandle.Viewer(vIdx).spectrumplot.lines1(ii).Color = GHandle.Viewer(vIdx).WatchList.colorLine(ii,:);
    GHandle.Viewer(vIdx).spectrumplot.lines1(ii).DisplayName = channelLabels{ii};
    aa = aa+1;
end
%GHandle.Viewer(vIdx).spectrumplot.bigaxes1.YAxis.Exponent = 0;
GHandle.Viewer(vIdx).spectrumplot.lines1_selection = findall(GHandle.Viewer(vIdx).spectrumplot.lines1, 'Type', 'Line');
set(GHandle.Viewer(vIdx).spectrumplot.lines1_selection, 'buttonDownFcn', {@line_callback, GHandle, vIdx})
GHandle.Viewer(vIdx).spectrumplot.bigaxes1.XLabel.String = 'Frequency (Hz)';
GHandle.Viewer(vIdx).spectrumplot.bigaxes1.YLabel.String = 'Power (%)';
%GHandle.Viewer(vIdx).spectrumplot.bigaxes1.YLim = [0 0.1];
% x2 = 1:1:size(nirsdata,1);
% %y2 = 1:1:size(nirsdata,1);
% y2 = DataNIRS.Data.reltime/GHandle.CurrentDataSet.Measure.updateRate;
% line(x2, y2, 'Parent', GHandle.Viewer(vIdx).spectrumplot.bigaxes2, 'Color', 'none')
% GHandle.Viewer(vIdx).spectrumplot.bigaxes2.XLabel.String = 'Time (samples)';
% GHandle.Viewer(vIdx).spectrumplot.bigaxes2.YTickLabel = [];
% GHandle.Viewer(vIdx).spectrumplot.bigaxes2.XLim = [timeline_samples(1) timeline_samples(end)];
uistack(GHandle.Viewer(vIdx).spectrumplot.spectrumaxes,'top');
% Overall plot
axes(GHandle.Viewer(vIdx).spectrumplot.smallaxes)
axis tight
cla;
hold on
for ii = 1:1:size(nirsdata,2)
    %temp = smooth(power(:,ii), 5);
    temp = power(:,ii);
    %temp = power(:,ii)/maxpower(ii);
    GHandle.Viewer(vIdx).spectrumplot.lines2(ii) = plot(f, temp, 'LineWidth', 1, 'LineStyle', '-');
    set(GHandle.Viewer(vIdx).spectrumplot.lines2(ii), 'Color', GHandle.Viewer(vIdx).WatchList.colorLine(ii,:));
    aa = aa+1;
end

GHandle.Viewer(vIdx).listener = addlistener(GHandle.Viewer(vIdx).WatchList,'freqLim','PostSet',@(src,evnt)set_freq_lim(src, evnt, GHandle, vIdx));

GHandle.Viewer(vIdx).spectrumplot.rectangle = rectangle('Curvature', [0 0], 'EdgeColor', foregroundColor);

GHandle.Viewer(vIdx).WatchList.freqLim = [f(1),...
									f(end)];

GHandle.Viewer(vIdx).spectrumplot.lines2_selection = findall(GHandle.Viewer(vIdx).spectrumplot.lines2, 'Type', 'Line');
set(GHandle.Viewer(vIdx).spectrumplot.lines2_selection, 'buttonDownFcn', {@move_spectrum_window, GHandle, vIdx});
end

