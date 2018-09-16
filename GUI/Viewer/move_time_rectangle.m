function move_rectangle(hObject,eventData,hplot,fs)

% Move rectangle in viewer overall plot
%
% Written by Matteo Caffini
% CIMeC - Universita' dgli Studi di Trento
% on June, 27th 2018 in Rovereto (TN)

%hrect = findall(hObject,'Type','rectangle');
hplot.rectangle.Position(1) = eventData.IntersectionPoint(1);
hplot.bigaxes1.XLim = [eventData.IntersectionPoint(1) eventData.IntersectionPoint(1) + hplot.rectangle.Position(3)];
hplot.bigaxes2.XLim = [(eventData.IntersectionPoint(1))*fs (eventData.IntersectionPoint(1) + hplot.rectangle.Position(3))*fs];
hplot.editmin.String = num2str(hplot.rectangle.Position(1));
hplot.editmax.String = num2str(hplot.bigaxes1.XLim(2));
hplot.txt_seconds.String = [num2str(hplot.bigaxes1.XLim(2) - hplot.bigaxes1.XLim(1)) ' s'];
hplot.txt_samples.String = [num2str(hplot.bigaxes2.XLim(2) - hplot.bigaxes2.XLim(1)) ' samples'];
hplot.txt_seconds.Position(1) = hplot.rectangle.Position(1) + hplot.rectangle.Position(3)/2;
hplot.txt_samples.Position(1) = hplot.rectangle.Position(1) + hplot.rectangle.Position(3)/2;