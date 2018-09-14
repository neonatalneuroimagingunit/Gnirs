function set_time_window_max(~,event,hplot,fs)

xmax = str2double(event.Source.String);
if xmax > hplot.bigaxes1.XLim(1)
    hplot.bigaxes1.XLim(2) = xmax;
    hplot.bigaxes2.XLim(2) = xmax * fs;
    hrect = findall(hplot.smallaxes, 'Type', 'rectangle');
    hrect.Position(3) = xmax - hrect.Position(1);
    temp = findall(hplot.smallaxes, 'Type', 'text');
    htxt_seconds = temp(2);
    htxt_samples = temp(1);
    htxt_seconds.String = [num2str(hplot.bigaxes1.XLim(2) - hplot.bigaxes1.XLim(1)) ' s'];
    htxt_samples.String = [num2str(hplot.bigaxes2.XLim(2) - hplot.bigaxes2.XLim(1)) ' samples'];
    htxt_seconds.Position(1) = hrect.Position(1) + hrect.Position(3)/2;
    htxt_samples.Position(1) = hrect.Position(1) + hrect.Position(3)/2;
else
    msgbox('Invalid value - max must be larger than min')
end