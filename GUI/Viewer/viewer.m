function viewer(GHandle)

% create the viewer idx

if (isempty(GHandle.Viewer))
    vIdx = 1;
    GHandle.Temp.vIdxList = 1;
else
    vIdx = max(GHandle.Temp.vIdxList) + 1;
    GHandle.Temp.vIdxList = [GHandle.Temp.vIdxList ; vIdx];
end

sortingmethod = {'sortnomo','wavelength','channel'};
dataType = GHandle.CurrentDataSet.Measure.InstrumentType.datatype;

GHandle.Viewer(vIdx).Data = GHandle.CurrentDataSet.Data;
GHandle.Viewer(vIdx).Event = GHandle.CurrentDataSet.Measure.Event;
GHandle.Viewer(vIdx).Probe = GHandle.CurrentDataSet.Probe;
% Set UI objects size


%panelWidth = (1-mainAxesWidth) / 2;
stepW = 0.02;
stepH = 0.02;
panelaxesW = 1-2*stepW;
panelaxesH = 0.7;
%npanels = 4;
%panelW = (1-(npanels+1)*stepW)/npanels;
panelH = 1-panelaxesH-3*stepH;

figurePosition = GHandle.Preference.Figure.sizeLarge;

% Set color theme

backgroundColor = GHandle.Preference.Theme.backgroundColor;
foregroundColor = GHandle.Preference.Theme.foregroundColor;
highlightColor = GHandle.Preference.Theme.highlightColor;
textForegroundColor = [0 0 0];
sourceColor = 'r';
detectorColor = 'b';
channelColor = 'k';

% Set font
defaultFontName = GHandle.Preference.Font.name;

%initialize plot settings
GHandle.Viewer(vIdx).WatchList = ViewerWatchList;

updateRate = GHandle.CurrentDataSet.Measure.InstrumentType.UpdateRate;
GHandle.Viewer(vIdx).updateRate = updateRate;

%% Main figure
GHandle.Viewer(vIdx).mainFigure = figure('Position', figurePosition, ...
    'Visible', 'on', ...
    'Resize', 'on',...
    'Name', 'Viewer', ...
    'Numbertitle', 'off', ...
    'Tag', 'sensors_viewer', ...
    'Color', backgroundColor, ...
    'Toolbar', 'none', ...
    'Menubar', 'none', ...
    'CloseRequestFcn', @(handle, evnt)close_reqest(handle, evnt, GHandle, vIdx),...
    'DoubleBuffer', 'on', ...
    'DockControls', 'off', ...
    'Renderer', 'OpenGL');


%% Menu
GHandle.Viewer(vIdx).menu.menuFile = uimenu('Parent', GHandle.Viewer(vIdx).mainFigure, 'Label', 'File');
GHandle.Viewer(vIdx).menu.menuFile_loadData = uimenu('Parent', GHandle.Viewer(vIdx).menu.menuFile, ...
    'Label', 'Load Data...', ...
    'Callback', @load_data);
GHandle.Viewer(vIdx).menu.menuFile_export = uimenu('Parent', GHandle.Viewer(vIdx).menu.menuFile, ...
    'Label', 'Export');
GHandle.Viewer(vIdx).menu.menuFile_export_export2png = uimenu('Parent', GHandle.Viewer(vIdx).menu.menuFile, ...
    'Label', 'Export to png', ...
    'Callback', @export2png);
GHandle.Viewer(vIdx).menu.menuFile_quit = uimenu('Parent', GHandle.Viewer(vIdx).menu.menuFile, ...
    'Label', 'Quit', ...
    'Callback', {@closewindow, GHandle.Viewer(vIdx).mainFigure});

GHandle.Viewer(vIdx).menu.menuEdit = uimenu('Parent', GHandle.Viewer(vIdx).mainFigure, 'Label', 'Edit');

GHandle.Viewer(vIdx).menu.menuView = uimenu('Parent', GHandle.Viewer(vIdx).mainFigure, 'Label', 'View');
GHandle.Viewer(vIdx).menu.menuView_openTable = uimenu('Parent', GHandle.Viewer(vIdx).menu.menuView, ...
    'Label', 'Open Table...');


%% Toolbar
GHandle.Viewer(vIdx).mainToolbar = uitoolbar('Parent', GHandle.Viewer(vIdx).mainFigure);

img1 = rand(16,16,3);
GHandle.Viewer(vIdx).pushtool1 = uipushtool(GHandle.Viewer(vIdx).mainToolbar,...
    'CData', img1, 'Separator', 'on', ...
    'TooltipString', 'Your toggle tool', ...
    'HandleVisibility', 'off');

img2 = 0.5.*ones(16,16,3);
GHandle.Viewer(vIdx).LockMultipleWiewer  = uitoggletool(GHandle.Viewer(vIdx).mainToolbar,...
    'CData', img2, 'Separator', 'on', ...
    'TooltipString', 'Your toggle tool', ...
    'ClickedCallback',@(handle,evnt)lockmultiplewiewer_callback(handle, evnt, GHandle),...
    'HandleVisibility', 'off');
img3 = rand(16,16,3);
GHandle.Viewer(vIdx).toggletool2 = uitoggletool(GHandle.Viewer(vIdx).mainToolbar,...
    'CData', img3, 'Separator', 'off', ...
    'TooltipString', 'Your toggle tool', ...
    'HandleVisibility', 'off');
img4 = rand(16,16,3);
GHandle.Viewer(vIdx).toggletool3 = uitoggletool(GHandle.Viewer(vIdx).mainToolbar,...
    'CData', img4, 'Separator', 'off', ...
    'TooltipString', 'Your toggle tool', ...
    'HandleVisibility', 'off');

%% Panels
panellabels = {'Measure', 'Subject', 'Probe', 'Selected Channel'};

labels = {...
    {'Measure ID', 'Duration', 'Samples', 'Sampling Rate'}, ...
    {'pippo', 'pluto'}, ...
    {'topolino', 'paperino', 'qui', 'quo', 'qua'}, ...
    {'archimede', 'Average', 'Average window'}, ...
    };



values = {...
    {GHandle.CurrentDataSet.Measure.id, [num2str(GHandle.CurrentDataSet.Measure.timeLength) ' s'], num2str(height(GHandle.CurrentDataSet.Data)), [num2str(updateRate) ' Hz']}, ...
    {'pippo', 'pluto'}, ...
    {'topolino', 'paperino', 'qui', 'quo', 'qua'}, ...
    {'archimede', '-', '-'}, ...
    };


npanels = length(panellabels);
panelwidth = (1-(npanels+1)*stepW)/npanels;

for jj = 1:1:npanels
    
    panel_position = [jj*stepW+(jj-1)*panelwidth stepH panelwidth panelH];
    GHandle.Viewer(vIdx).metadata(jj).panel = uipanel('parent', GHandle.Viewer(vIdx).mainFigure,...
        'Position', panel_position, ...
        'Units', 'normalized', ...
        'BackgroundColor', backgroundColor, ...
        'ForegroundColor', foregroundColor, ...
        'HighlightColor', highlightColor, ...
        'ShadowColor', [211 211 211]/255, ...
        'BorderType', 'line', ...
        'FontWeight', 'bold', ...
        'FontSize', 8, ...
        'FontName', defaultFontName, ...
        'Visible', 'on', ...
        'Title', panellabels{jj});
    
    if jj~=3
        currentlabels = fliplr(labels{1,jj});
        currentvalues = fliplr(values{1,jj});
        
        nlines = length(currentlabels);
        boxheight = 1/(nlines+3);
        for ii = 1:1:nlines
            GHandle.Viewer(vIdx).metadata(jj).label(ii) = uicontrol('Parent', GHandle.Viewer(vIdx).metadata(jj).panel, ...
                'Style', 'text', ...
                'BackgroundColor', backgroundColor, ...
                'ForegroundColor', foregroundColor, ...
                'Units', 'normalized', ...
                'Position', [0.1 (ii+1)*boxheight 0.3 0.1], ...
                'FontWeight', 'bold', ...
                'FontSize', 8, ...
                'FontAngle', 'italic', ...
                'HorizontalAlignment', 'left', ...
                'String', currentlabels{ii});
            GHandle.Viewer(vIdx).metadata(jj).value(ii) = uicontrol('Parent', GHandle.Viewer(vIdx).metadata(jj).panel, ...
                'Style', 'text', ...
                'BackgroundColor', backgroundColor, ...
                'ForegroundColor', foregroundColor, ...
                'Units', 'normalized', ...
                'Position', [0.4 (ii+1)*boxheight 0.6 0.1], ...
                'FontWeight', 'bold', ...
                'FontAngle', 'italic', ...
                'FontSize', 8, ...
                'String', currentvalues{ii});
        end
    else
        GHandle.Viewer(vIdx).metadata(jj).probeAxes = axes('Parent', GHandle.Viewer(vIdx).metadata(jj).panel,...
            'Position', [0.1 0.1 0.8 0.8], ...
            'DataAspectRatio', [1 1 1], ...
            'Units', 'normalized', ...
            'Color', backgroundColor, ...
            'XColor', foregroundColor, ...
            'YColor', foregroundColor, ...
            'Xgrid', 'on', ...
            'Ygrid', 'on', ...
            'GridColor', foregroundColor, ...
            'NextPlot', 'add',...
            'FontWeight', 'bold', ...
            'FontSize', 8, ...
            'FontName', defaultFontName, ...
            'Visible', 'off', ...
            'Title', 'Probe plot');
    end
end



% Type selector
GHandle.Viewer(vIdx).DataTypeSelectorlabel = uicontrol('Parent', GHandle.Viewer(vIdx).metadata(1).panel, ...
    'Style', 'text', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.1 boxheight 0.3 0.1], ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontAngle', 'italic', ...
    'HorizontalAlignment', 'left', ...
    'String', 'Data Type');

GHandle.Viewer(vIdx).DataTypeSelector = uicontrol('Parent', GHandle.Viewer(vIdx).metadata(1).panel, ...
    'Style', 'popup',...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Callback', {@typeselector_callback, GHandle, vIdx},...
    'Units', 'normalized', ...
    'Position', [0.45 boxheight 0.5 0.1], ...
    'FontWeight', 'bold', ...
    'String',dataType);




%% Tabs
GHandle.Viewer(vIdx).tabs.group = uitabgroup(GHandle.Viewer(vIdx).mainFigure, 'Position',[stepW panelH+2*stepH panelaxesW panelaxesH]);
GHandle.Viewer(vIdx).tabs.time = uitab('Parent', GHandle.Viewer(vIdx).tabs.group, ...
    'Title', 'Time', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', textForegroundColor);
GHandle.Viewer(vIdx).tabs.frequency = uitab(GHandle.Viewer(vIdx).tabs.group, ...
    'Title', 'Spectrum', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', textForegroundColor);
GHandle.Viewer(vIdx).tabs.timefrequency = uitab(GHandle.Viewer(vIdx).tabs.group, ...
    'Title', 'Time-Frequency', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', textForegroundColor);
GHandle.Viewer(vIdx).Tabs.Video = uitab(GHandle.Viewer(vIdx).tabs.group, ...
    'Title', 'Videos', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', textForegroundColor);
GHandle.Viewer(vIdx).Tabs.Preference = uitab(GHandle.Viewer(vIdx).tabs.group, ...
    'Title', 'Preference', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', textForegroundColor);

%% Preference Tab
% Type selector
GHandle.Viewer(vIdx).Preference.SortingMethodsText = uicontrol('Parent', GHandle.Viewer(vIdx).Tabs.Preference, ...
    'Style', 'text', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.22 0.1 0.15], ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontAngle', 'italic', ...
    'HorizontalAlignment', 'left', ...
    'String', 'Sorting Method:');

GHandle.Viewer(vIdx).Preference.SortingMethods = uicontrol('Parent', GHandle.Viewer(vIdx).Tabs.Preference, ...
    'Style', 'popup',...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Callback', {@sortingmethod_callback, GHandle, vIdx},...
    'Units', 'normalized', ...
    'Position', [0.05 0.20 0.1 0.05], ...
    'FontWeight', 'bold', ...
    'String',sortingmethod);


GHandle.Viewer(vIdx).Preference.YAutoscale = uicontrol('Parent', GHandle.Viewer(vIdx).Tabs.Preference, ...
    'Style', 'checkbox', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.50 0.20 0.15], ...
    'FontWeight', 'bold', ...
    'Value',true,...
    'Callback', {@yautoscale_callback, GHandle, vIdx},...
    'FontSize', 8, ...
    'FontAngle', 'italic', ...
    'HorizontalAlignment', 'right', ...
    'String', 'Y axes Autoscale');


%% Time tab
%panelaxes_position = [stepW panelH+2*stepH panelaxesW panelaxesH];
panelaxes_position = [0 0 1 1];
GHandle.Viewer(vIdx).timeplot.panel = uipanel('parent', GHandle.Viewer(vIdx).tabs.time,...
    'Position', panelaxes_position, ...
    'Units', 'normalized', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'HighlightColor', highlightColor, ...
    'ShadowColor', [211 211 211]/255, ...
    'BorderType', 'none', ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Visible', 'on');


GHandle.Viewer(vIdx).timeplot.bigaxes1 = axes('parent', GHandle.Viewer(vIdx).timeplot.panel,...
    'Position', [0.07 0.22 0.88 0.66], ...
    'Units', 'normalized', ...
    'Color', backgroundColor, ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'Xgrid', 'on', ...
    'Ygrid', 'on', ...
    'GridColor', foregroundColor, ...
    'NextPlot', 'add',...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Visible', 'on', ...
    'Title', 'Main plots');

GHandle.Viewer(vIdx).timeplot.bigaxes2 = axes('parent', GHandle.Viewer(vIdx).timeplot.panel,...
    'Position', [0.07 0.22 0.88 0.66], ...
    'Units', 'normalized', ...
    'HitTest', 'off',...
    'Color', 'none', ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'Xgrid', 'off', ...
    'Ygrid', 'off', ...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'NextPlot', 'add',...
    'GridColor', foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Visible', 'on', ...
    'Title', 'Main plots');

GHandle.Viewer(vIdx).timeplot.smallaxes = axes('parent', GHandle.Viewer(vIdx).timeplot.panel,...
    'Units', 'normalized', ...
    'Position', [0.1 0.04 0.8 0.07], ...
    'Color', backgroundColor, ...
    'Color', backgroundColor, ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'NextPlot', 'add',...
    'GridColor', foregroundColor, ...
    'ButtonDownFcn', {@move_time_window, GHandle, vIdx},...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Visible', 'on', ...
    'Box', 'on', ...
    'XLimMode', 'auto', ...
    'YLimMode', 'auto', ...
    'XGrid', 'off', ...
    'YGrid', 'off');
GHandle.Viewer(vIdx).timeplot.smallaxes.XAxis.Visible = 'off';
GHandle.Viewer(vIdx).timeplot.smallaxes.YAxis.Visible = 'off';

GHandle.Viewer(vIdx).timeplot.spectrumaxes = axes('parent', GHandle.Viewer(vIdx).timeplot.panel,...
    'Position', [0.8 0.7 0.15 0.15], ...
    'Units', 'normalized', ...
    'Color', [backgroundColor 0], ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'Xgrid', 'off', ...
    'Ygrid', 'off', ...
    'NextPlot', 'add',...
    'GridColor', foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Box', 'off', ...
    'Visible', 'off', ...
    'Title', 'Spectrum');


GHandle.Viewer(vIdx).timeplot.editmin = uicontrol('Parent', GHandle.Viewer(vIdx).timeplot.panel, ...
    'Style', 'edit', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.06 0.04 0.05], ...
    'FontSize',GHandle.Preference.Font.sizeL,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Tag','min',...
    'Callback', {@move_time_window, GHandle, vIdx}, ...
    'String', 'min');

GHandle.Viewer(vIdx).timeplot.editmax = uicontrol('Parent', GHandle.Viewer(vIdx).timeplot.panel, ...
    'Style', 'edit', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.91 0.06 0.04 0.05], ...
    'FontSize',GHandle.Preference.Font.sizeL,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Tag','max',...
    'Callback', {@move_time_window, GHandle, vIdx}, ...
    'String', 'max');


GHandle.Viewer(vIdx).timeplot.editminY = uicontrol('Parent', GHandle.Viewer(vIdx).timeplot.panel, ...
    'Style', 'edit', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.01 0.20 0.04 0.05], ...
    'FontSize',GHandle.Preference.Font.sizeL,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Visible','off',...
    'String', 'min',...
    'Tag','min',...
    'Callback', {@editY_callback, GHandle, vIdx});

GHandle.Viewer(vIdx).timeplot.editmaxY = uicontrol('Parent', GHandle.Viewer(vIdx).timeplot.panel, ...
    'Style', 'edit', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.01 0.85 0.04 0.05], ...
    'FontSize',GHandle.Preference.Font.sizeL,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Visible','off',...
    'String', 'max',...
    'Tag','max',...
    'Callback', {@editY_callback, GHandle, vIdx});


GHandle.Viewer(vIdx).timeplot.buttonBwall = uicontrol('Parent', GHandle.Viewer(vIdx).timeplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.03 0.03 0.02 0.08], ...
    'FontSize',GHandle.Preference.Font.sizeL,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, GHandle, vIdx}, ...
    'Tag','F',...
    'String', 'F');
GHandle.Viewer(vIdx).timeplot.buttonBw10 = uicontrol('Parent', GHandle.Viewer(vIdx).timeplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.03 0.02 0.03], ...
    'FontSize',GHandle.Preference.Font.sizeS,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, GHandle, vIdx}, ...
    'Tag','<<',...
    'String', '<<');
GHandle.Viewer(vIdx).timeplot.buttonBw1 = uicontrol('Parent', GHandle.Viewer(vIdx).timeplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.07 0.03 0.02 0.03], ...
    'FontSize',GHandle.Preference.Font.sizeS,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, GHandle, vIdx}, ...
    'Tag','<',...
    'String', '<');
GHandle.Viewer(vIdx).timeplot.buttonFwall = uicontrol('Parent', GHandle.Viewer(vIdx).timeplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.95 0.03 0.02 0.08], ...
    'FontSize',GHandle.Preference.Font.sizeL,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, GHandle, vIdx}, ...
    'Tag','L',...
    'String', 'L');
GHandle.Viewer(vIdx).timeplot.buttonFw10 = uicontrol('Parent', GHandle.Viewer(vIdx).timeplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.93 0.03 0.02 0.03], ...
    'FontSize',GHandle.Preference.Font.sizeS,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, GHandle, vIdx}, ...
    'Tag','>>',...
    'String', '>>');
GHandle.Viewer(vIdx).timeplot.buttonFw1 = uicontrol('Parent', GHandle.Viewer(vIdx).timeplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.91 0.03 0.02 0.03], ...
    'FontSize',GHandle.Preference.Font.sizeS,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, GHandle, vIdx}, ...
    'Tag','>',...
    'String', '>');




%% Spectrum tab

panelaxes_position = [0 0 1 1];
GHandle.Viewer(vIdx).spectrumplot.panel = uipanel('parent', GHandle.Viewer(vIdx).tabs.frequency,...
    'Position', panelaxes_position, ...
    'Units', 'normalized', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'HighlightColor', highlightColor, ...
    'ShadowColor', [211 211 211]/255, ...
    'BorderType', 'none', ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Visible', 'on');


GHandle.Viewer(vIdx).spectrumplot.bigaxes1 = axes('parent', GHandle.Viewer(vIdx).spectrumplot.panel,...
    'Position', [0.07 0.22 0.88 0.66], ...
    'Units', 'normalized', ...
    'Color', backgroundColor, ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'Xgrid', 'on', ...
    'Ygrid', 'on', ...
    'NextPlot', 'add',...
    'GridColor', foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Visible', 'on', ...
    'Title', 'Main plots');

GHandle.Viewer(vIdx).spectrumplot.bigaxes2 = axes('parent', GHandle.Viewer(vIdx).spectrumplot.panel,...
    'Position', [0.07 0.22 0.88 0.66], ...
    'Units', 'normalized', ...
    'Color', backgroundColor, ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'Xgrid', 'off', ...
    'Ygrid', 'off', ...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'NextPlot', 'add',...
    'GridColor', foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Visible', 'off', ...
    'Title', 'Main plots');

GHandle.Viewer(vIdx).spectrumplot.smallaxes = axes('parent', GHandle.Viewer(vIdx).spectrumplot.panel,...
    'Units', 'normalized', ...
    'Position', [0.1 0.04 0.8 0.07], ...
    'Color', backgroundColor, ...
    'Color', backgroundColor, ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'NextPlot', 'add',...
    'GridColor', foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Visible', 'off', ...
    'Box', 'on', ...
    'XLimMode', 'auto', ...
    'YLimMode', 'auto', ...
    'XGrid', 'off', ...
    'YGrid', 'off');

GHandle.Viewer(vIdx).spectrumplot.spectrumaxes = axes('parent', GHandle.Viewer(vIdx).spectrumplot.panel,...
    'Position', [0.8 0.7 0.15 0.15], ...
    'Units', 'normalized', ...
    'Color', [backgroundColor 0], ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'Xgrid', 'off', ...
    'Ygrid', 'off', ...
    'NextPlot', 'add',...
    'GridColor', foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Box', 'off', ...
    'Visible', 'off', ...
    'Title', 'Spectrum');


GHandle.Viewer(vIdx).spectrumplot.editmin = uicontrol('Parent', GHandle.Viewer(vIdx).spectrumplot.panel, ...
    'Style', 'edit', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.06 0.04 0.05], ...
    'FontSize',GHandle.Preference.Font.sizeL,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Tag','min',...
    'Callback', {@move_spectrum_window, GHandle, vIdx}, ...
    'String', 'min');

GHandle.Viewer(vIdx).spectrumplot.editmax = uicontrol('Parent', GHandle.Viewer(vIdx).spectrumplot.panel, ...
    'Style', 'edit', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.91 0.06 0.04 0.05], ...
    'FontSize',GHandle.Preference.Font.sizeL,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Tag','max',...
    'Callback', {@move_spectrum_window, GHandle, vIdx}, ...
    'String', 'max');

GHandle.Viewer(vIdx).spectrumplot.buttonBwall = uicontrol('Parent', GHandle.Viewer(vIdx).spectrumplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.03 0.03 0.02 0.08], ...
    'FontSize',GHandle.Preference.Font.sizeL,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_spectrum_window, GHandle, vIdx}, ...
    'Tag','F',...
    'String', 'F');
GHandle.Viewer(vIdx).spectrumplot.buttonBw10 = uicontrol('Parent', GHandle.Viewer(vIdx).spectrumplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.03 0.02 0.03], ...
    'FontSize',GHandle.Preference.Font.sizeS,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_spectrum_window, GHandle, vIdx}, ...
    'Tag','<<',...
    'String', '<<');
GHandle.Viewer(vIdx).spectrumplot.buttonBw1 = uicontrol('Parent', GHandle.Viewer(vIdx).spectrumplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.07 0.03 0.02 0.03], ...
    'FontSize',GHandle.Preference.Font.sizeS,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_spectrum_window, GHandle, vIdx}, ...
    'Tag','<',...
    'String', '<');
GHandle.Viewer(vIdx).spectrumplot.buttonFwall = uicontrol('Parent', GHandle.Viewer(vIdx).spectrumplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.95 0.03 0.02 0.08], ...
    'FontSize',GHandle.Preference.Font.sizeL,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_spectrum_window, GHandle, vIdx}, ...
    'Tag','L',...
    'String', 'L');
GHandle.Viewer(vIdx).spectrumplot.buttonFw10 = uicontrol('Parent', GHandle.Viewer(vIdx).spectrumplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.93 0.03 0.02 0.03], ...
    'FontSize',GHandle.Preference.Font.sizeS,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_spectrum_window, GHandle, vIdx}, ...
    'Tag','>>',...
    'String', '>>');
GHandle.Viewer(vIdx).spectrumplot.buttonFw1 = uicontrol('Parent', GHandle.Viewer(vIdx).spectrumplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.91 0.03 0.02 0.03], ...
    'FontSize',GHandle.Preference.Font.sizeS,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_spectrum_window, GHandle, vIdx}, ...
    'Tag','>',...
    'String', '>');

%% Time-frequency tab

panelaxes_position = [0 0 1 1];
GHandle.Viewer(vIdx).timefrequencyplot.panel = uipanel('parent', GHandle.Viewer(vIdx).tabs.timefrequency,...
    'Position', panelaxes_position, ...
    'Units', 'normalized', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'HighlightColor', highlightColor, ...
    'ShadowColor', [211 211 211]/255, ...
    'BorderType', 'none', ...
    'FontWeight', 'bold', ...
    'FontSize',GHandle.Preference.Font.sizeL,...
    'FontName', defaultFontName, ...
    'Visible', 'on');

GHandle.Viewer(vIdx).timefrequencyplot.bigaxes = axes('parent', GHandle.Viewer(vIdx).timefrequencyplot.panel,...
    'Position', [0.07 0.22 0.88 0.66], ...
    'Units', 'normalized', ...
    'Color', backgroundColor, ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'XGrid', 'on', ...
    'XDir','reverse',...
    'YGrid', 'on', ...
    'View',[-240 ,  30],...
    'NextPlot', 'add',...
    'GridColor', foregroundColor, ...
    'FontSize',GHandle.Preference.Font.sizeL,...
    'FontWeight', 'bold', ...
    'FontName', defaultFontName, ...
    'Visible', 'off', ...
    'Title', 'Main plots');


GHandle.Viewer(vIdx).timefrequencyplot.text = uicontrol(...
    'Parent', GHandle.Viewer(vIdx).timefrequencyplot.panel, ...
    'Style', 'text', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.25 0.25 0.5 0.5], ...
    'FontWeight', 'bold', ...
    'FontSize', 40, ...
    'Visible', 'on',...
    'FontAngle', 'italic', ...
    'HorizontalAlignment', 'center', ...
    'String', 'Select one curve!!!');


%% Probe plot
%nCh = length(GHandle.Viewer(vIdx).Probe.channel.label);
% Remove empty spaces in optodes matrix layout
egg = 101;
spam = zeros(egg,egg);
bacon = sub2ind(size(spam),GHandle.Viewer(vIdx).Probe.source.position2D(:,1),GHandle.Viewer(vIdx).Probe.source.position2D(:,2));
spam(bacon) = 1;
bacon = sub2ind(size(spam),GHandle.Viewer(vIdx).Probe.detector.position2D(:,1),GHandle.Viewer(vIdx).Probe.detector.position2D(:,2));
spam(bacon) = 2;
spam(~any(spam,2),:) = [];
spam(:,~any(spam,1)) = [];
[posSrc(:,1), posSrc(:,2)] = find(spam==1);
[posDet(:,1), posDet(:,2)] = find(spam==2);

idxSrc = GHandle.Viewer(vIdx).Probe.channel.pairs(:,1);
idxDet = GHandle.Viewer(vIdx).Probe.channel.pairs(:,2);
if 1
    x = [posSrc(idxSrc,1)'; posDet(idxDet,1)'];
    y = [posSrc(idxSrc,2)'; posDet(idxDet,2)'];
    z = zeros(size(x));
else
    x = [GHandle.Viewer(vIdx).Probe.source.position(idxSrc,1)'; GHandle.Viewer(vIdx).Probe.detector.position(idxDet,1)'];
    y = [GHandle.Viewer(vIdx).Probe.source.position(idxSrc,2)'; GHandle.Viewer(vIdx).Probe.detector.position(idxDet,2)'];
    z = [GHandle.Viewer(vIdx).Probe.source.position(idxSrc,3)'; GHandle.Viewer(vIdx).Probe.detector.position(idxDet,3)'];
end
GHandle.Viewer(vIdx).probeplot.channel = plot3(y,-x,z,...
    'LineStyle', '-',...
    'LineWidth',1,...
    'buttonDownFcn', {@probe_callback , GHandle, vIdx},...
    'Color', channelColor,...
    'Parent', GHandle.Viewer(vIdx).metadata(3).probeAxes);
set(GHandle.Viewer(vIdx).probeplot.channel, {'Tag'}, GHandle.Viewer(vIdx).Probe.channel.label);

if 1
    x = repmat(posSrc(:,1)',[2,1]);
    y = repmat(posSrc(:,2)',[2,1]);
    z = zeros(size(x));
else
    x = repmat(GHandle.Viewer(vIdx).Probe.source.position(:,1)',[2,1]);
    y = repmat(GHandle.Viewer(vIdx).Probe.source.position(:,2)',[2,1]);
    z = repmat(GHandle.Viewer(vIdx).Probe.source.position(:,3)',[2,1]);
end
GHandle.Viewer(vIdx).probeplot.source = plot3(y,-x,z,...
    'LineStyle', 'none',...
    'Marker', '.',...
    'MarkerSize', 20, ...
    'buttonDownFcn', {@probe_callback , GHandle, vIdx},...
    'Color', sourceColor,...
    'Parent', GHandle.Viewer(vIdx).metadata(3).probeAxes);

if 1
    x = repmat(posDet(:,1)',[2,1]);
    y = repmat(posDet(:,2)',[2,1]);
    z = zeros(size(x));
else
    x = repmat(GHandle.Viewer(vIdx).Probe.detector.position(:,1)',[2,1]);
    y = repmat(GHandle.Viewer(vIdx).Probe.detector.position(:,2)',[2,1]);
    z = repmat(GHandle.Viewer(vIdx).Probe.detector.position(:,3)',[2,1]);
end
GHandle.Viewer(vIdx).probeplot.detector = plot3(y,-x,z,...
    'LineStyle', 'none',...
    'Marker', '.',...
    'MarkerSize', 20, ...
    'buttonDownFcn', {@probe_callback , GHandle, vIdx},...
    'Color', detectorColor,...
    'Parent', GHandle.Viewer(vIdx).metadata(3).probeAxes);

nSrc = length(GHandle.Viewer(vIdx).Probe.source.label);
nDet = length(GHandle.Viewer(vIdx).Probe.detector.label);
srcName = cellstr(num2str((1:nSrc)','s%.3d'));
detName = cellstr(num2str((1:nDet)','d%.3d'));
set(GHandle.Viewer(vIdx).probeplot.source, {'Tag'}, srcName);
set(GHandle.Viewer(vIdx).probeplot.detector, {'Tag'}, detName);

%% Time & Spectrum Plot

colors = sorting_colors((size(GHandle.Viewer(vIdx).Data,2)-1), sortingmethod{1});
GHandle.Viewer(vIdx).WatchList.colorLine = colors;

GHandle.Viewer(vIdx).listener = addlistener(GHandle.Viewer(vIdx).WatchList,'time2Plot','PostSet',@(src,evnt)timeplot(src,evnt,GHandle, vIdx));
GHandle.Viewer(vIdx).listener = addlistener(GHandle.Viewer(vIdx).WatchList,'spectrum2Plot','PostSet',@(src,evnt)spectrumplot(src,evnt,GHandle, vIdx));
GHandle.Viewer(vIdx).listener = addlistener(GHandle.Viewer(vIdx).WatchList,'timefreq2Plot','PostSet',@(src,evnt)timefreqplot(src,evnt,GHandle, vIdx));


dataIdx = contains(GHandle.Viewer(vIdx).Data.Properties.VariableNames , ['Time',dataType(1)]);
GHandle.Viewer(vIdx).listener = addlistener(GHandle.Viewer(vIdx).WatchList,'timeLim','PostSet',@(src,evnt)set_time_lim(src,evnt,GHandle, vIdx));
GHandle.Viewer(vIdx).WatchList.time2Plot = GHandle.Viewer(vIdx).Data(:,dataIdx);

dataIdx = contains(GHandle.Viewer(vIdx).Data.Properties.VariableNames ,dataType(1));
GHandle.Viewer(vIdx).listener = addlistener(GHandle.Viewer(vIdx).WatchList,'freqLim','PostSet',@(src,evnt)set_freq_lim(src, evnt, GHandle, vIdx));

[power, freq] = pspectrum(GHandle.Viewer(vIdx).Data{:,dataIdx}, updateRate);
spectrumTable = array2table([freq, power],'VariableNames',[{'Frequency'},GHandle.Viewer(vIdx).Data(:,dataIdx).Properties.VariableNames]);
GHandle.Viewer(vIdx).WatchList.spectrum2Plot = spectrumTable;

GHandle.Viewer(vIdx).listener = addlistener(GHandle.Viewer(vIdx).WatchList,'edvLine','PostSet',@(src,evnt)change_width(src,evnt,GHandle, vIdx));



%% Turn figure on
GHandle.Viewer(vIdx).mainFigure.Visible = 'on';
end

function close_reqest(Handle, ~, GHandle, vIdx)
delete(Handle);
GHandle.Temp.vIdxList(GHandle.Temp.vIdxList == vIdx) = [];
if isempty (GHandle.Temp.vIdxList)
    GHandle.Viewer = [];
end
end


function lockmultiplewiewer_callback(handle, ~, GHandle)
state = handle.State;
for idx = GHandle.Temp.vIdxList'
    GHandle.Viewer(idx).LockMultipleWiewer.State = state;
end
end


function typeselector_callback(~, Event, GHandle, vIdx)
updateRate = GHandle.Viewer(vIdx).updateRate;
dataIdx = contains(GHandle.Viewer(vIdx).Data.Properties.VariableNames , ['Time',Event.Source.String(Event.Source.Value)]);

GHandle.Viewer(vIdx).WatchList.time2Plot = GHandle.Viewer(vIdx).Data(:,dataIdx);

dataIdx = contains(GHandle.Viewer(vIdx).Data.Properties.VariableNames , Event.Source.String(Event.Source.Value));
[power, freq] = pspectrum(GHandle.Viewer(vIdx).Data{:,dataIdx}, updateRate);
spectrumTable = array2table([freq, power],'VariableNames',[{'Frequency'},GHandle.Viewer(vIdx).Data(:,dataIdx).Properties.VariableNames]);
GHandle.Viewer(vIdx).WatchList.spectrum2Plot = spectrumTable;

end


function sortingmethod_callback(~, Event, GHandle, vIdx)

sortingmethod = Event.Source.String{Event.Source.Value};
colors = sorting_colors((size(GHandle.Viewer(vIdx).Data,2)-1), sortingmethod);
GHandle.Viewer(vIdx).WatchList.colorLine = colors;
GHandle.Viewer(vIdx).WatchList.edvLine = ones(size(GHandle.Viewer(vIdx).WatchList.edvLine));
end

function probe_callback(hOptode, ~, GHandle, vIdx)
tobesearched = hOptode.Tag;
%hOptode.MarkerSize = hOptode.MarkerSize * 2;
if contains(tobesearched,'Ch')
    temp = GHandle.Viewer(vIdx).Probe.channel.pairs(contains(GHandle.Viewer.Probe.channel.label, tobesearched),:);
    tobesearched = num2str(temp,'s%.3d_d%.3d');
end
GHandle.Viewer(vIdx).WatchList.edvLine = contains({GHandle.Viewer(vIdx).timeplot.lines1.Tag}, tobesearched);
end

function editY_callback(handle, ~, GHandle, vIdx)
mask = contains({'min', 'max'}, handle.Tag);
GHandle.Viewer(vIdx).timeplot.bigaxes1.YLim(mask) = str2double(handle.String);
GHandle.Viewer(vIdx).WatchList.edvLine = GHandle.Viewer(vIdx).WatchList.edvLine;
end

function yautoscale_callback(handle, ~, GHandle, vIdx)

if handle.Value
    GHandle.Viewer(vIdx).timeplot.editmaxY.Visible = 'off';
    GHandle.Viewer(vIdx).timeplot.editminY.Visible = 'off';
    GHandle.Viewer(vIdx).WatchList.edvLine = GHandle.Viewer(vIdx).WatchList.edvLine;
else
    GHandle.Viewer(vIdx).timeplot.editmaxY.Visible = 'on';
    GHandle.Viewer(vIdx).timeplot.editminY.Visible = 'on';
    GHandle.Viewer(vIdx).timeplot.editmaxY.String = 'max';
    GHandle.Viewer(vIdx).timeplot.editminY.String = 'min';
end
end
