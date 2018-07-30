function  Handle = guidisp(Study, PannelHandle , editableField)
	dxsxEdge = 0.05;
	overunderEdge = 0.009;
	textBoxWidth = 0.3;
	textBoxHeight = 0.12;

	% create the figure and the editable field if is not specify
	if ~exist('editableField','var')
		editableField = '';
	end
	editableField = lower(editableField);
	
	if ~exist('PannelHandle','var') || isempty(PannelHandle)
		Handle.MainFigure = figure;
		Handle.Pannel = uipanel('Parent',Handle.MainFigure);
	else
		Handle.Pannel = PannelHandle;
	end
	
	% assign the title
	Handle.Pannel.Title = 'Study';
	
	% id
	lowerPos = (0.45 +overunderEdge) + 2 *( 0.55 - overunderEdge)/3;
	Handle.IdTextBox = gtextbox(...      
		'Parent',Handle.Pannel,...
		'TextString',Study.id,...
		'TitleString','ID:',...
		'Units','normalized',...
		'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);

	
	lowerPos = (0.45 +overunderEdge) + 1 *( 0.55 - overunderEdge)/3;
	% name	
	if any(contains(editableField,'name'))
			Handle.NameEditableTextBox = getitabletext(...      
			'Parent',Handle.Pannel,...
			'TextString',Study.name,...
			'TitleString','Name:',....
			'Units','normalized',...
			'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
	else
		Handle.NameTextBox = gtextbox(...      
			'Parent',Handle.Pannel,...
			'TextString',Study.name,...
			'TitleString','Name:',...
			'Units','normalized',...
			'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
	end
	
	% date
	lowerPos = (0.45 +overunderEdge);
	if any(contains(editableField,'date'))
		Handle.DateEditableTextBox = getitabletext(...      
			'Parent',Handle.Pannel,...
			'TextString',datestr(Study.date, 'dd/mm/yyyy'),...
			'TitleString','Date:',...
			'Units','normalized',...
			'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
	else
		Handle.DateTextBox = gtextbox(...      
			'Parent',Handle.Pannel,...
			'TextString',datestr(Study.date, 'dd/mm/yyyy'),...
			'TitleString','Date:',...
			'Units','normalized',...
			'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
	end
	
	% note
	if any(contains(editableField,'note'))
		Handle.NoteEditableTextBox = getitabletext(...      
			'Parent',Handle.Pannel,...
			'TextString',Study.note,...
			'TitleString','Note',...
			'Units','normalized',...
			'Position',[dxsxEdge overunderEdge textBoxWidth 0.3-overunderEdge]);
	else
		Handle.NoteTextBox = gtextbox(...      
			'Parent',Handle.Pannel,...
			'TextString',Study.note,...
			'TitleString','Note:',...
			'Units','normalized',...
			'Position',[dxsxEdge overunderEdge textBoxWidth 0.4-overunderEdge]);
	end

	
	% date first measure
	lowerPos = (overunderEdge) + 3 *( 1 - overunderEdge)/4;
	if isnat(Study.dateFirstMeasure) 
		dateString = 'NaT';
	else
		dateString = datestr(Study.dateLastMeasure, 'dd/mm/yyyy');
	end
		
	Handle.DateTextBox = gtextbox(...      
		'Parent',Handle.Pannel,...
		'TextString',dateString,...
		'TitleString','Date first measure:',...
		'Units','normalized',...
		'Position',[dxsxEdge + 0.5, lowerPos textBoxWidth textBoxHeight]);


	% date last measure
	lowerPos = (overunderEdge) + 2 *( 1 - overunderEdge)/4;
	if isnat(Study.dateLastMeasure) 
		dateString = 'NaT';
	else
		dateString = datestr(Study.dateLastMeasure, 'dd/mm/yyyy');
	end
	Handle.DateTextBox = gtextbox(...      
		'Parent',Handle.Pannel,...
		'TextString',dateString,...
		'TitleString','Date last measure:',...
		'Units','normalized',...,
		'Position',[dxsxEdge + 0.5 lowerPos textBoxWidth textBoxHeight]);
	

	% date first analysis
	lowerPos = (overunderEdge) + 1 *( 1 - overunderEdge)/4;
	if isnat(Study.dateFirstAnalysis) 
		dateString = 'NaT';
	else
		dateString = datestr(Study.dateFirstAnalysis, 'dd/mm/yyyy');
	end
	Handle.DateTextBox = gtextbox(...      
		'Parent',Handle.Pannel,...
		'TextString',dateString,...
		'TitleString','Date first analysis:',...
		'Units','normalized',...
		'Position',[dxsxEdge + 0.5, lowerPos textBoxWidth textBoxHeight]);
	

	% date last analysis
	lowerPos = (overunderEdge);
	if isnat(Study.dateLastAnalysis) 
		dateString = 'NaT';
	else
		dateString = datestr(Study.dateLastAnalysis, 'dd/mm/yyyy');
	end
	Handle.DateTextBox = gtextbox(...      
		'Parent',Handle.Pannel,...
		'TextString',dateString,...
		'TitleString','Date last analysis:',...
		'Units','normalized',...
		'Position',[dxsxEdge + 0.5, lowerPos textBoxWidth textBoxHeight]);
	

	
end

