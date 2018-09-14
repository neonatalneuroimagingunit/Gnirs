function set_time_window_min(~,event,hplot, fs)

xmin = str2double(event.Source.String);
% if isnan(xmin)
%     xmin = 0;
% end
if xmin < hplot.bigaxes1.XLim(2)
    hplot.bigaxes1.XLim(1) = xmin;
    hplot.bigaxes2.XLim(1) = xmin * fs;
    hrect = findall(hplot.smallaxes, 'Type', 'rectangle');
    hrect.Position(3) = hplot.bigaxes1.XLim(2) - xmin;
    hrect.Position(1) = xmin;
    temp = findall(hplot.smallaxes, 'Type', 'text');
    htxt_seconds = temp(2);
    htxt_samples = temp(1);
    htxt_seconds.String = [num2str(hplot.bigaxes1.XLim(2) - hplot.bigaxes1.XLim(1)) ' s'];
    htxt_samples.String = [num2str(hplot.bigaxes2.XLim(2) - hplot.bigaxes2.XLim(1)) ' samples'];
    htxt_seconds.Position(1) = hrect.Position(1) + hrect.Position(3)/2;
    htxt_samples.Position(1) = hrect.Position(1) + hrect.Position(3)/2;
else
    msgbox('Invalid value - min must be smaller than max')
end