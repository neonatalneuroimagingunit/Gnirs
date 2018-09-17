function move_time_window(~, eventData, GHandle)
% Move rectangle in viewer overall plot
%
% Written by Matteo Caffini
% CIMeC - Universita' dgli Studi di Trento
% on June, 27th 2018 in Rovereto (TN)

small_step = 1;
big_step = 10;

switch eventData.EventName
	case 'Action'
	switch eventData.Source.String
		case '<'
			xmin = GHandle.Viewer.WatchList.timeLim(1) - small_step;
			xmax = GHandle.Viewer.WatchList.timeLim(2) - small_step;
		case '>'
			xmin = GHandle.Viewer.WatchList.timeLim(1) + small_step;
			xmax = GHandle.Viewer.WatchList.timeLim(2) + small_step;
		case '<<'
			xmin = GHandle.Viewer.WatchList.timeLim(1) - big_step;
			xmax = GHandle.Viewer.WatchList.timeLim(2) - big_step;
		case '>>'
			xmin = GHandle.Viewer.WatchList.timeLim(1) + big_step;
			xmax = GHandle.Viewer.WatchList.timeLim(2) + big_step;
		case 'F'
			xmin = GHandle.CurrentDataSet.Data.reltime(1);
			xmax = GHandle.Viewer.WatchList.timeLim(2);
		case 'L'
			xmin = GHandle.Viewer.WatchList.timeLim(1);
			xmax = GHandle.CurrentDataSet.Data.reltime(end);
	end
	case 'Hit'
		xmin = eventData.IntersectionPoint(1);
		xmax = GHandle.Viewer.WatchList.timeLim(2) - GHandle.Viewer.WatchList.timeLim(1) + xmin;
end

 GHandle.Viewer.WatchList.timeLim = [xmin , xmax];
end