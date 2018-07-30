function  guidisp(Study, GHandle , editableField)
	dxsxEdge = 0.05;
	overunderEdge = 0.009;
	textBoxWidth = 0.3;
	textBoxHeight = 0.12;
	
	textFontSize = GHandle.Preference.Font.sizeM;
	
	idx = GHandle.Garbage.idx;	

	% create the figure and the editable field if is not specify
	if ~exist('editableField','var')
		editableField = '';
	end
	editableField = lower(editableField);
	
	if ~exist('GHandle','var') || isempty(GHandle)
		Handle.MainFigure = figure;
		GHandle.Main.SubPanel.Panel = uipanel('Parent',Handle.MainFigure);
	end
	
	% assign the title
	GHandle.Main.Display.SubPanel(idx).Panel.Title = 'Study';
	
	% id
	lowerPos = (0.45 +overunderEdge) + 2 *( 0.55 - overunderEdge)/3;
	GHandle.Main.Display.SubPanel(idx).IdTextBox = gtextbox(...      
		'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
		'TextString',Study.id,...
		'TitleString','ID:',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);

	
	lowerPos = (0.45 +overunderEdge) + 1 *( 0.55 - overunderEdge)/3;
	% name	
	if any(contains(editableField,'name'))
			GHandle.Main.Display.SubPanel(idx).NameEditableTextBox = getitabletext(...      
			'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
			'TextString',Study.name,...
			'TitleString','Name:',....
			'FontSize',textFontSize,...
			'Units','normalized',...
			'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
	else
		GHandle.Main.Display.SubPanel(idx).NameTextBox = gtextbox(...      
			'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
			'TextString',Study.name,...
			'TitleString','Name:',...
			'FontSize',textFontSize,...
			'Units','normalized',...
			'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
	end
	
	% date
	lowerPos = (0.45 +overunderEdge);
	if any(contains(editableField,'date'))
		GHandle.Main.Display.SubPanel(idx).DateEditableTextBox = getitabletext(...      
			'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
			'TextString',datestr(Study.date, 'dd/mm/yyyy'),...
			'TitleString','Date:',...
			'FontSize',textFontSize,...
			'Units','normalized',...
			'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
	else
		GHandle.Main.Display.SubPanel(idx).DateTextBox = gtextbox(...      
			'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
			'TextString',datestr(Study.date, 'dd/mm/yyyy'),...
			'TitleString','Date:',...
			'FontSize',textFontSize,...
			'Units','normalized',...
			'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
	end
	
	% note
	if any(contains(editableField,'note'))
		GHandle.Main.Display.SubPanel(idx).NoteEditableTextBox = getitabletext(...      
			'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
			'TextString',Study.note,...
			'TitleString','Note',...
			'FontSize',textFontSize,...
			'Units','normalized',...
			'Position',[dxsxEdge overunderEdge textBoxWidth 0.3-overunderEdge]);
	else
		GHandle.Main.Display.SubPanel(idx).NoteTextBox = gtextbox(...      
			'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
			'TextString',Study.note,...
			'TitleString','Note:',...
			'FontSize',textFontSize,...
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
		
	GHandle.Main.Display.SubPanel(idx).DateTextBox = gtextbox(...      
		'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
		'TextString',dateString,...
		'TitleString','Date first measure:',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge + 0.5, lowerPos textBoxWidth textBoxHeight]);


	% date last measure
	lowerPos = (overunderEdge) + 2 *( 1 - overunderEdge)/4;
	if isnat(Study.dateLastMeasure) 
		dateString = 'NaT';
	else
		dateString = datestr(Study.dateLastMeasure, 'dd/mm/yyyy');
	end
	GHandle.Main.Display.SubPanel(idx).DateTextBox = gtextbox(...      
		'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
		'TextString',dateString,...
		'TitleString','Date last measure:',...
		'FontSize',textFontSize,...
		'Units','normalized',...,
		'Position',[dxsxEdge + 0.5 lowerPos textBoxWidth textBoxHeight]);
	

	% date first analysis
	lowerPos = (overunderEdge) + 1 *( 1 - overunderEdge)/4;
	if isnat(Study.dateFirstAnalysis) 
		dateString = 'NaT';
	else
		dateString = datestr(Study.dateFirstAnalysis, 'dd/mm/yyyy');
	end
	GHandle.Main.Display.SubPanel(idx).DateTextBox = gtextbox(...      
		'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
		'TextString',dateString,...
		'TitleString','Date first analysis:',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge + 0.5, lowerPos textBoxWidth textBoxHeight]);
	

	% date last analysis
	lowerPos = (overunderEdge);
	if isnat(Study.dateLastAnalysis) 
		dateString = 'NaT';
	else
		dateString = datestr(Study.dateLastAnalysis, 'dd/mm/yyyy');
	end
	GHandle.Main.Display.SubPanel(idx).DateTextBox = gtextbox(...      
		'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
		'TextString',dateString,...
		'TitleString','Date last analysis:',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge + 0.5, lowerPos textBoxWidth textBoxHeight]);
	

	
end

