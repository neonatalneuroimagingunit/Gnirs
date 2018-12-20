function viewerpopulatetimefrequency(~, eventData, GHandle, vIdx, viewerC)

maskLine = eventData.AffectedObject.timefreq2Plot;

tagLine = GHandle.Viewer(vIdx).PlotPanel.Time.Lines(maskLine).Tag;

[sp,fp,tp] = pspectrum(viewerC.Data.Time.(tagLine), viewerC.updateRate, 'spectrogram');

GHandle.Viewer(vIdx).PlotPanel.TimeFrequency.Surface = surf(tp, fp, sp, sp,...
		'Parent', GHandle.Viewer(vIdx).PlotPanel.TimeFrequency.MainAxes,...
		'Visible', 'on',...
		'EdgeColor', 'none',...
		'FaceColor', 'interp');
	
GHandle.Viewer(vIdx).PlotPanel.TimeFrequency.MainAxes.XLabel.String = 'Time (s)';
GHandle.Viewer(vIdx).PlotPanel.TimeFrequency.MainAxes.YLabel.String = 'Frequency (Hz)';
end

