function set_spectrum_window_max(~, event, GHandle)

xmax = str2double(event.Source.String);
if xmax > GHandle.Viewer.WatchList.freqLim(1)
	GHandle.Viewer.WatchList.freqLim(2) = xmax;
else
    msgbox('Invalid value - max must be larger than min')
end