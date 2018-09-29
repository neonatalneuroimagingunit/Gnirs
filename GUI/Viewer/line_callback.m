function line_callback(hObject, evnt, GHandle, vIdx)

% Change LineWidth in raw_explorer main plot
%
% Written by Matteo Caffini
% CIMeC - Universita' dgli Studi di Trento
% on July, 14th 2017 in Rovereto (TN)
% Modified by Nadir Pagno

	lineIdx = GHandle.Viewer(vIdx).timeplot.lines1 == hObject;


	if lineIdx == GHandle.Viewer(vIdx).WatchList.edvLine
		GHandle.Viewer(vIdx).WatchList.edvLine = ones(size(GHandle.Viewer(vIdx).WatchList.edvLine));
	else
		GHandle.Viewer(vIdx).WatchList.edvLine = lineIdx;
	end

end