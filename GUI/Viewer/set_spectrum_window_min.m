function set_spectrum_window_min(~,event,GHandle)

xmin = str2double(event.Source.String);

if xmin < GHandle.Viewer.WatchList.freqLim(2)
    GHandle.Viewer.WatchList.freqLim(1) = xmin;
else
    msgbox('Invalid value - min must be smaller than max')
end