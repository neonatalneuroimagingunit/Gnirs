function probesimulationwindow(GHandle)
figureSize = GHandle.Preference.Figure.sizeLarge;

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

Probe = GHandle.CurrentDataSet.Probe;
DBProbe = GHandle.DataBase.findid(Probe.id);


GHandle.TempWindow.NewProbeFigure = figure(...
    'position', figureSize,...
    'Color',backgroundColor,...
    'Resize', 'on',...
    'Name', 'Probe Sensitivity Simulation', ...
    'Numbertitle', 'off', ...
    'Toolbar', 'none', ...
    'Menubar', 'none', ...
    'DoubleBuffer', 'on', ...
    'DockControls', 'off', ...
    'Visible', 'off', ...
    'DeleteFcn', {@close_figure, GHandle});

%% check of the sym algorithm

%% check of the Atlas feature




GHandle.TempWindow.NewProbeFigure.Visible = 'on';
end



function close_figure(Handle, ~, GHandle)
delete(Handle);
GHandle.TempWindow = [];
end
