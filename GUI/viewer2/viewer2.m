function viewer2(GHandle)

% create the viewer idx

if (isempty(GHandle.Viewer))
    vIdx = 1;
    GHandle.Temp.vIdxList = 1;
else
    vIdx = max(GHandle.Temp.vIdxList) + 1;
    GHandle.Temp.vIdxList = [GHandle.Temp.vIdxList ; vIdx];
end

viewerC.sortingmethod = {'sortnomo','wavelength','channel'};
viewerC.dataType = GHandle.CurrentDataSet.Measure.InstrumentType.datatype;

viewerC.Data = GHandle.CurrentDataSet.Data;
viewerC.Event = GHandle.CurrentDataSet.Measure.Event;
viewerC.Probe = GHandle.CurrentDataSet.Probe;
viewerC.figurePosition = GHandle.Preference.Figure.sizeLarge;

% Set color theme

viewerC.backgroundColor = GHandle.Preference.Theme.backgroundColor;
viewerC.foregroundColor = GHandle.Preference.Theme.foregroundColor;
viewerC.highlightColor = GHandle.Preference.Theme.highlightColor;
viewerC.textForegroundColor = [0 0 0];
viewerC.sourceColor = 'r';
viewerC.detectorColor = 'b';
viewerC.channelColor = 'k';

% Set font
viewerC.defaultFontName = GHandle.Preference.Font.name;

%initialize plot settings
GHandle.Viewer(vIdx).WatchList = ViewerWatchList;

viewerC.updateRate = GHandle.CurrentDataSet.Measure.InstrumentType.UpdateRate;

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



viewerpanel(viewerC,GHandle, vIdx);
viewermenu(viewerC,GHandle, vIdx);
vewertoolbar(viewerC,GHandle, vIdx);
viewertrackpref(viewerC, GHandle, vIdx);
viewertime(viewerC, GHandle, vIdx);
viewerfrequency(viewerC, GHandle, vIdx);
viewertimefrequency(viewerC, GHandle, vIdx);
viewerprobe(viewerC, GHandle, vIdx)


%% trovare modo furbo di inscatolare sto schifo
% colors = sorting_colors((size(GHandle.Viewer(vIdx).Data,2)-1), sortingmethod{1});
% GHandle.Viewer(vIdx).WatchList.colorLine = colors;
% 
% GHandle.Viewer(vIdx).listener = addlistener(GHandle.Viewer(vIdx).WatchList,'time2Plot','PostSet',@(src,evnt)timeplot(src,evnt,GHandle, vIdx));
% GHandle.Viewer(vIdx).listener = addlistener(GHandle.Viewer(vIdx).WatchList,'spectrum2Plot','PostSet',@(src,evnt)spectrumplot(src,evnt,GHandle, vIdx));
% GHandle.Viewer(vIdx).listener = addlistener(GHandle.Viewer(vIdx).WatchList,'timefreq2Plot','PostSet',@(src,evnt)timefreqplot(src,evnt,GHandle, vIdx));
% 
% dataIdx = contains(GHandle.Viewer(vIdx).Data.Properties.VariableNames , ['Time',dataType(1)]);
% GHandle.Viewer(vIdx).listener = addlistener(GHandle.Viewer(vIdx).WatchList,'timeLim','PostSet',@(src,evnt)set_time_lim(src,evnt,GHandle, vIdx));
% GHandle.Viewer(vIdx).WatchList.time2Plot = GHandle.Viewer(vIdx).Data(:,dataIdx);
% 
% dataIdx = contains(GHandle.Viewer(vIdx).Data.Properties.VariableNames ,dataType(1));
% GHandle.Viewer(vIdx).listener = addlistener(GHandle.Viewer(vIdx).WatchList,'freqLim','PostSet',@(src,evnt)set_freq_lim(src, evnt, GHandle, vIdx));
% 
% [power, freq] = pspectrum(GHandle.Viewer(vIdx).Data{:,dataIdx}, updateRate);
% spectrumTable = array2table([freq, power],'VariableNames',[{'Frequency'},GHandle.Viewer(vIdx).Data(:,dataIdx).Properties.VariableNames]);
% GHandle.Viewer(vIdx).WatchList.spectrum2Plot = spectrumTable;
% 
% GHandle.Viewer(vIdx).listener = addlistener(GHandle.Viewer(vIdx).WatchList,'edvLine','PostSet',@(src,evnt)change_width(src,evnt,GHandle, vIdx));
% 
%% Turn figure on
GHandle.Viewer(vIdx).mainFigure  = 'on';
end

    

