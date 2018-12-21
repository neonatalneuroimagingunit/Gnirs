function populatetimefrequency(obj, ~, eventData)

maskLine = eventData.AffectedObject.timefreq2Plot;

tagLine =  obj.Panel.Plot.Time.Lines(maskLine).Tag;

[sp,fp,tp] = pspectrum(obj.Dataset.Data.Time.(tagLine), obj.Dataset.updateRate, 'spectrogram');

obj.Panel.Plot.TimeFrequency.Surface = surf(tp, fp, sp, sp,...
		'Parent', obj.Panel.Plot.TimeFrequency.MainAxes,...
		'Visible', 'on',...
		'EdgeColor', 'none',...
		'FaceColor', 'interp');
	
obj.Panel.Plot.TimeFrequency.MainAxes.XLabel.String = 'Time (s)';
obj.Panel.Plot.TimeFrequency.MainAxes.YLabel.String = 'Frequency (Hz)';
end

