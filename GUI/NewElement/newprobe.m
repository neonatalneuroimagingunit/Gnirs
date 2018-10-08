function newprobe(~, ~, GHandle)
	
	figureSize = GHandle.Preference.Figure.sizeLarge;
	AtlasList = GHandle.DataBase.Atlas;

	GHandle.TempWindow.NewProbeFigure = figure(...
	'position', figureSize,...
    'Resize', 'on',...
    'Name', 'New NIRS Probe', ...
    'Numbertitle', 'off', ...
    'Toolbar', 'none', ...
    'Menubar', 'none', ...
    'DoubleBuffer', 'on', ...
    'DockControls', 'off', ...
    'Renderer', 'OpenGL',...
	'Visible', 'off' ...
	);
	
	GHandle.TempWindow.NewProbeName = uiw.widget.EditableText(...      
    'Parent',GHandle.TempWindow.NewProbeFigure,...=
    'Value','Insert Name',...
    'Label','Probe Name:',...
    'LabelLocation','top',...
    'LabelWidth',90,...
    'Units','normalized',...
    'Position',[0.05 0.90 0.15 0.08]);

	GHandle.TempWindow.NewProbeNote = uiw.widget.EditableText(...      
    'Parent',GHandle.TempWindow.NewProbeFigure,...
    'Value','Insert Note',...
    'Label','Probe Note:',...
	'IsMultiLine', 1,...
    'LabelLocation','top',...
    'LabelWidth',90,...
    'Units','normalized',...
    'Position',[0.05 0.5 0.20 0.20]);

	
	GHandle.TempWindow.NewProbeLoadButton = uicontrol('Style', 'pushbutton',...	
    'Parent', GHandle.TempWindow.NewProbeFigure, ...
	'String', 'Load',...
	'Units', 'normalize', ...
	'Position', [0.8 0.15 0.1 0.05],...
	'Callback', {@load_probe ,GHandle}...
	); 

	 GHandle.TempWindow.AtlasWidget = uiw.widget.EditablePopup(...
		'Parent',GHandle.TempWindow.NewProbeFigure,...
		'Items', ['2D Probe',{AtlasList.tag}],...
		'UserData',[{'NoAtlas'}, {AtlasList}],...
		'Label','Atlas',...
		'LabelLocation','top',...
		'Callback',@(Handle,Event)atlas_widget_callback(Handle,Event,GHandle),...
		'Units','normalized',...
		'Position',[0.05 0.75 0.2 0.1]);  

	GHandle.TempWindow.SourceList = uicontrol(...
			'Parent', GHandle.TempWindow.NewProbeFigure, ...
			'Style','listbox',...
			'Units', 'normalize', ...
			'Max', 2,...
			'Position',  [0.05 0.05 0.20 0.40],...
			'String',[],...
			'Value',[]);
		
	GHandle.TempWindow.DetectorList = uicontrol(...
			'Parent', GHandle.TempWindow.NewProbeFigure, ...
			'Style','listbox',...
			'Units', 'normalize', ...
			'Max', 2,...
			'Position',  [0.30 0.05 0.20 0.40],...
			'String',[],...
			'Value',[]);
		
	GHandle.TempWindow.NewProbe3DAxes = axes(...      
		'Parent',GHandle.TempWindow.NewProbeFigure,...
		'Units', 'normalize', ...
		'Position',[0.5 0.3 0.4 0.4],...
		'NextPlot','add',...
		'Visible', 'off');
% 	set(GHandle.TempWindow.NewProbeAxes,'CameraViewAngle',get(GHandle.TempWindow.NewProbeAxes,'CameraViewAngle'));
% 	set(GHandle.TempWindow.NewProbeAxes,'PlotBoxAspectRatio',get(GHandle.TempWindow.NewProbeAxes,'PlotBoxAspectRatio'));
% 	set(GHandle.TempWindow.NewProbeAxes,'DataAspectRatio',get(GHandle.TempWindow.NewProbeAxes,'DataAspectRatio'));
% 	rotate3d(GHandle.TempWindow.NewProbeAxes, 'on');
	
	GHandle.TempWindow.NewProbe2DAxes = axes(...      
		'Parent',GHandle.TempWindow.NewProbeFigure,...
		'Units', 'normalize', ...
		'Position',[0.5 0.3 0.4 0.4],...
		'NextPlot','add',...
		'Visible', 'off');

	GHandle.TempWindow.NewProbeFigure.Visible = 'on';

end


function load_probe(~, ~, GHandle )
	probeName = GHandle.TempWindow.NewProbeName.Value;
	note = GHandle.TempWindow.NewProbeNote.Value;

	NewProbe = NirsProbe('name', probeName, 'note', note);
	
	DataBase = GHandle.DataBase.add(NewProbe);

	GHandle.DataBase = DataBase;
		
	tree(GHandle);
	
	GHandle.Main.Tree.TabGroup.SelectedTab = GHandle.Main.Tree.ProbeTab;
end

function atlas_widget_callback(Handle,Event,GHandle)

end


