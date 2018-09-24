function move_time_window(~, eventData, GHandle, vIdx)
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
			xmin = GHandle.Viewer(vIdx).WatchList.timeLim(1) - small_step;
			xmax = GHandle.Viewer(vIdx).WatchList.timeLim(2) - small_step;
			
		case '>'
			xmin = GHandle.Viewer(vIdx).WatchList.timeLim(1) + small_step;
			xmax = GHandle.Viewer(vIdx).WatchList.timeLim(2) + small_step;
			
		case '<<'
			xmin = GHandle.Viewer(vIdx).WatchList.timeLim(1) - big_step;
			xmax = GHandle.Viewer(vIdx).WatchList.timeLim(2) - big_step;
			
		case '>>'
			xmin = GHandle.Viewer(vIdx).WatchList.timeLim(1) + big_step;
			xmax = GHandle.Viewer(vIdx).WatchList.timeLim(2) + big_step;
			
		case 'F'
			xmin = GHandle.CurrentDataSet.Data.reltime(1);
			xmax = GHandle.Viewer(vIdx).WatchList.timeLim(2);
			
		case 'L'
			xmin = GHandle.Viewer(vIdx).WatchList.timeLim(1);
			xmax = GHandle.CurrentDataSet.Data.reltime(end);
			
		case 'max'
			xmin = GHandle.Viewer(vIdx).WatchList.timeLim(1);
			xmax = str2double(eventData.Source.String);
			if xmax > GHandle.Viewer(vIdx).WatchList.timeLim(1)
				GHandle.Viewer(vIdx).WatchList.timeLim(2) = xmax;
			else
				msgbox('Invalid value - max must be larger than min')
			end
			
		case 'min'
			xmax = GHandle.Viewer(vIdx).WatchList.timeLim(2);
			xmin = str2double(eventData.Source.String);
			if xmin < GHandle.Viewer(vIdx).WatchList.timeLim(2)
				GHandle.Viewer(vIdx).WatchList.timeLim(1) = xmin;
			else
				msgbox('Invalid value - min must be smaller than max')
			end	
	end
	
	case 'Hit'
		xmin = eventData.IntersectionPoint(1);
		xmax = GHandle.Viewer(vIdx).WatchList.timeLim(2) - GHandle.Viewer(vIdx).WatchList.timeLim(1) + xmin;
end
if strcmp(GHandle.Viewer(vIdx).LockMultipleWiewer.State,'on')
	for vIdx = GHandle.Temp.vIdxList'
		GHandle.Viewer(vIdx).WatchList.timeLim = [xmin , xmax];
	end 
else
	GHandle.Viewer(vIdx).WatchList.timeLim = [xmin , xmax];
end
		





end





