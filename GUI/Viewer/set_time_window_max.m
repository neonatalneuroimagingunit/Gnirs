function set_time_window_max(~, event, GHandle)

xmax = str2double(event.Source.String);
if xmax > GHandle.Viewer.WatchList.timeLim(1)
	GHandle.Viewer.WatchList.timeLim(2) = xmax;
else
    msgbox('Invalid value - max must be larger than min')
end