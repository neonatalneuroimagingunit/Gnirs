function line_callback(hObject, evnt, GHandle)

% Change LineWidth in raw_explorer main plot
%
% Written by Matteo Caffini
% CIMeC - Universita' dgli Studi di Trento
% on July, 14th 2017 in Rovereto (TN)
% Modified by Nadir Pagno

	lineIdx = GHandle.Viewer.timeplot.lines1 == hObject;


	if lineIdx == GHandle.Viewer.WatchList.edvLine
		GHandle.Viewer.WatchList.edvLine = ones(size(GHandle.Viewer.WatchList.edvLine));
	else
		GHandle.Viewer.WatchList.edvLine = lineIdx;
	end

end