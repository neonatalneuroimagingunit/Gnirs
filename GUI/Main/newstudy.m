function newstudy(~, ~, GHandle)
	
	figureSize = GHandle.Preference.Figure.sizeMedium;


	GHandle.TempWindow.NewStudyFigure = figure(...
	'position', figureSize,...
    'Resize', 'on',...
    'Name', 'New NIRS Study', ...
    'Numbertitle', 'off', ...
    'Toolbar', 'none', ...
    'Menubar', 'none', ...
    'DoubleBuffer', 'on', ...
    'DockControls', 'off', ...
    'Renderer', 'OpenGL',...
	'Visible', 'off' ...
	);
	
	GHandle.TempWindow.NewStudyName = uiw.widget.EditableText(...      
    'Parent',GHandle.TempWindow.NewStudyFigure,...=
    'Value','Insert Name',...
    'Label','Study Name:',...
    'LabelLocation','top',...
    'LabelWidth',90,...
    'Units','normalized',...
    'Position',[0.05 0.80 0.35 0.15]);

	GHandle.TempWindow.NewStudyNote = uiw.widget.EditableText(...      
    'Parent',GHandle.TempWindow.NewStudyFigure,...
    'Value','Insert Note',...
    'Label','Study Note:',...
	'IsMultiLine', 1,...
    'LabelLocation','top',...
    'LabelWidth',90,...
    'Units','normalized',...
    'Position',[0.50 0.05 0.25 0.45]);

	GHandle.TempWindow.NewStudyListBox = uicontrol(...
			'Parent', GHandle.TempWindow.NewStudyFigure, ...
			'Style','listbox',...
			'Units', 'normalize', ...
			'Max', 2,...
			'Position',  [0.05 0.05 0.4 0.55],...
			'String',[],...
			'Value',[]);

	GHandle.TempWindow.NewStudySelector = uiw.widget.FolderSelector(...
    'Parent', GHandle.TempWindow.NewStudyFigure, ...
    'Value', [], ...
    'Label','Choose a data file:', ...
    'LabelLocation','top',...
    'LabelWidth',150,...
    'Units', 'normalize', ...
    'Position', [0.05 0.60 0.4 0.15],...	
	'Callback',@(ObjectHandle, Event)founddatafile(ObjectHandle, Event, GHandle)...
	);

	
	

	GHandle.TempWindow.NewStudyLoadButton = uicontrol('Style', 'pushbutton',...	
    'Parent', GHandle.TempWindow.NewStudyFigure, ...
	'String', 'Load',...
	'Units', 'normalize', ...
	'Position', [0.8 0.15 0.2 0.1],...
	'Callback', {@loadstudy ,GHandle}...
	); 

	GHandle.TempWindow.NewStudyFigure.Visible = 'on';

end

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


function loadstudy(~, ~, GHandle )
	%inserire il phantom del soggetto e le note
	
	studyName = GHandle.TempWindow.NewStudyName.Value;
	note = GHandle.TempWindow.NewStudyNote.Value;

	NewStudy = NirsStudy('name', studyName, 'date' ,datetime, 'note', note);
	
	DataBase = GHandle.DataBase.add(NewStudy);
	if ~isempty(GHandle.TempWindow.NewStudyListBox.String)
		%load measure
	end

	GHandle.DataBase = DataBase;
		
	tree(GHandle);
	
end
















