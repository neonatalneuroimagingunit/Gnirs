function viewer2(GHandle)

viewerC.defaultHSplit = -[70; 30];
viewerC.defaultVTopSplit = -[80; 20];
viewerC.defaultVBotSplit = -[25; 25; 25; 25];

%% create the viewer idx
if (isempty(GHandle.Viewer))
    vIdx = 1;
    GHandle.Temp.vIdxList = 1;
else
    vIdx = max(GHandle.Temp.vIdxList) + 1;
    GHandle.Temp.vIdxList = [GHandle.Temp.vIdxList ; vIdx];
end

%% prepare aux variable
GHandle.Viewer(vIdx).WatchList = ViewerWatchList; % Create the watchlist
GHandle.Viewer(vIdx).Undocked = struct;

%% Load and prepare data for viever
viewerC.Data.Time = GHandle.CurrentDataSet.Data;       % Load Data in Time
viewerC.Measure = GHandle.CurrentDataSet.Measure;      % Load Measure
viewerC.Analysis = GHandle.CurrentDataSet.Analysis;    % Load Measure
viewerC.Event = GHandle.CurrentDataSet.Measure.Event;  % Load Event

if isempty(GHandle.DataBase.findid(GHandle.CurrentDataSet.Measure.id).probeId)
    viewerC.Probe = [];
else
    viewerC.Probe = GHandle.CurrentDataSet.Probe; % Load Probe
end

viewerC.dataType = GHandle.CurrentDataSet.Measure.InstrumentType.datatype;      %Load Data type
viewerC.updateRate = GHandle.CurrentDataSet.Measure.InstrumentType.UpdateRate;  %Load update rate

[power, freq] = pspectrum(viewerC.Data.Time{:,2:end}, viewerC.updateRate);      % Calculate The spectrum
freqTable = array2table([freq, power], ...
    'VariableNames', [{'Frequency'}, viewerC.Data.Time.Properties.VariableNames(2:end)]);
viewerC.Data.Frequency = freqTable;

viewerC.sortingMethod = {'sortnomo', 'wavelength', 'channel'};
GHandle.Viewer(vIdx).WatchList.colorLine = sortingcolors(width(viewerC.Data.Time)-1, viewerC.sortingMethod{1});

% Set color theme
viewerC.figurePosition = GHandle.Preference.Figure.sizeLarge;
viewerC.backgroundColor = GHandle.Preference.Theme.backgroundColor;
viewerC.foregroundColor = GHandle.Preference.Theme.foregroundColor;
viewerC.highlightColor = GHandle.Preference.Theme.highlightColor;
viewerC.textForegroundColor = [1 1 1];
viewerC.sourceColor = 'r';
viewerC.detectorColor = 'b';
viewerC.channelColor = 'k';

% Set font
viewerC.defaultFontName = GHandle.Preference.Font.name;
viewerC.defaultFontSize = GHandle.Preference.Font.sizeM;

%% Main figure
GHandle.Viewer(vIdx).mainFigure = figure('Position', viewerC.figurePosition, ...
    'Units','normalized',...
    'Visible', 'on', ...
    'Resize', 'on',...
    'Name', 'Viewer', ...
    'Numbertitle', 'off', ...
    'Color', viewerC.backgroundColor, ...
    'Toolbar', 'none', ...
    'Menubar', 'none', ...
    'CloseRequestFcn', @(handle, evnt)close_request(handle, evnt, GHandle, vIdx),...
    'DoubleBuffer', 'on', ...
    'DockControls', 'off', ...
    'Renderer', 'OpenGL');

%% Create features
viewerpanel(viewerC,GHandle, vIdx);
viewermenu(viewerC,GHandle, vIdx);
vewertoolbar(viewerC,GHandle, vIdx);
viewerpopulatepreferences(viewerC, GHandle, vIdx);
viewertime(viewerC, GHandle, vIdx);
viewerfrequency(viewerC, GHandle, vIdx);
viewertimefrequency(viewerC, GHandle, vIdx);

%% Populate figure
if ~isempty(viewerC.Probe)
    viewerpopulateprobe(viewerC, GHandle, vIdx);
end
viewerpopulateinfo(viewerC, GHandle, vIdx);

%% Activate Listener
GHandle.Viewer(vIdx).Listener.TimePlot = addlistener(GHandle.Viewer(vIdx).WatchList, 'time2Plot', ...
    'PostSet', @(src,evnt)viewerpopulatetime(src, evnt, GHandle, vIdx, viewerC));
GHandle.Viewer(vIdx).Listener.SpectrumPlot = addlistener(GHandle.Viewer(vIdx).WatchList, 'spectrum2Plot', ...
    'PostSet', @(src,evnt)viewerpopulatefrequency(src, evnt,GHandle, vIdx, viewerC));
GHandle.Viewer(vIdx).Listener.TimeFreqPlot = addlistener(GHandle.Viewer(vIdx).WatchList, 'timefreq2Plot', ...
    'PostSet', @(src,evnt)viewerpopulatetimefrequency(src, evnt, GHandle, vIdx, viewerC));
GHandle.Viewer(vIdx).Listener.TimeWindow = addlistener(GHandle.Viewer(vIdx).WatchList, 'timeLim', ...
    'PostSet', @(src,evnt)viewertimesetlim(src,evnt,GHandle, vIdx, viewerC));
GHandle.Viewer(vIdx).Listener.FreqWindow = addlistener(GHandle.Viewer(vIdx).WatchList, 'freqLim', ...
    'PostSet', @(src,evnt)viewerfrequencysetlim(src, evnt, GHandle, vIdx, viewerC));

%% Assign the data to plot and activate the listener
dataIdx = contains(viewerC.Data.Time.Properties.VariableNames ,[viewerC.dataType(1) 'Time']);
GHandle.Viewer(vIdx).WatchList.time2Plot = viewerC.Data.Time(:,dataIdx);
GHandle.Viewer(vIdx).WatchList.spectrum2Plot = viewerC.Data.Frequency(:,dataIdx);

GHandle.Viewer(vIdx).Listener.SelectedLine = addlistener(GHandle.Viewer(vIdx).WatchList, 'edvLine', ...
    'PostSet', @(src,evnt)viewerselectedtrack(src, evnt, GHandle, vIdx, viewerC));

%% Set default splits
GHandle.Viewer(vIdx).mainLayout.Heights = viewerC.defaultHSplit;
GHandle.Viewer(vIdx).PlotInfoLayout.Widths = viewerC.defaultVTopSplit;
GHandle.Viewer(vIdx).ViewLayout.Widths = viewerC.defaultVBotSplit;
movegui(GHandle.Viewer(vIdx).mainFigure, 'center')

%% Turn figure on
GHandle.Viewer(vIdx).mainFigure.Visible  = 'on';

end

function close_request(Handle, ~, GHandle, vIdx)
figToBeClosed = fieldnames(GHandle.Viewer(vIdx).Undocked);
for iClose = 1:1:length(figToBeClosed)
    delete(GHandle.Viewer(vIdx).Undocked.(figToBeClosed{iClose})); % delete all open undocked figures of viewer
end
delete(Handle);
GHandle.Temp.vIdxList(GHandle.Temp.vIdxList == vIdx) = [];
if isempty (GHandle.Temp.vIdxList)
    GHandle.Viewer = [];
end
end



