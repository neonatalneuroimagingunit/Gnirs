function  Handle = guidisp(Subject, GHandle , editableField)
	dxsxEdge = 0.05;
	overunderEdge = 0.009;
	textBoxWidth = 0.3;
	textBoxHeight = 0.12;
	gmColor = [0.65 0.65 0.65];
	wmColor =  [1 1 1];
	scalpColor = [255 229 204]./255;
	sourceColor = [1 0 0];
    detectorColor = [0 0 1];
	
	idx = GHandle.Temp.idx;
	fontName = 'Arial'; %'Lobster Two';
    
    
	textFontSize = GHandle.Preference.Font.sizeM;
	
	idx = GHandle.Temp.idx;
	
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
	GHandle.Main.Display.SubPanel(idx).Panel.Title = 'Probe';
	
	% id
	lowerPos = (0.3 +overunderEdge) + 3 *( 0.7 - overunderEdge)/4;
	GHandle.Main.Display.SubPanel(idx).IdTextBox = gtextbox(...      
		'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
		'TextString',Subject.id,...
		'TitleString','ID:',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);

	
	lowerPos = (0.3 +overunderEdge) + 2 *( 0.7 - overunderEdge)/4;
	% name	
	if any(contains(editableField,'name'))
		GHandle.Main.Display.SubPanel(idx).NameEditableTextBox = geditabletext(...      
		'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
		'TextString',Subject.name,...
		'TitleString','Name',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
	else
		GHandle.Main.Display.SubPanel(idx).NameTextBox = gtextbox(...      
		'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
		'TextString',Subject.name,...
		'TitleString','Name:',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
	end
	
	
	
	
end

