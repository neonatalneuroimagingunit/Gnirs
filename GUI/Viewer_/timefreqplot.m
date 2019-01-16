function timefreqplot(~, eventData, GHandle, vIdx)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
maskLine = eventData.AffectedObject.timefreq2Plot;

tagLine = GHandle.Viewer(vIdx).timeplot.lines1(maskLine).Tag;

[sp,fp,tp] = pspectrum(GHandle.Viewer(vIdx).Data.(tagLine), GHandle.Viewer(vIdx).updateRate, 'spectrogram');

GHandle.Viewer(vIdx).timefrequencyplot.Surface = surf(tp,fp,sp,sp,...
		'Parent',GHandle.Viewer(vIdx).timefrequencyplot.bigaxes,...
		'Visible','on',...
		'EdgeColor','none',...
		'FaceColor','interp');
	
	
GHandle.Viewer(vIdx).timefrequencyplot.bigaxes.XLabel.String = 'Time (s)';
GHandle.Viewer(vIdx).timefrequencyplot.bigaxes.YLabel.String = 'Frequency (Hz)';
end

