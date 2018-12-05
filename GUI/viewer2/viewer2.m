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
viewertrackpref(viewerC, GHandle, vIdx)

end

    

