function move_spectrum_window(~, eventData, GHandle)

% Move rectangle in viewer overall plot
%
% Written by Matteo Caffini
% CIMeC - Universita' dgli Studi di Trento
% on June, 27th 2018 in Rovereto (TN)

small_step = 1;
big_step = 10;

switch eventData.EventName
	case 'Action'
	switch eventData.Source.Tag
		case '<'
			xmin = GHandle.Viewer.WatchList.freqLim(1) - small_step;
			xmax = GHandle.Viewer.WatchList.freqLim(2) - small_step;
			
		case '>'
			xmin = GHandle.Viewer.WatchList.freqLim(1) + small_step;
			xmax = GHandle.Viewer.WatchList.freqLim(2) + small_step;
			
		case '<<'
			xmin = GHandle.Viewer.WatchList.freqLim(1) - big_step;
			xmax = GHandle.Viewer.WatchList.freqLim(2) - big_step;
			
		case '>>'
			xmin = GHandle.Viewer.WatchList.freqLim(1) + big_step;
			xmax = GHandle.Viewer.WatchList.freqLim(2) + big_step;
			
		case 'F'
			xmin = GHandle.CurrentDataSet.freq(1);
			xmax = GHandle.Viewer.WatchList.freqLim(2);
			
		case 'L'
			xmin = GHandle.Viewer.WatchList.freqLim(1);
			xmax = GHandle.CurrentDataSet.freq(end);
			
		case 'max'
			xmin = GHandle.Viewer.WatchList.freqLim(1);
			xmax = str2double(eventData.Source.String);
			if xmax < xmin
				xmax = GHandle.Viewer.WatchList.freqLim(2);
				msgbox('Invalid value - max must be larger than min')
			end
			
		case 'min'
			xmax = GHandle.Viewer.WatchList.freqLim(2);
			xmin = str2double(eventData.Source.String);
			if xmin > xmax
				xmin = GHandle.Viewer.WatchList.freqLim(1);
				msgbox('Invalid value - min must be smaller than max')
			end	
	end
	case 'Hit'
		xmin = eventData.IntersectionPoint(1);
		xmax = GHandle.Viewer.WatchList.freqLim(2) - GHandle.Viewer.WatchList.freqLim(1) + xmin;
end

 GHandle.Viewer.WatchList.freqLim = [xmin , xmax];
 
end