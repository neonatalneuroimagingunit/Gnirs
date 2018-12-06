function viewer2(GHandle)

defaultHSplit = -[70; 30];
defaultVTopSplit = -[80; 20];
defaultVBotSplit = -[25; 25; 25; 25];

%% create the viewer idx
if (isempty(GHandle.Viewer))
    vIdx = 1;
    GHandle.Temp.vIdxList = 1;
else
    vIdx = max(GHandle.Temp.vIdxList) + 1;
    GHandle.Temp.vIdxList = [GHandle.Temp.vIdxList ; vIdx];
end

%% prepare aux variable
GHandle.Viewer(vIdx).WatchList = ViewerWatchList; % create the watchlist

%% Load and prepare data for viever
viewerC.Data.Time = GHandle.CurrentDataSet.Data; %Load Data in Time
viewerC.Event = GHandle.CurrentDataSet.Measure.Event; %Load Event
viewerC.Probe = GHandle.CurrentDataSet.Probe; %Load Probe
viewerC.Measure = GHandle.CurrentDataSet.Measure; %Load Measure
viewerC.Analysis = GHandle.CurrentDataSet.Analysis; %Load Measure

viewerC.dataType = GHandle.CurrentDataSet.Measure.InstrumentType.datatype; %Loada Data type
viewerC.updateRate = GHandle.CurrentDataSet.Measure.InstrumentType.UpdateRate; %Load update rate

[power, freq] = pspectrum(viewerC.Data.Time{:,2:end}, viewerC.updateRate); %% calculate The spectrum
freqTable = array2table([freq, power],'VariableNames',[{'Frequency'},viewerC.Data.Time.Properties.VariableNames(2:end)]);
viewerC.Data.Freq = freqTable;

viewerC.sortingMethod = {'sortnomo','wavelength','channel'};

% Set color theme
viewerC.figurePosition = GHandle.Preference.Figure.sizeLarge;
viewerC.backgroundColor = GHandle.Preference.Theme.backgroundColor;
viewerC.foregroundColor = GHandle.Preference.Theme.foregroundColor;
viewerC.highlightColor = GHandle.Preference.Theme.highlightColor;
viewerC.textForegroundColor = [0 0 0];
viewerC.sourceColor = 'r';
viewerC.detectorColor = 'b';
viewerC.channelColor = 'k';

% Set font
viewerC.defaultFontName = GHandle.Preference.Font.name;

%% Main figure
GHandle.Viewer(vIdx).mainFigure = figure('Position', viewerC.figurePosition, ...
    'Units','normalized',...
    'Visible', 'on', ...
    'Resize', 'on',...
    'Name', 'Viewer', ...
    'Numbertitle', 'off', ...
    'Tag', 'sensors_viewer', ...
    'Color', viewerC.backgroundColor, ...
    'Toolbar', 'none', ...
    'Menubar', 'none', ...
    ...'CloseRequestFcn', @(handle, evnt)close_request(handle, evnt, GHandle, vIdx),...
    'DoubleBuffer', 'on', ...
    'DockControls', 'off', ...
    'Renderer', 'OpenGL');
%% create all the figure feature
viewerpanel(viewerC,GHandle, vIdx);
viewermenu(viewerC,GHandle, vIdx);
vewertoolbar(viewerC,GHandle, vIdx);
viewertrackpref(viewerC, GHandle, vIdx);
viewertime(viewerC, GHandle, vIdx);
viewerfrequency(viewerC, GHandle, vIdx);
viewertimefrequency(viewerC, GHandle, vIdx);
%% popolate the figure
viewerpopulateprobe(viewerC, GHandle, vIdx);
viewerpopulateinfo(viewerC, GHandle, vIdx);

%% Activate Lissener
GHandle.Viewer(vIdx).Listener.TimePlot = addlistener(GHandle.Viewer(vIdx).WatchList,'time2Plot','PostSet',@(src,evnt)vewertime(src,evnt,GHandle, vIdx));
GHandle.Viewer(vIdx).Listener.SpectrumPlot = addlistener(GHandle.Viewer(vIdx).WatchList,'spectrum2Plot','PostSet',@(src,evnt)spectrumplot(src,evnt,GHandle, vIdx));
GHandle.Viewer(vIdx).Listener.TimeFreqPlot = addlistener(GHandle.Viewer(vIdx).WatchList,'timefreq2Plot','PostSet',@(src,evnt)timefreqplot(src,evnt,GHandle, vIdx));
GHandle.Viewer(vIdx).Listener.TimeWindow = addlistener(GHandle.Viewer(vIdx).WatchList,'timeLim','PostSet',@(src,evnt)set_time_lim(src,evnt,GHandle, vIdx));
GHandle.Viewer(vIdx).Listener.FreqWindow = addlistener(GHandle.Viewer(vIdx).WatchList,'freqLim','PostSet',@(src,evnt)set_freq_lim(src, evnt, GHandle, vIdx));
GHandle.Viewer(vIdx).Listener.SelectedLine = addlistener(GHandle.Viewer(vIdx).WatchList,'edvLine','PostSet',@(src,evnt)change_width(src,evnt,GHandle, vIdx));

%assign the data to plot and activate the lissener
dataIdx = contains(viewerC.Data.Properties.VariableNames ,viewerC.dataType(1));
GHandle.Viewer(vIdx).WatchList.time2Plot = viewerC.Data.Time(:,dataIdx);
GHandle.Viewer(vIdx).WatchList.spectrum2Plot = viewerC.Data.Freq(:,dataIdx);

%% Set default splits
GHandle.Viewer(vIdx).mainLayout.Heights = defaultHSplit;
GHandle.Viewer(vIdx).PlotInfoLayout.Widths = defaultVTopSplit;
GHandle.Viewer(vIdx).ViewLayout.Widths = defaultVBotSplit;

movegui(GHandle.Viewer(vIdx).mainFigure, 'center')
%% Turn figure on
GHandle.Viewer(vIdx).mainFigure.Visible  = 'on';
end

    

