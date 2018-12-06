function viewerpanel(viewerC, GHandle, vIdx)

trackTableColumnName = { 'S', 'D','Wavelength', 'SD distance (mm)','Name'};
trackTableColumnFormat = {'char' 'char', 'numeric', 'numeric', 'char'};

eventTableColumnName = {'Label', 'Code', 'Start (s)', 'Duration (s)'};
eventTableColumnFormat = {'char' 'char', 'numeric', 'numeric'};

%% Main splits
GHandle.Viewer(vIdx).mainLayout = uix.VBoxFlex(...
    'Parent', GHandle.Viewer(vIdx).mainFigure,...
    'Spacing', 8 );
GHandle.Viewer(vIdx).PlotInfoLayout = uix.HBoxFlex(...
    'Parent', GHandle.Viewer(vIdx).mainLayout, ...
    'Spacing', 8);
GHandle.Viewer(vIdx).ViewLayout = uix.HBoxFlex(...
    'Parent', GHandle.Viewer(vIdx).mainLayout, ...
    'Spacing', 3 );


%% Panels
GHandle.Viewer(vIdx).PlotPanel.Panel = uix.BoxPanel( ...
    'Parent', GHandle.Viewer(vIdx).PlotInfoLayout, ...
    'Title', 'Plot', ...
    'HelpFcn', @onDemoHelp );
GHandle.Viewer(vIdx).InfoPanel.Panel = uix.BoxPanel( ...
    'Parent', GHandle.Viewer(vIdx).PlotInfoLayout, ...
    'Title', 'Info', ...
    'HelpFcn', {@onDemoHelp, GHandle} );

GHandle.Viewer(vIdx).VideoPanel.Panel = uix.BoxPanel( ...
    'Parent', GHandle.Viewer(vIdx).ViewLayout, ...
    'Title', 'Video', ...
    'HelpFcn', @onDemoHelp );
GHandle.Viewer(vIdx).PreferencePanel.Panel = uix.BoxPanel( ...
    'Parent', GHandle.Viewer(vIdx).ViewLayout, ...
    'Title', 'Preferences', ...
    'HelpFcn', @onDemoHelp );
GHandle.Viewer(vIdx).ProbePanel.Panel = uix.BoxPanel( ...
    'Parent', GHandle.Viewer(vIdx).ViewLayout, ...
    'Title', 'Probe', ...
    'HelpFcn', @onDemoHelp );
GHandle.Viewer(vIdx).DataPanel.Panel = uix.BoxPanel( ...
    'Parent', GHandle.Viewer(vIdx).ViewLayout, ...
    'Title', 'Data', ...
    'HelpFcn', @onDemoHelp );


%% Plot
GHandle.Viewer(vIdx).PlotPanel.TabGroup = uitabgroup(GHandle.Viewer(vIdx).PlotPanel.Panel);
GHandle.Viewer(vIdx).PlotPanel.TimeTab = uitab('Parent', GHandle.Viewer(vIdx).PlotPanel.TabGroup, ...
    'Title', 'Time', ...
    'BackgroundColor', viewerC.backgroundColor, ...
    'ForegroundColor', viewerC.textForegroundColor);
GHandle.Viewer(vIdx).PlotPanel.FrequencyTab = uitab('Parent', GHandle.Viewer(vIdx).PlotPanel.TabGroup, ...
    'Title', 'Spectrum', ...
    'BackgroundColor', viewerC.backgroundColor, ...
    'ForegroundColor', viewerC.textForegroundColor);
GHandle.Viewer(vIdx).PlotPanel.TimeFrequencyTab = uitab('Parent', GHandle.Viewer(vIdx).PlotPanel.TabGroup, ...
    'Title', 'Time-Frequency', ...
    'BackgroundColor', viewerC.backgroundColor, ...
    'ForegroundColor', viewerC.textForegroundColor);

%% Info
GHandle.Viewer(vIdx).InfoPanel.VPanel = uix.VBox(...
    'Parent', GHandle.Viewer(vIdx).InfoPanel.Panel,...
    'BackgroundColor', viewerC.backgroundColor...
    );

%% Video

%% Preferences
GHandle.Viewer(vIdx).PreferencePanel.VPanel = uix.VBox(...
    'Parent', GHandle.Viewer(vIdx).PreferencePanel.Panel,...
    'BackgroundColor', viewerC.backgroundColor...
    );

%% Probe
GHandle.Viewer(vIdx).ProbePanel.ProbeAxes = axes('Parent', GHandle.Viewer(vIdx).ProbePanel.Panel,...
    'Position',  [0.05 0.05 0.9 0.9], ...
    'Units', 'normalized', ...
    'Color', viewerC.backgroundColor, ...
    'XColor', viewerC.foregroundColor, ...
    'YColor', viewerC.foregroundColor, ...
    'Xgrid', 'on', ...
    'Ygrid', 'on', ...
    'GridColor', viewerC.foregroundColor, ...
    'NextPlot', 'add',...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', viewerC.defaultFontName, ...
    'Visible', 'off', ...
    'Title', 'Probe plot');

%% Tracks
GHandle.Viewer(vIdx).DataPanel.TabGroup = uitabgroup('Parent', GHandle.Viewer(vIdx).DataPanel.Panel, ...
    'Position',[0 0 1 0.97]);
GHandle.Viewer(vIdx).DataPanel.TrackTab = uitab('Parent',GHandle.Viewer(vIdx).DataPanel.TabGroup, ...
    'Title', 'Tracks', ...
    'BackgroundColor', viewerC.backgroundColor, ...
    'ForegroundColor', viewerC.textForegroundColor);
GHandle.Viewer(vIdx).DataPanel.EventTab = uitab('Parent', GHandle.Viewer(vIdx).DataPanel.TabGroup, ...
    'Title', 'Events', ...
    'BackgroundColor', viewerC.backgroundColor, ...
    'ForegroundColor', viewerC.textForegroundColor);



GHandle.Viewer(vIdx).DataPanel.TrackTable = uiw.widget.Table(...
    'Parent', GHandle.Viewer(vIdx).DataPanel.TrackTab, ...
    'Units', 'normalize', ...
    'ColumnName', trackTableColumnName, ...
    'CellSelectionCallback', {@channel_table_selection_callback, GHandle, vIdx},...
    'ColumnResizePolicy', 'all', ...
    'ColumnFormat',trackTableColumnFormat, ...
    'Position',  [0 0 1 1],...
    'Sortable', true,...
    'LabelVisible','off');

GHandle.Viewer(vIdx).DataPanel.EventTable = uiw.widget.Table(...
    'Parent',  GHandle.Viewer(vIdx).DataPanel.EventTab, ...
    'Units', 'normalize', ...
    'ColumnName', eventTableColumnName, ...
    'ColumnEditable',[false false false false], ...
    'CellSelectionCallback', {@event_table_selection_callback, GHandle, vIdx},...
    'ColumnResizePolicy', 'all', ...
    'ColumnFormat', eventTableColumnFormat, ...
    'Sortable', true,...
    'Position',  [0 0 1 1],...
    'LabelVisible','off');










end
function channel_table_selection_callback(a,b)
end
function event_table_selection_callback(a,b)
end

function onDemoHelp(a,b,c)
disp('ciao')
end
