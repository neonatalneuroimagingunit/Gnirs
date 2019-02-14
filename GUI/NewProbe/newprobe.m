function newprobe(~, ~, GHandle)

figureSize = GHandle.Preference.Figure.sizeLarge;
AtlasList = GHandle.DataBase.Atlas;
axesBackgroundColor = GHandle.Preference.Theme.axesBackgroundColor;
BackgroundColor = GHandle.Preference.Theme.backgroundColor;
ForegroundColor = GHandle.Preference.Theme.foregroundColor;
GHandle.TempWindow.Zoom = false;

GHandle.TempWindow.NewProbeFigure = figure(...
    'position', figureSize,...
    'Color', BackgroundColor, ...
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

%% Panels
GHandle.TempWindow.WidgetPanel = uipanel(...
    'Parent',GHandle.TempWindow.NewProbeFigure,...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'Units', 'normalize', ...
    'Position',[0.05 0.05 0.4 0.9], ...
    'BorderType', 'line');

GHandle.TempWindow.AxesPanel = uipanel(...
    'Parent',GHandle.TempWindow.NewProbeFigure,...
    'BackgroundColor', axesBackgroundColor, ...
    'Units', 'normalize', ...
    'Position',[0.5 0.2 0.45 0.75],...
    'BorderType', 'line');

GHandle.TempWindow.OptionPanel = uipanel(...
    'Parent',GHandle.TempWindow.NewProbeFigure,...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'Units', 'normalize', ...
    'Title', 'Options', ...
    'Position',[0.5 0.05 0.25 0.13], ...
    'BorderType', 'line');

%% Widgets panel
GHandle.TempWindow.ProbeNameLabel = uicontrol('Style', 'text',...
    'Parent', GHandle.TempWindow.WidgetPanel, ...
    'String', 'Probe Name',...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'Visible','on',...
    'Units', 'normalize', ...
    'HorizontalAlignment', 'left', ...
    'Position', [0.05 0.93 0.475 0.02]);
GHandle.TempWindow.ProbeName = uicontrol('Style', 'edit',...
    'Parent', GHandle.TempWindow.WidgetPanel, ...
    'String', 'Insert Name',...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'Visible','on',...
    'Units', 'normalize', ...
    'HorizontalAlignment', 'left', ...
    'Position', [0.05 0.88 0.475 0.04]);

% GHandle.TempWindow.AtlasWidget = uiw.widget.EditablePopup(...
%     'Parent',GHandle.TempWindow.WidgetPanel,...
%     'Items', ['2D Probe',{AtlasList.tag}],...
%     'UserData',[{'NoAtlas'}; num2cell(AtlasList)],...
%     'BackgroundColor', BackgroundColor, ...
%     'ForegroundColor', ForegroundColor, ...
%     'Label','Atlas',...
%     'LabelLocation','top',...
%     'Callback',@(Handle,Event)atlaswidgetcallback(Handle,Event,GHandle),...
%     'Units','normalized',...
%     'Position',[0.05 0.75 0.475 0.1]);
GHandle.TempWindow.AtlasLabel = uicontrol('Style', 'text',...
    'Parent', GHandle.TempWindow.WidgetPanel, ...
    'String', 'Atlas',...
    'Visible','on',...
    'Units', 'normalize', ...
    'HorizontalAlignment', 'left', ...
    'Position', [0.05 0.82 0.475 0.02]);
GHandle.TempWindow.AtlasPopup = uicontrol('Style', 'popup',...
    'Parent', GHandle.TempWindow.WidgetPanel, ...
    'String', 'Insert Note',...
    'Visible','on',...
    'Units', 'normalize', ...
    'HorizontalAlignment', 'left', ...
    'String', {AtlasList.tag}, ...
    'Callback',@(Handle,Event)atlaswidgetcallback(Handle,Event,GHandle),...
    'Position', [0.05 0.77 0.475 0.04]);

GHandle.TempWindow.NoteLabel = uicontrol('Style', 'text',...
    'Parent', GHandle.TempWindow.WidgetPanel, ...
    'String', 'Note',...
    'Visible','on',...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'Units', 'normalize', ...
    'HorizontalAlignment', 'left', ...
    'Position', [0.05 0.71 0.475 0.02]);
GHandle.TempWindow.Note = uicontrol('Style', 'edit',...
    'Parent', GHandle.TempWindow.WidgetPanel, ...
    'String', 'Insert Note',...
    'Visible','on',...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'Units', 'normalize', ...
    'HorizontalAlignment', 'left', ...
    'Max', 2, ...
    'Position', [0.05 0.5 0.475 0.20]);

GHandle.TempWindow.SourceListTitle = uicontrol('Style', 'text',...
    'Parent', GHandle.TempWindow.WidgetPanel, ...
    'String', 'Sources',...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'Visible','on',...
    'Units', 'normalize', ...
    'HorizontalAlignment', 'left', ...
    'Position', [0.575 0.93 0.1775 0.02]);
GHandle.TempWindow.SourceList = uicontrol(...
    'Parent', GHandle.TempWindow.WidgetPanel, ...
    'Style','listbox',...
    'Units', 'normalize', ...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'Max', 2,...
    'Position',  [0.575 0.5 0.1775 0.42],...
    'callback',{@tempplotfunc, GHandle},...
    'String',[],...
    'Value',[]);
GHandle.TempWindow.SourceContextMenu = uicontextmenu('Parent', GHandle.TempWindow.NewProbeFigure);
uimenu(GHandle.TempWindow.SourceContextMenu,'Label','Delete','callback',{@delete_source, GHandle});
set(GHandle.TempWindow.SourceList,'UIContextMenu',GHandle.TempWindow.SourceContextMenu);

GHandle.TempWindow.DetectorListTitle = uicontrol('Style', 'text',...
    'Parent', GHandle.TempWindow.WidgetPanel, ...
    'String', 'Detectors',...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'Visible','on',...
    'Units', 'normalize', ...
    'HorizontalAlignment', 'left', ...
    'Position', [0.7725 0.93 0.1775 0.02]);
GHandle.TempWindow.DetectorList = uicontrol(...
    'Parent', GHandle.TempWindow.WidgetPanel, ...
    'Style','listbox',...
    'Units', 'normalize', ...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'Max', 2,...
    'Position',  [0.7725 0.5 0.1775 0.42],...
    'callback',{@tempplotfunc, GHandle},...
    'String',[],...
    'Value',[]);
GHandle.TempWindow.DetectorContextMenu = uicontextmenu('Parent', GHandle.TempWindow.NewProbeFigure);
uimenu(GHandle.TempWindow.DetectorContextMenu,'Label','Delete','callback',{@delete_detector, GHandle});
set(GHandle.TempWindow.DetectorList,'UIContextMenu',GHandle.TempWindow.DetectorContextMenu);

GHandle.TempWindow.ChannelListTitle = uicontrol('Style', 'text',...
    'Parent', GHandle.TempWindow.WidgetPanel, ...
    'String', 'Channels',...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'Visible','on',...
    'Units', 'normalize', ...
    'HorizontalAlignment', 'left', ...
    'Position', [0.05 0.45 0.39 0.02]);

GHandle.TempWindow.ChannelList = uitable(...
    'Parent', GHandle.TempWindow.WidgetPanel, ...
    'Units', 'normalize', ...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'Data', cell(0,5), ...
    'CellEditCallback', {@tempplotfunc, GHandle}, ...
    'CellSelectionCallback', {@select_row, GHandle}, ...
    'ColumnName', {'Name', 'S', 'D', 'SD distance (mm)', 'Active'}, ...
    'ColumnEditable',[false false false false true], ...
    'ColumnWidth', {100 50 50 150 50}, ...
    'ColumnFormat', {'char' 'char', 'char', 'numeric', 'logical'}, ...
    'Position',  [0.05 0.05 0.9 0.39]);

%% Axes panel
GHandle.TempWindow.NewProbeAxes = axes(...
    'Parent',GHandle.TempWindow.AxesPanel,...
    'Units', 'normalize', ...
    'Position',[0 0 1 0.9],...
    'NextPlot','add',...
    'Visible', 'off');

GHandle.TempWindow.NewProbeRotateButton = uicontrol('Style', 'togglebutton',...
    'Parent', GHandle.TempWindow.AxesPanel, ...
    'String', 'R',...
    'Enable','off',...
    'Units', 'normalize', ...
    'Position', [0 0.95 0.05 0.05],...
    'Callback', {@rotate_Atlas ,GHandle}...
    );

GHandle.TempWindow.NewProbeZoomButton = uicontrol('Style', 'togglebutton',...
    'Parent', GHandle.TempWindow.AxesPanel, ...
    'String', 'Z+',...
    'Enable','off',...
    'Units', 'normalize', ...
    'Position', [0.05 0.95 0.05 0.05],...
    'Callback', {@zoom_Atlas ,GHandle}...
    );

%% Options panel
GHandle.TempWindow.ThresholdDistanceEdit = uicontrol('Style', 'edit',...
    'Parent', GHandle.TempWindow.OptionPanel,...
    'Units', 'normalize', ...
    'ForegroundColor', ForegroundColor,...
    'BackgroundColor', BackgroundColor,...
    'Callback',{@tempplotfunc, GHandle},...
    'Visible', 'on', ...
    'Enable', 'off', ...
    'Position', [0.1 0.1 0.35 0.35],...
    'String', '30');

GHandle.TempWindow.ThresholdDistanceButton = uicontrol('Style', 'togglebutton',...
    'Parent', GHandle.TempWindow.OptionPanel,...
    'Units', 'normalize', ...
    'ForegroundColor', ForegroundColor,...
    'BackgroundColor', BackgroundColor,...
    'Callback',{@tempplotfunc, GHandle},...
    'Visible', 'on', ...
    'Position', [0.1 0.6 0.35 0.35],...
    'String', 'Auto Threshold');

GHandle.TempWindow.MirrorProbe = uicontrol('Style', 'checkbox',...
    'Parent', GHandle.TempWindow.OptionPanel, ...
    'String', 'Mirror probe L/R',...
    'Visible', 'on',...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'callback',{@tempplotfunc, GHandle},...
    'Units', 'normalize', ...
    'HorizontalAlignment', 'left', ...
    'Position', [0.55 0.6 0.35 0.35]);
GHandle.TempWindow.ShowLabels = uicontrol('Style', 'checkbox',...
    'Parent', GHandle.TempWindow.OptionPanel, ...
    'String', 'Show labels',...
    'Visible', 'on',...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'Units', 'normalize', ...
    'Value', 0, ...
    'callback',{@tempplotfunc, GHandle},...
    'HorizontalAlignment', 'left', ...
    'Position', [0.55 0.35 0.35 0.35]);
GHandle.TempWindow.ShowInactive = uicontrol('Style', 'checkbox', ...
    'Parent', GHandle.TempWindow.OptionPanel, ...
    'String', 'Show inactive', ...
    'Value', 1, ...
    'Visible','on', ...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'Units', 'normalize', ...
    'HorizontalAlignment', 'left', ...
    'Callback', {@tempplotfunc, GHandle}, ...
    'Position', [0.55 0.1 0.35 0.35]);

%% Save
GHandle.TempWindow.SaveButton = uicontrol('Style', 'pushbutton',...
    'Parent', GHandle.TempWindow.NewProbeFigure, ...
    'BackgroundColor', BackgroundColor, ...
    'ForegroundColor', ForegroundColor, ...
    'String', 'Save',...
    'Units', 'normalize', ...
    'Position', [0.85 0.05 0.1 0.05],...
    'Callback', {@save_probe ,GHandle}...
    );

%% Turn on
GHandle.TempWindow.NewProbeFigure.Visible = 'on';

end

function select_row(~ , evnt , GHandle)
temp1 = GHandle.TempWindow.ChannelList.CellSelectionCallback;
temp2 = GHandle.TempWindow.ChannelList.CellEditCallback;
GHandle.TempWindow.ChannelList.CellSelectionCallback = [];
GHandle.TempWindow.ChannelList.CellEditCallback = [];
backgroundColor = [1.0000    1.0000    1.0000;
    0.9400    0.9400    0.9400];
nCell = size(GHandle.TempWindow.ChannelList.Data,1);
GHandle.TempWindow.ChannelList.BackgroundColor = repmat(backgroundColor,[ceil(nCell/2),1]);
if ~isempty(evnt.Indices)
    GHandle.TempWindow.ChannelList.BackgroundColor(evnt.Indices(1),:) = [0 0 1];
end
drawnow;
GHandle.TempWindow.ChannelList.CellSelectionCallback = temp1;
GHandle.TempWindow.ChannelList.CellEditCallback = temp2;
end

function save_probe(~, ~, GHandle)
probeName = GHandle.TempWindow.ProbeName.String;
note = GHandle.TempWindow.Note.Value;
atlasID = GHandle.TempWindow.SelectedAtlas.id;
landMark = GHandle.TempWindow.SelectedAtlas.LandMarks;

idxSrc = GHandle.TempWindow.Mask.Source(:);
idxDet = GHandle.TempWindow.Mask.Detector(:);
xLandMark = reshape(landMark.coord(:,:,1), [],1);
yLandMark = reshape(landMark.coord(:,:,2), [],1);
zLandMark = reshape(landMark.coord(:,:,3), [],1);

detectorMask = GHandle.TempWindow.Mask.Detector;
Detector.label = landMark.names(detectorMask);
[xPos,yPos] = find(detectorMask);
Detector.position2D = [xPos,yPos];
Detector.position = [xLandMark(idxDet), yLandMark(idxDet), zLandMark(idxDet)];

sourceMask = GHandle.TempWindow.Mask.Source;
Source.label = landMark.names(sourceMask);
[xPos,yPos] = find(sourceMask);
Source.position2D = [xPos,yPos];
Source.position = [xLandMark(idxSrc), yLandMark(idxSrc), zLandMark(idxSrc)];

idxChannel = find([GHandle.TempWindow.ChannelList.Data{:,5}] == 1);
Channel.label = GHandle.TempWindow.ChannelList.Data(idxChannel,1);
Channel.distance = [GHandle.TempWindow.ChannelList.Data{idxChannel,4}]';
channelPairsIdx = combvec(1:size(Source.label,1), 1:size(Detector.label,1))';
Channel.pairs = channelPairsIdx(idxChannel,:);

NewProbe = NirsProbe('tag', probeName, 'atlasid', atlasID, 'note', note, 'detector', Detector, 'source', Source, 'channel', Channel);
DataBase = GHandle.DataBase.add(NewProbe);
GHandle.DataBase = DataBase;

tree(GHandle);
close(GHandle.TempWindow.NewProbeFigure);
end

function delete_source(~, ~, GHandle)
idx2Delete = GHandle.TempWindow.SourceList.Value;
nEl2Delete = size(idx2Delete,2);
mask = false([size(GHandle.TempWindow.Mask.LandMark),nEl2Delete]);
for iMask = 1 : 1 : nEl2Delete
    mask(:,:,iMask) = strcmp(GHandle.TempWindow.SelectedAtlas.LandMarks.names, GHandle.TempWindow.SourceList.String(idx2Delete(iMask)));
end
mask = any(mask,3);
GHandle.TempWindow.Mask.LandMark(mask) = true;
GHandle.TempWindow.Mask.Source(mask) = false;
GHandle.TempWindow.SourceList.Value = [];
tempplotfunc([],[],GHandle)
end

function delete_detector(~, ~, GHandle)
idx2Delete = GHandle.TempWindow.DetectorList.Value;
nEl2Delete = size(idx2Delete,2);
mask = false([size(GHandle.TempWindow.Mask.LandMark),nEl2Delete]);
for iMask = 1 : 1 : nEl2Delete
    mask(:,:,iMask) = strcmp(GHandle.TempWindow.SelectedAtlas.LandMarks.names, GHandle.TempWindow.DetectorList.String(idx2Delete(iMask)));
end
mask = any(mask,3);
GHandle.TempWindow.Mask.LandMark(mask) = true;
GHandle.TempWindow.Mask.Detector(mask) = false;
GHandle.TempWindow.DetectorList.Value = [];
tempplotfunc([],[],GHandle)
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
    
    stepIdx = linspace(1,size(GHandle.TempWindow.Mask.LandMark,1),21);
    
    GHandle.TempWindow.Mask.LandMark(:) = false;
    GHandle.TempWindow.Mask.LandMark(stepIdx,stepIdx) = true;
    tempplotfunc([],[],GHandle)
end
end

function close_figure(Handle, ~, GHandle)
delete(Handle);
GHandle.TempWindow = [];
end
