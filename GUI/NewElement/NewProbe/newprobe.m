function newprobe(~, ~, GHandle)

figureSize = GHandle.Preference.Figure.sizeLarge;
AtlasList = GHandle.DataBase.Atlas;
axesBackgroundColor = 'w';
GHandle.TempWindow.Zoom = false;

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
	'Visible', 'off', ...
	'DeleteFcn', {@close_figure, GHandle});

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
	'String', 'Save',...
	'Units', 'normalize', ...
	'Position', [0.85 0.05 0.1 0.05],...
	'Callback', {@load_probe ,GHandle}...
	);

GHandle.TempWindow.AtlasWidget = uiw.widget.EditablePopup(...
	'Parent',GHandle.TempWindow.NewProbeFigure,...
	'Items', ['2D Probe',{AtlasList.tag}],...
	'UserData',[{'NoAtlas'}; num2cell(AtlasList)],...
	'Label','Atlas',...
	'LabelLocation','top',...
	'Callback',@(Handle,Event)atlas_widget_callback(Handle,Event,GHandle),...
	'Units','normalized',...
	'Position',[0.05 0.75 0.2 0.1]);

GHandle.TempWindow.SourceListTitle = uicontrol('Style', 'text',...
	'Parent', GHandle.TempWindow.NewProbeFigure, ...
	'String', 'Sources',...
	'Visible','on',...
	'Units', 'normalize', ...
	'HorizontalAlignment', 'left', ...
	'Position', [0.27 0.9 0.08 0.02]);

GHandle.TempWindow.DetectorListTitle = uicontrol('Style', 'text',...
	'Parent', GHandle.TempWindow.NewProbeFigure, ...
	'String', 'Detectors',...
	'Visible','on',...
	'Units', 'normalize', ...
	'HorizontalAlignment', 'left', ...
	'Position', [0.36 0.9 0.08 0.02]);

GHandle.TempWindow.SourceList = uicontrol(...
	'Parent', GHandle.TempWindow.NewProbeFigure, ...
	'Style','listbox',...
	'Units', 'normalize', ...
	'Max', 2,...
	'Position',  [0.27 0.5 0.08 0.40],...
	'String',[],...
	'Value',[]);

GHandle.TempWindow.SourceContextMenu = uicontextmenu('Parent',GHandle.TempWindow.NewProbeFigure);
uimenu(GHandle.TempWindow.SourceContextMenu,'Label','Delete','callback',{@delete_source, GHandle});
set(GHandle.TempWindow.SourceList,'UIContextMenu',GHandle.TempWindow.SourceContextMenu);
addlistener(GHandle.TempWindow.SourceList,'UserData','PostSet',@(src,evnt)channelrefresh(src,evnt,GHandle));

GHandle.TempWindow.DetectorList = uicontrol(...
	'Parent', GHandle.TempWindow.NewProbeFigure, ...
	'Style','listbox',...
	'Units', 'normalize', ...
	'Max', 2,...
	'Position',  [0.36 0.5 0.08 0.40],...
	'String',[],...
	'Value',[]);

GHandle.TempWindow.DetectorContextMenu = uicontextmenu('Parent',GHandle.TempWindow.NewProbeFigure);
uimenu(GHandle.TempWindow.DetectorContextMenu,'Label','Delete','callback',{@delete_detector, GHandle});
set(GHandle.TempWindow.DetectorList,'UIContextMenu',GHandle.TempWindow.DetectorContextMenu);
addlistener(GHandle.TempWindow.DetectorList,'UserData','PostSet',@(src,evnt)channelrefresh(src,evnt,GHandle));

GHandle.TempWindow.ChannelListTitle = uicontrol('Style', 'text',...
	'Parent', GHandle.TempWindow.NewProbeFigure, ...
	'String', 'Channels',...
	'Visible','on',...
	'Units', 'normalize', ...
	'HorizontalAlignment', 'left', ...
	'Position', [0.05 0.45 0.39 0.02]);

GHandle.TempWindow.ChannelList = uitable(...
	'Parent', GHandle.TempWindow.NewProbeFigure, ...
	'Units', 'normalize', ...
	'Data', {}, ...
	'ColumnName', {'Name', 'S', 'D', 'SD distance (mm)', 'Active'}, ...
	'ColumnEditable',[true false false false true], ...
	'ColumnWidth', {100 50 50 150 50}, ...
	'ColumnFormat', {'char' 'numeric', 'numeric', 'numeric', 'logical'}, ...
	'Position',  [0.05 0.05 0.39 0.40]);

GHandle.TempWindow.SgaPuffoPanel = uipanel(...
	'Parent',GHandle.TempWindow.NewProbeFigure,...
	'BackgroundColor', axesBackgroundColor, ...
	'Units', 'normalize', ...
	'Position',[0.5 0.2 0.45 0.75],...
	'BorderType', 'line');

GHandle.TempWindow.NewProbeAxes = axes(...
	'Parent',GHandle.TempWindow.SgaPuffoPanel,...
	'Units', 'normalize', ...
	'Position',[0 0 1 0.9],...
	'NextPlot','add',...
	'Visible', 'off');

GHandle.TempWindow.NewProbeRotateButton = uicontrol('Style', 'togglebutton',...
	'Parent', GHandle.TempWindow.SgaPuffoPanel, ...
	'String', 'R',...
	'Enable','off',...
	'Units', 'normalize', ...
	'Position', [0 0.95 0.05 0.05],...
	'Callback', {@rotate_Atlas ,GHandle}...
	);

GHandle.TempWindow.NewProbeZoomButton = uicontrol('Style', 'togglebutton',...
	'Parent', GHandle.TempWindow.SgaPuffoPanel, ...
	'String', 'Z+',...
	'Enable','off',...
	'Units', 'normalize', ...
	'Position', [0.05 0.95 0.05 0.05],...
	'Callback', {@zoom_Atlas ,GHandle}...
	);

GHandle.TempWindow.OptionsPanel = uipanel(...
	'Parent',GHandle.TempWindow.NewProbeFigure,...
	'Units', 'normalize', ...
	'Title', 'Channel options', ...
	'Position',[0.5 0.05 0.25 0.13]);

GHandle.TempWindow.MirrorProbe = uicontrol('Style', 'checkbox',...
	'Parent', GHandle.TempWindow.OptionsPanel, ...
	'String', 'Mirror probe L/R',...
	'Visible', 'on',...
	'Units', 'normalize', ...
	'HorizontalAlignment', 'left', ...
	'Position', [0.55 0.55 0.4 0.25]);

[GHandle.TempWindow.ThresholdPanel, ~, GHandle.TempWindow.ThresholdDistance] = gtextedit(...
	'Parent', GHandle.TempWindow.OptionsPanel,...
	'label','Max SD distance', ...
	'position',[0.1 0.1 0.35 0.8],...
	'spacing',0.1,...
	'text','30',...
	'callback',{@threshold_distance_callback, GHandle},...
	'texttype','edit',...
	'sizeratio',1,...
	'configuration','vertical');
addlistener(GHandle.TempWindow.ThresholdDistance,'String','PostSet',@(src,evnt)channelrefresh(src,evnt,GHandle));

GHandle.TempWindow.ShowInactive = uicontrol('Style', 'checkbox', ...
	'Parent', GHandle.TempWindow.OptionsPanel, ...
	'String', 'Show inactive', ...
	'Value', 1, ...
	'Visible','on', ...
	'Units', 'normalize', ...
	'HorizontalAlignment', 'left', ...
	'Callback', {@threshold_distance_callback, GHandle}, ...
	'Position', [0.55 0.1 0.35 0.35]);

GHandle.TempWindow.light(1) = light(GHandle.TempWindow.NewProbeAxes,...
	'Position',[100 0 0]);
GHandle.TempWindow.light(2) = light(GHandle.TempWindow.NewProbeAxes,...
	'Position',[-100 0 0]);

GHandle.TempWindow.NewProbeFigure.Visible = 'on';
end


function load_probe(~, ~, GHandle)
probeName = GHandle.TempWindow.NewProbeName.Value;
note = GHandle.TempWindow.NewProbeNote.Value;

NewProbe = NirsProbe('name', probeName, 'note', note);

DataBase = GHandle.DataBase.add(NewProbe);

GHandle.DataBase = DataBase;

tree(GHandle);

GHandle.Main.Tree.TabGroup.SelectedTab = GHandle.Main.Tree.ProbeTab;
end


function threshold_distance_callback(~,~,GHandle)

showInactive = GHandle.TempWindow.ShowInactive.Value;
thresholdDistance = str2double(GHandle.TempWindow.ThresholdDistance.String);

if ~isempty(GHandle.TempWindow.ChannelList.Data)
    GHandle.TempWindow.ChannelList.Data(:,5) =  num2cell([GHandle.TempWindow.ChannelList.Data{:,4}] < thresholdDistance);
    
    activeMask = [GHandle.TempWindow.ChannelList.Data{:,5}];
    if showInactive
        set(GHandle.TempWindow.Channel(~activeMask),'Visible', 'on');
        set(GHandle.TempWindow.ChannelText(~activeMask),'Visible', 'on');
    else
        set(GHandle.TempWindow.Channel(~activeMask),'Visible', 'off');
        set(GHandle.TempWindow.ChannelText(~activeMask),'Visible', 'off');
    end
end
end

function delete_source(~, ~, GHandle)
idx2Delete = GHandle.TempWindow.SourceList.Value;
GHandle.TempWindow.SourceList.Value = [];
set(GHandle.TempWindow.LandMark(GHandle.TempWindow.SourceList.UserData(idx2Delete)),'Color','g');
GHandle.TempWindow.SourceList.String(idx2Delete) = [];
GHandle.TempWindow.SourceList.UserData(idx2Delete) = [];
end

function delete_detector(~, ~, GHandle)
idx2Delete = GHandle.TempWindow.DetectorList.Value;
GHandle.TempWindow.DetectorList.Value = [];
set(GHandle.TempWindow.LandMark(GHandle.TempWindow.DetectorList.UserData(idx2Delete)),'Color','g');
GHandle.TempWindow.DetectorList.String(idx2Delete) = [];
GHandle.TempWindow.DetectorList.UserData(idx2Delete) = [];
end

function rotate_Atlas(Handle, ~, GHandle)
if Handle.Value
	rotate3d(GHandle.TempWindow.NewProbeAxes, 'on');
else
	rotate3d(GHandle.TempWindow.NewProbeAxes, 'off');
end
end

function zoom_Atlas(Handle, ~, GHandle)
if Handle.Value
	GHandle.TempWindow.Temp.CameraTarget = GHandle.TempWindow.NewProbeAxes.CameraTarget;
	GHandle.TempWindow.Temp.CameraPosition = GHandle.TempWindow.NewProbeAxes.CameraPosition;
	GHandle.TempWindow.Temp.CameraViewAngle = GHandle.TempWindow.NewProbeAxes.CameraViewAngle;
	Handle.String = 'Z-';
	GHandle.TempWindow.NewProbeRotateButton.Value = 0;
	rotate3d(GHandle.TempWindow.NewProbeAxes, 'off');
	GHandle.TempWindow.Zoom = true;
else
	Handle.String = 'Z+';
	GHandle.TempWindow.NewProbeAxes.CameraTarget = GHandle.TempWindow.Temp.CameraTarget;
	GHandle.TempWindow.NewProbeAxes.CameraPosition = GHandle.TempWindow.Temp.CameraPosition;
	GHandle.TempWindow.NewProbeAxes.CameraViewAngle = GHandle.TempWindow.Temp.CameraViewAngle;
	GHandle.TempWindow.Zoom = false;
end
end

function close_figure(Handle, ~, GHandle)
delete(Handle);
GHandle.TempWindow = [];
end

