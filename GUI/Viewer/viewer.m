function viewer(GHandle)
GHandle.CurrentDataSet.Measure.updateRate = 1000;

%feature('DefaultCharacterSet', 'UTF8');



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

backgroundColor = GHandle.Preference.Figure.backgroundColor;
foregroundColor = GHandle.Preference.Figure.foregroundColor;
highlightColor = GHandle.Preference.Figure.highlightColor;


% Set font
defaultFontName = GHandle.Preference.Font.name;

%initialize plot settings
GHandle.Viewer.WatchList = ViewerWatchList;



%% Main figure
GHandle.Viewer.mainFigure = figure('Position', figurePosition, ...
    'Visible', 'on', ...
    'Resize', 'on',...
    'Name', 'Viewer', ...
    'Numbertitle', 'off', ...
    'Tag', 'sensors_viewer', ...
    'Color', backgroundColor, ...
    'Toolbar', 'none', ...
    'Menubar', 'none', ...
    'DoubleBuffer', 'on', ...
    'DockControls', 'off', ...
    'Renderer', 'OpenGL');


%% Menu
GHandle.Viewer.menu.menuFile = uimenu('Parent', GHandle.Viewer.mainFigure, 'Label', 'File');
GHandle.Viewer.menu.menuFile_loadData = uimenu('Parent', GHandle.Viewer.menu.menuFile, ...
    'Label', 'Load Data...', ...
    'Callback', @load_data);
GHandle.Viewer.menu.menuFile_export = uimenu('Parent', GHandle.Viewer.menu.menuFile, ...
    'Label', 'Export');
GHandle.Viewer.menu.menuFile_export_export2png = uimenu('Parent', GHandle.Viewer.menu.menuFile, ...
    'Label', 'Export to png', ...
    'Callback', @export2png);
GHandle.Viewer.menu.menuFile_quit = uimenu('Parent', GHandle.Viewer.menu.menuFile, ...
    'Label', 'Quit', ...
    'Callback', {@closewindow, GHandle.Viewer.mainFigure});

GHandle.Viewer.menu.menuEdit = uimenu('Parent', GHandle.Viewer.mainFigure, 'Label', 'Edit');

GHandle.Viewer.menu.menuView = uimenu('Parent', GHandle.Viewer.mainFigure, 'Label', 'View');
GHandle.Viewer.menu.menuView_openTable = uimenu('Parent', GHandle.Viewer.menu.menuView, ...
    'Label', 'Open Table...');


%% Toolbar
GHandle.Viewer.mainToolbar = uitoolbar('Parent', GHandle.Viewer.mainFigure);

img1 = rand(16,16,3);
pth = uipushtool(GHandle.Viewer.mainToolbar,...
    'CData', img1, 'Separator', 'on', ...
    'TooltipString', 'Your toggle tool', ...
    'HandleVisibility', 'off');

img2 = rand(16,16,3);
tth1 = uitoggletool(GHandle.Viewer.mainToolbar,...
    'CData', img2, 'Separator', 'on', ...
    'TooltipString', 'Your toggle tool', ...
    'HandleVisibility', 'off');
img3 = rand(16,16,3);
tth2 = uitoggletool(GHandle.Viewer.mainToolbar,...
    'CData', img3, 'Separator', 'off', ...
    'TooltipString', 'Your toggle tool', ...
    'HandleVisibility', 'off');
img4 = rand(16,16,3);
tt3 = uitoggletool(GHandle.Viewer.mainToolbar,...
    'CData', img4, 'Separator', 'off', ...
    'TooltipString', 'Your toggle tool', ...
    'HandleVisibility', 'off');

%% Panels
panellabels = {'Measure', 'Subject', 'Probe', 'Selected Channel'};

labels = {...
          {'Measure ID', 'Duration', 'Samples', 'Sampling Rate', 'Type of Data'}, ...
          {'pippo', 'pluto'}, ...
          {'topolino', 'paperino', 'qui', 'quo', 'qua'}, ...
          {'archimede', 'Average', 'Average window'}, ...
         };

 
	 
values = {...
          {GHandle.CurrentDataSet.Measure.id, [num2str(GHandle.CurrentDataSet.Measure.timeLength) ' s'], num2str(height(GHandle.CurrentDataSet.Data)), [num2str(GHandle.CurrentDataSet.Measure.updateRate) ' Hz'], 'DC'}, ...
          {'pippo', 'pluto'}, ...
          {'topolino', 'paperino', 'qui', 'quo', 'qua'}, ...
          {'archimede', '-', '-'}, ...
         }; 
	 
	 
npanels = length(panellabels);
panelwidth = (1-(npanels+1)*stepW)/npanels;

for jj = 1:1:npanels
    
    panel_position = [jj*stepW+(jj-1)*panelwidth stepH panelwidth panelH];
    GHandle.Viewer.metadata(jj).panel = uipanel('parent', GHandle.Viewer.mainFigure,...
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
    
    currentlabels = fliplr(labels{1,jj});
	currentvalues = fliplr(values{1,jj});
	
    nlines = length(currentlabels);
    boxheight = 1/(nlines+2);
    for ii = 1:1:nlines
        GHandle.Viewer.metadata(jj).label(ii) = uicontrol('Parent', GHandle.Viewer.metadata(jj).panel, ...
            'Style', 'text', ...
            'BackgroundColor', backgroundColor, ...
            'ForegroundColor', foregroundColor, ...
            'Units', 'normalized', ...
            'Position', [0.1 ii*boxheight 0.3 0.1], ...
            'FontWeight', 'bold', ...
            'FontSize', 8, ...
            'FontAngle', 'italic', ...
            'HorizontalAlignment', 'left', ...
            'String', currentlabels{ii});
        GHandle.Viewer.metadata(jj).value(ii) = uicontrol('Parent', GHandle.Viewer.metadata(jj).panel, ...
            'Style', 'text', ...
            'BackgroundColor', backgroundColor, ...
            'ForegroundColor', foregroundColor, ...
            'Units', 'normalized', ...
            'Position', [0.4 ii*boxheight 0.6 0.1], ...
            'FontWeight', 'bold', ...
            'FontAngle', 'italic', ...
            'FontSize', 8, ...
            'String', currentvalues{ii});
    end
end


%% Tabs
GHandle.Viewer.tabs.group = uitabgroup(GHandle.Viewer.mainFigure, 'Position',[stepW panelH+2*stepH panelaxesW panelaxesH]);
GHandle.Viewer.tabs.time = uitab('Parent', GHandle.Viewer.tabs.group, ...
    'Title', 'Time', ...
    'BackgroundColor', [1 0 0], ...
    'ForegroundColor', foregroundColor);
GHandle.Viewer.tabs.frequency = uitab(GHandle.Viewer.tabs.group, ...
    'Title', 'Spectrum', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor);
GHandle.Viewer.tabs.timefrequency = uitab(GHandle.Viewer.tabs.group, ...
    'Title', 'Time-Frequency', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor);

%% Time tab
%panelaxes_position = [stepW panelH+2*stepH panelaxesW panelaxesH];
panelaxes_position = [0 0 1 1];
GHandle.Viewer.timeplot.panel = uipanel('parent', GHandle.Viewer.tabs.time,...
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
 %   'Title', 'Time series');

GHandle.Viewer.timeplot.bigaxes1 = axes('parent', GHandle.Viewer.timeplot.panel,...
    'Position', [0.07 0.22 0.88 0.66], ...
    'Units', 'normalized', ...
    'Color', backgroundColor, ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'Xgrid', 'on', ...
    'Ygrid', 'on', ...
    'GridColor', foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Visible', 'on', ...
    'Title', 'Main plots');

GHandle.Viewer.timeplot.bigaxes2 = axes('parent', GHandle.Viewer.timeplot.panel,...
    'Position', [0.07 0.22 0.88 0.66], ...
    'Units', 'normalized', ...
    'Color', backgroundColor, ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'Xgrid', 'off', ...
    'Ygrid', 'off', ...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'GridColor', foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Visible', 'on', ...
    'Title', 'Main plots');

GHandle.Viewer.timeplot.smallaxes = axes('parent', GHandle.Viewer.timeplot.panel,...
    'Units', 'normalized', ...
    'Position', [0.1 0.04 0.8 0.07], ...
    'Color', backgroundColor, ...
    'Color', backgroundColor, ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
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

GHandle.Viewer.timeplot.spectrumaxes = axes('parent', GHandle.Viewer.timeplot.panel,...
    'Position', [0.8 0.7 0.15 0.15], ...
    'Units', 'normalized', ...
    'Color', [backgroundColor 0], ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'Xgrid', 'off', ...
    'Ygrid', 'off', ...
    'GridColor', foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Box', 'off', ...
    'Visible', 'off', ...
    'Title', 'Spectrum');


GHandle.Viewer.timeplot.editmin = uicontrol('Parent', GHandle.Viewer.timeplot.panel, ...
    'Style', 'edit', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.06 0.04 0.05], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@set_time_window_min, GHandle}, ...
    'String', 'min');

GHandle.Viewer.timeplot.editmax = uicontrol('Parent', GHandle.Viewer.timeplot.panel, ...
    'Style', 'edit', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.91 0.06 0.04 0.05], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@set_time_window_max, GHandle}, ...
    'String', 'max');

GHandle.Viewer.timeplot.buttonBwall = uicontrol('Parent', GHandle.Viewer.timeplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.03 0.03 0.02 0.08], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, GHandle}, ...
    'String', 'F');
GHandle.Viewer.timeplot.buttonBw10 = uicontrol('Parent', GHandle.Viewer.timeplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.03 0.02 0.03], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, GHandle}, ...
    'String', '<<');
GHandle.Viewer.timeplot.buttonBw1 = uicontrol('Parent', GHandle.Viewer.timeplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.07 0.03 0.02 0.03], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, GHandle}, ...
    'String', '<');
GHandle.Viewer.timeplot.buttonFwall = uicontrol('Parent', GHandle.Viewer.timeplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.95 0.03 0.02 0.08], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, GHandle}, ...
    'String', 'L');
GHandle.Viewer.timeplot.buttonFw10 = uicontrol('Parent', GHandle.Viewer.timeplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.93 0.03 0.02 0.03], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, GHandle}, ...
    'String', '>>');
GHandle.Viewer.timeplot.buttonFw1 = uicontrol('Parent', GHandle.Viewer.timeplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.91 0.03 0.02 0.03], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, GHandle}, ...
    'String', '>');




%% Spectrum tab
%panelaxes_position = [stepW panelH+2*stepH panelaxesW panelaxesH];
panelaxes_position = [0 0 1 1];
GHandle.Viewer.spectrumplot.panel = uipanel('parent', GHandle.Viewer.tabs.frequency,...
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
 %   'Title', 'Time series');

GHandle.Viewer.spectrumplot.bigaxes1 = axes('parent', GHandle.Viewer.spectrumplot.panel,...
    'Position', [0.07 0.22 0.88 0.66], ...
    'Units', 'normalized', ...
    'Color', backgroundColor, ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'Xgrid', 'on', ...
    'Ygrid', 'on', ...
    'GridColor', foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Visible', 'on', ...
    'Title', 'Main plots');

GHandle.Viewer.spectrumplot.bigaxes2 = axes('parent', GHandle.Viewer.spectrumplot.panel,...
    'Position', [0.07 0.22 0.88 0.66], ...
    'Units', 'normalized', ...
    'Color', backgroundColor, ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'Xgrid', 'off', ...
    'Ygrid', 'off', ...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'GridColor', foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Visible', 'off', ...
    'Title', 'Main plots');

GHandle.Viewer.spectrumplot.smallaxes = axes('parent', GHandle.Viewer.spectrumplot.panel,...
    'Units', 'normalized', ...
    'Position', [0.1 0.04 0.8 0.07], ...
    'Color', backgroundColor, ...
    'Color', backgroundColor, ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
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

GHandle.Viewer.spectrumplot.spectrumaxes = axes('parent', GHandle.Viewer.spectrumplot.panel,...
    'Position', [0.8 0.7 0.15 0.15], ...
    'Units', 'normalized', ...
    'Color', [backgroundColor 0], ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'Xgrid', 'off', ...
    'Ygrid', 'off', ...
    'GridColor', foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Box', 'off', ...
    'Visible', 'off', ...
    'Title', 'Spectrum');


GHandle.Viewer.spectrumplot.editmin = uicontrol('Parent', GHandle.Viewer.spectrumplot.panel, ...
    'Style', 'edit', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.06 0.04 0.05], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@set_spectrum_window_min, GHandle}, ...
    'String', 'min');

GHandle.Viewer.spectrumplot.editmax = uicontrol('Parent', GHandle.Viewer.spectrumplot.panel, ...
    'Style', 'edit', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.91 0.06 0.04 0.05], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@set_spectrum_window_max, GHandle}, ...
    'String', 'max');

GHandle.Viewer.spectrumplot.buttonBwall = uicontrol('Parent', GHandle.Viewer.spectrumplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.03 0.03 0.02 0.08], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_spectrum_window, GHandle}, ...
    'String', 'F');
GHandle.Viewer.spectrumplot.buttonBw10 = uicontrol('Parent', GHandle.Viewer.spectrumplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.03 0.02 0.03], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_spectrum_window, GHandle}, ...
    'String', '<<');
GHandle.Viewer.spectrumplot.buttonBw1 = uicontrol('Parent', GHandle.Viewer.spectrumplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.07 0.03 0.02 0.03], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_spectrum_window, GHandle}, ...
    'String', '<');
GHandle.Viewer.spectrumplot.buttonFwall = uicontrol('Parent', GHandle.Viewer.spectrumplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.95 0.03 0.02 0.08], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_spectrum_window, GHandle}, ...
    'String', 'L');
GHandle.Viewer.spectrumplot.buttonFw10 = uicontrol('Parent', GHandle.Viewer.spectrumplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.93 0.03 0.02 0.03], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_spectrum_window, GHandle}, ...
    'String', '>>');
GHandle.Viewer.spectrumplot.buttonFw1 = uicontrol('Parent', GHandle.Viewer.spectrumplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.91 0.03 0.02 0.03], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_spectrum_window, GHandle}, ...
    'String', '>');

%% Time-frequency tab
%panelaxes_position = [stepW panelH+2*stepH panelaxesW panelaxesH];
panelaxes_position = [0 0 1 1];
GHandle.Viewer.timefrequencyplot.panel = uipanel('parent', GHandle.Viewer.tabs.timefrequency,...
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
 %   'Title', 'Time series');

GHandle.Viewer.timefrequencyplot.bigaxes1 = axes('parent', GHandle.Viewer.timefrequencyplot.panel,...
    'Position', [0.07 0.22 0.88 0.66], ...
    'Units', 'normalized', ...
    'Color', backgroundColor, ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'Xgrid', 'on', ...
    'Ygrid', 'on', ...
    'GridColor', foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Visible', 'on', ...
    'Title', 'Main plots');

GHandle.Viewer.timefrequencyplot.bigaxes2 = axes('parent', GHandle.Viewer.timefrequencyplot.panel,...
    'Position', [0.07 0.22 0.88 0.66], ...
    'Units', 'normalized', ...
    'Color', backgroundColor, ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'Xgrid', 'off', ...
    'Ygrid', 'off', ...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'GridColor', foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Visible', 'off', ...
    'Title', 'Main plots');

GHandle.Viewer.timefrequencyplot.smallaxes = axes('parent', GHandle.Viewer.timefrequencyplot.panel,...
    'Units', 'normalized', ...
    'Position', [0.1 0.04 0.8 0.07], ...
    'Color', backgroundColor, ...
    'Color', backgroundColor, ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
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

GHandle.Viewer.timefrequencyplot.spectrumaxes = axes('parent', GHandle.Viewer.timefrequencyplot.panel,...
    'Position', [0.8 0.7 0.15 0.15], ...
    'Units', 'normalized', ...
    'Color', [backgroundColor 0], ...
    'XColor', foregroundColor, ...
    'YColor', foregroundColor, ...
    'Xgrid', 'off', ...
    'Ygrid', 'off', ...
    'GridColor', foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', defaultFontName, ...
    'Box', 'off', ...
    'Visible', 'off', ...
    'Title', 'Spectrum');


GHandle.Viewer.timefrequencyplot.editmin = uicontrol('Parent', GHandle.Viewer.timefrequencyplot.panel, ...
    'Style', 'edit', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.06 0.04 0.05], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@set_time_window_min, GHandle}, ...
    'String', 'min');

GHandle.Viewer.timefrequencyplot.editmax = uicontrol('Parent', GHandle.Viewer.timefrequencyplot.panel, ...
    'Style', 'edit', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.91 0.06 0.04 0.05], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@set_time_window_max, GHandle}, ...
    'String', 'max');

GHandle.Viewer.timefrequencyplot.buttonBwall = uicontrol('Parent', GHandle.Viewer.timefrequencyplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.03 0.03 0.02 0.08], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_window, GHandle}, ...
    'String', 'F');
GHandle.Viewer.timefrequencyplot.buttonBw10 = uicontrol('Parent', GHandle.Viewer.timefrequencyplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.03 0.02 0.03], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_window, GHandle}, ...
    'String', '<<');
GHandle.Viewer.timefrequencyplot.buttonBw1 = uicontrol('Parent', GHandle.Viewer.timefrequencyplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.07 0.03 0.02 0.03], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_window, GHandle}, ...
    'String', '<');
GHandle.Viewer.timefrequencyplot.buttonFwall = uicontrol('Parent', GHandle.Viewer.timefrequencyplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.95 0.03 0.02 0.08], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_window, GHandle}, ...
    'String', 'L');
GHandle.Viewer.timefrequencyplot.buttonFw10 = uicontrol('Parent', GHandle.Viewer.timefrequencyplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.93 0.03 0.02 0.03], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_window, GHandle}, ...
    'String', '>>');
GHandle.Viewer.timefrequencyplot.buttonFw1 = uicontrol('Parent', GHandle.Viewer.timefrequencyplot.panel, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.91 0.03 0.02 0.03], ...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_window, GHandle}, ...
    'String', '>');

%% Plot parameters

channelNames = GHandle.CurrentDataSet.Data.Properties.VariableNames;
columns_AC = contains(channelNames,'AC');
columns_DC = contains(channelNames,'DC');
columns_Ph = contains(channelNames,'Ph');

columns = logical(ones([length(channelNames) 1]));
columns(end) = 0;

nirsdata = table2array(GHandle.CurrentDataSet.Data(:,columns_DC));  % channel selection from table must be smarter
GHandle.CurrentDataSet.nirsdata = nirsdata;% remove this asap

nsamples = height(GHandle.CurrentDataSet.Data);
timeline_milliseconds = GHandle.CurrentDataSet.Data.reltime;
timeline_samples = linspace(1, nsamples, nsamples);

nchannels = size(nirsdata, 2);
channelLabels = channelNames(columns_DC);

sortingmethod = 'sortnomo';
channelColors = sorting_colors(nchannels, sortingmethod);

%% Time plot
% Main plot
axes(GHandle.Viewer.timeplot.bigaxes1)
axis tight
cla;
hold on
aa = 1;
for ii = 1:1:nchannels
    GHandle.Viewer.timeplot.lines1(ii) = plot(GHandle.CurrentDataSet.Data.reltime, nirsdata(:,ii), 'LineWidth', 1, 'LineStyle', '-');
    GHandle.Viewer.timeplot.lines1(ii).Color = channelColors(ii,:);
    GHandle.Viewer.timeplot.lines1(ii).DisplayName = channelLabels{ii};
    aa = aa+1;
end
GHandle.Viewer.timeplot.bigaxes1.YAxis.Exponent = 0;
GHandle.Viewer.timeplot.lines1_selection = findall(GHandle.Viewer.timeplot.lines1, 'Type', 'Line');
set(GHandle.Viewer.timeplot.lines1_selection, 'buttonDownFcn', {@change_line_width, GHandle})
GHandle.Viewer.timeplot.bigaxes1.XLabel.String = 'Time (s)';
GHandle.Viewer.timeplot.bigaxes1.YLabel.String = 'Intensity (a.u.)';
x2 = 1:1:size(nirsdata,1);
%y2 = 1:1:size(nirsdata,1);
y2 = GHandle.CurrentDataSet.Data.reltime/GHandle.CurrentDataSet.Measure.updateRate;
line(x2, y2, 'Parent', GHandle.Viewer.timeplot.bigaxes2, 'Color', 'none')
GHandle.Viewer.timeplot.bigaxes2.XLabel.String = 'Time (samples)';
GHandle.Viewer.timeplot.bigaxes2.YTickLabel = [];
GHandle.Viewer.timeplot.bigaxes2.XLim = [timeline_samples(1) timeline_samples(end)];
uistack(GHandle.Viewer.timeplot.spectrumaxes,'top');
% Overall plot
axes(GHandle.Viewer.timeplot.smallaxes)
axis tight
cla;
hold on
for ii = 1:1:size(nirsdata,2)
    GHandle.Viewer.timeplot.lines2(ii) = plot(GHandle.CurrentDataSet.Data.reltime, nirsdata(:,ii), 'LineWidth', 1, 'LineStyle', '-');
    set(GHandle.Viewer.timeplot.lines2(ii), 'Color', channelColors(ii,:));
    aa = aa+1;
end


								
GHandle.Viewer.listener = addlistener(GHandle.Viewer.WatchList,'timeLim','PostSet',@(src,evnt)set_time_lim(src,evnt,GHandle));

GHandle.Viewer.timeplot.rectangle = rectangle('Curvature', [0 0], 'EdgeColor', foregroundColor);
GHandle.Viewer.timeplot.txt_seconds = text(0, 0, '', 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 8);
GHandle.Viewer.timeplot.txt_samples = text(0, 0, '', 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 8);

GHandle.Viewer.WatchList.timeLim = [GHandle.CurrentDataSet.Data.reltime(1),...
									GHandle.CurrentDataSet.Data.reltime(end)];

GHandle.Viewer.timeplot.lines2_selection = findall(GHandle.Viewer.timeplot.lines2, 'Type', 'Line');
set(GHandle.Viewer.timeplot.lines2_selection, 'buttonDownFcn', {@move_time_window, GHandle});

%% Spectrum plot
% Main plot
axes(GHandle.Viewer.spectrumplot.bigaxes1)
axis tight
cla;
hold on
aa = 1;

xdata = GHandle.CurrentDataSet.Data.reltime;
ydata = nirsdata;

% spectrum = fft(ydata);
% n = length(xdata);          % number of samples
% f = (0:n-1)*(DataNIRS.MeasureInfo.AqInfo.UpdateRate/n);         % frequency range
% power = abs(spectrum).^2/n;    % power of the DFT
% maxpower = max(power);

[power, f] = pspectrum(ydata, GHandle.CurrentDataSet.Measure.updateRate);
GHandle.CurrentDataSet.power = power;
GHandle.CurrentDataSet.freq = f;

for ii = 1:1:nchannels
    %temp = smooth(power(:,ii), 5);
    temp = power(:,ii);
    %temp = power(:,ii)/maxpower(ii);
    GHandle.Viewer.spectrumplot.lines1(ii) = plot(f, temp, 'LineWidth', 1, 'LineStyle', '-');
    GHandle.Viewer.spectrumplot.lines1(ii).Color = channelColors(ii,:);
    GHandle.Viewer.spectrumplot.lines1(ii).DisplayName = channelLabels{ii};
    aa = aa+1;
end
%GHandle.Viewer.spectrumplot.bigaxes1.YAxis.Exponent = 0;
GHandle.Viewer.spectrumplot.lines1_selection = findall(GHandle.Viewer.spectrumplot.lines1, 'Type', 'Line');
set(GHandle.Viewer.spectrumplot.lines1_selection, 'buttonDownFcn', {@change_line_width, channelColors, get(GHandle.Viewer.spectrumplot.lines1_selection(1), 'LineWidth'), 2, GHandle.Viewer.spectrumplot, GHandle.Viewer.metadata, GHandle.CurrentDataSet.Measure.updateRate})
GHandle.Viewer.spectrumplot.bigaxes1.XLabel.String = 'Frequency (Hz)';
GHandle.Viewer.spectrumplot.bigaxes1.YLabel.String = 'Power (%)';
%GHandle.Viewer.spectrumplot.bigaxes1.YLim = [0 0.1];
% x2 = 1:1:size(nirsdata,1);
% %y2 = 1:1:size(nirsdata,1);
% y2 = DataNIRS.Data.reltime/GHandle.CurrentDataSet.Measure.updateRate;
% line(x2, y2, 'Parent', GHandle.Viewer.spectrumplot.bigaxes2, 'Color', 'none')
% GHandle.Viewer.spectrumplot.bigaxes2.XLabel.String = 'Time (samples)';
% GHandle.Viewer.spectrumplot.bigaxes2.YTickLabel = [];
% GHandle.Viewer.spectrumplot.bigaxes2.XLim = [timeline_samples(1) timeline_samples(end)];
uistack(GHandle.Viewer.spectrumplot.spectrumaxes,'top');
% Overall plot
axes(GHandle.Viewer.spectrumplot.smallaxes)
axis tight
cla;
hold on
for ii = 1:1:size(nirsdata,2)
    %temp = smooth(power(:,ii), 5);
    temp = power(:,ii);
    %temp = power(:,ii)/maxpower(ii);
    GHandle.Viewer.spectrumplot.lines2(ii) = plot(f, temp, 'LineWidth', 1, 'LineStyle', '-');
    set(GHandle.Viewer.spectrumplot.lines2(ii), 'Color', channelColors(ii,:));
    aa = aa+1;
end

GHandle.Viewer.listener = addlistener(GHandle.Viewer.WatchList,'freqLim','PostSet',@(src,evnt)set_freq_lim(src,evnt,GHandle));

GHandle.Viewer.spectrumplot.rectangle = rectangle('Curvature', [0 0], 'EdgeColor', foregroundColor);

GHandle.Viewer.WatchList.freqLim = [f(1),...
									f(end)];

GHandle.Viewer.spectrumplot.lines2_selection = findall(GHandle.Viewer.spectrumplot.lines2, 'Type', 'Line');
set(GHandle.Viewer.spectrumplot.lines2_selection, 'buttonDownFcn', {@move_spectrum_window, GHandle});

%% Time-Frequency plot
% Main plot
axes(GHandle.Viewer.timefrequencyplot.bigaxes1)
axis tight
cla;
%hold on
%aa = 1;

%xdata = DataNIRS.Data.reltime;
ydata = nirsdata(:,1);

% spectrum = fft(ydata);
% n = length(xdata);          % number of samples
% f = (0:n-1)*(GHandle.CurrentDataSet.Measure.updateRate/n);         % frequency range
% power = abs(spectrum).^2/n;    % power of the DFT
% maxpower = max(power);
[sp,fp,tp] = pspectrum(ydata, GHandle.CurrentDataSet.Measure.updateRate, 'spectrogram');

surf(tp,fp,sp,sp)
view(107,30)
xlabel('Time (s)')
ylabel('Frequency (Hz)')
%rotate3d on

% for ii = 1:1:nchannels
%     %temp = smooth(power(:,ii), 5);
%     temp = power(:,ii);
%     %temp = power(:,ii)/maxpower(ii);
%     GHandle.Viewer.timefrequencyplot.lines1(ii) = plot(f, temp, 'LineWidth', 1, 'LineStyle', '-');
%     GHandle.Viewer.timefrequencyplot.lines1(ii).Color = channelColors(ii,:);
%     GHandle.Viewer.timefrequencyplot.lines1(ii).DisplayName = channelLabels{ii};
%     aa = aa+1;
% end
%GHandle.Viewer.spectrumplot.bigaxes1.YAxis.Exponent = 0;
% GHandle.Viewer.timefrequencyplot.lines1_selection = findall(GHandle.Viewer.timefrequencyplot.lines1, 'Type', 'Line');
% set(GHandle.Viewer.timefrequencyplot.lines1_selection, 'buttonDownFcn', {@change_line_width, channelColors, get(GHandle.Viewer.timefrequencyplot.lines1_selection(1), 'LineWidth'), 2, GHandle.Viewer.timefrequencyplot, GHandle.Viewer.metadata, GHandle.CurrentDataSet.Measure.updateRate})
% GHandle.Viewer.timefrequencyplot.bigaxes1.XLabel.String = 'Frequency (Hz)';
% GHandle.Viewer.timefrequencyplot.bigaxes1.YLabel.String = 'Power (%)';
%GHandle.Viewer.timefrequencyplot.bigaxes1.YLim = [0 0.1];
% x2 = 1:1:size(nirsdata,1);
% %y2 = 1:1:size(nirsdata,1);
% y2 = DataNIRS.Data.reltime/GHandle.CurrentDataSet.Measure.updateRate;
% line(x2, y2, 'Parent', GHandle.Viewer.spectrumplot.bigaxes2, 'Color', 'none')
% GHandle.Viewer.timefrequencyplot.bigaxes2.XLabel.String = 'Time (samples)';
% GHandle.Viewer.timefrequencyplot.bigaxes2.YTickLabel = [];
% GHandle.Viewer.timefrequencyplot.bigaxes2.XLim = [timeline_samples(1) timeline_samples(end)];
% uistack(GHandle.Viewer.timefrequencyplot.spectrumaxes,'top');
% % Overall plot
% axes(GHandle.Viewer.timefrequencyplot.smallaxes)
% axis tight
% cla;
% hold on
% for ii = 1:1:size(nirsdata,2)
%     %temp = smooth(power(:,ii), 5);
%     temp = power(:,ii);
%     %temp = power(:,ii)/maxpower(ii);
%     GHandle.Viewer.timefrequencyplot.lines2(ii) = plot(f, temp, 'LineWidth', 1, 'LineStyle', '-');
%     set(GHandle.Viewer.timefrequencyplot.lines2(ii), 'Color', channelColors(ii,:));
%     aa = aa+1;
% end
% %GHandle.Viewer.timefrequencyplot.bigaxes2.YLim = [0 0.1];
% GHandle.Viewer.timefrequencyplot.editmin.String = num2str(f(1));
% GHandle.Viewer.timefrequencyplot.editmax.String = num2str(f(end));
% GHandle.Viewer.timefrequencyplot.rectangle = rectangle('Position', [str2double(GHandle.Viewer.timefrequencyplot.editmin.String) min(nirsdata(:)) str2double(GHandle.Viewer.timefrequencyplot.editmax.String)-str2double(GHandle.Viewer.timefrequencyplot.editmin.String) max(nirsdata(:))-min(nirsdata(:))], 'Curvature', [0 0], 'EdgeColor', foregroundColor);
% GHandle.Viewer.timefrequencyplot.lines2_selection = findall(GHandle.Viewer.timefrequencyplot.lines2, 'Type', 'Line');
% set(GHandle.Viewer.timefrequencyplot.lines2_selection, 'buttonDownFcn', {@move_rectangle, GHandle.Viewer.timefrequencyplot, GHandle.CurrentDataSet.Measure.updateRate});


%% Populate metadata

%% Turn figure on
GHandle.Viewer.mainFigure.Visible = 'on';
