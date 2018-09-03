function founddatafile( ~, Events, GHandle)

	dataExtension = {'.txt', '.dat'};
	
	% find all the flie 
	listing = dir(Events.NewValue);
	
	%filter only data file 
	listIdx = contains({listing.name},dataExtension);
	
	% add it to the list box
	if any(listIdx)
		GHandle.TempWindow.NewStudyListBox.String = {listing(listIdx).name};
	else
		GHandle.TempWindow.NewStudyListBox.String = [];
	end

end