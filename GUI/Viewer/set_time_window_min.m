function set_time_window_min(~, event, GHandle)

xmin = str2double(event.Source.String);
% if isnan(xmin)
%     xmin = 0;
% end
if xmin < GHandle.Viewer.WatchList.timeLim(2)
    GHandle.Viewer.WatchList.timeLim(1) = xmin;
else
    msgbox('Invalid value - min must be smaller than max')
end