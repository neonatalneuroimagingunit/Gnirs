function newatlas(~, ~, GHandle)	

	figureSize = GHandle.Preference.Figure.sizeMedium;


	GHandle.TempWindow.NewAtlasFigure = figure(...
	'position', figureSize,...
    'Resize', 'on',...
    'Name', 'New NIRS Atlas', ...
    'Numbertitle', 'off', ...
    'Toolbar', 'none', ...
    'Menubar', 'none', ...
    'DoubleBuffer', 'on', ...
    'DockControls', 'off', ...
    'Renderer', 'OpenGL',...
	'Visible', 'off' ...
	);

GHandle.TempWindow.NewAtlasWidget = uiw.widget.FileSelector(...
	'Value', 'C:\matlab.mat', ...
	'Pattern', {'*.mat','MATLAB MAT files (*.mat)'; '*.allas','atlas files (*.atlas)'}, ...
	'Parent',GHandle.TempWindow.NewAtlasFigure,...
	'Label','Select the Atlas',...
    'LabelLocation','top',...
	'Units','normalized',...
	'Position',[0.05 0.6 0.65 0.13]);

	
	GHandle.TempWindow.NewAtlasName = uiw.widget.EditableText(...      
    'Parent',GHandle.TempWindow.NewAtlasFigure,...=
    'Value','Insert Name',...
    'Label','Atlas Name:',...
    'LabelLocation','top',...
    'LabelWidth',90,...
    'Units','normalized',...
    'Position',[0.05 0.80 0.35 0.15]);

	GHandle.TempWindow.NewAtlasNote = uiw.widget.EditableText(...      
    'Parent',GHandle.TempWindow.NewAtlasFigure,...
    'Value','Insert Note',...
    'Label','Atlas Note:',...
	'IsMultiLine', 1,...
    'LabelLocation','top',...
    'LabelWidth',90,...
    'Units','normalized',...
    'Position',[0.50 0.05 0.25 0.45]);

	GHandle.TempWindow.NewAtlasLoadButton = uicontrol('Style', 'pushbutton',...	
    'Parent', GHandle.TempWindow.NewAtlasFigure, ...
	'String', 'Load',...
	'Units', 'normalize', ...
	'Position', [0.8 0.15 0.2 0.1],...
	'Callback', {@load_atlas ,GHandle}...
	); 

	GHandle.TempWindow.NewAtlasFigure.Visible = 'on';

end

function load_atlas(~,~, GHandle)
	name = GHandle.TempWindow.NewAtlasName.Value;
	note = GHandle.TempWindow.NewAtlasNote.Value;
	GHandle.Temp.location = GHandle.TempWindow.NewAtlasWidget.Value;
	loadatlasfrommat(GHandle);
	GHandle.CurrentDataSet.Atlas.name = name;
	GHandle.CurrentDataSet.Atlas.note = note;
	
	DataBase = GHandle.DataBase.add(GHandle.CurrentDataSet.Atlas, name, GHandle.Temp);
	GHandle.DataBase = DataBase;
	tree(GHandle);
end
















