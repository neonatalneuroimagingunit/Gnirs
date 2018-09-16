function move_window(hObject,eventData,hplot,fs)

% Move rectangle in viewer overall plot
%
% Written by Matteo Caffini
% CIMeC - Universita' dgli Studi di Trento
% on June, 27th 2018 in Rovereto (TN)

hrect = findall(hplot.smallaxes, 'Type', 'rectangle');
temp = findall(hplot.smallaxes, 'Type', 'text');
htxt_seconds = temp(2);
htxt_samples = temp(1);

small_step = 1;
big_step = 10;

switch eventData.Source.String
    case '<'
        xmin = hplot.bigaxes1.XLim(1) - small_step;
        xmax = hplot.bigaxes1.XLim(2) - small_step;
    case '>'
        xmin = hplot.bigaxes1.XLim(1) + small_step;
        xmax = hplot.bigaxes1.XLim(2) + small_step;
    case '<<'
        xmin = hplot.bigaxes1.XLim(1) - big_step;
        xmax = hplot.bigaxes1.XLim(2) - big_step;
    case '>>'
        xmin = hplot.bigaxes1.XLim(1) + big_step;
        xmax = hplot.bigaxes1.XLim(2) + big_step;
    case 'F'
        xmin = hplot.bigaxes1.Children(1).XData(1);
        xmax = hplot.bigaxes1.XLim(2);
    case 'L'
        xmin = hplot.bigaxes1.XLim(1);
        xmax = hplot.bigaxes1.Children(1).XData(end);
end

hrect.Position(1) = xmin;
hrect.Position(3) = xmax - xmin;
hplot.bigaxes1.XLim = [xmin xmax];
hplot.bigaxes2.XLim = [xmin xmax]*fs;
hplot.editmin.String = num2str(xmin);
hplot.editmax.String = num2str(xmax);
htxt_seconds.String = [num2str(hplot.bigaxes1.XLim(2) - hplot.bigaxes1.XLim(1)) ' s'];
htxt_samples.String = [num2str(hplot.bigaxes2.XLim(2) - hplot.bigaxes2.XLim(1)) ' samples'];
htxt_seconds.Position(1) = hrect.Position(1) + hrect.Position(3)/2;
htxt_samples.Position(1) = hrect.Position(1) + hrect.Position(3)/2;