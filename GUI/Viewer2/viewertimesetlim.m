function viewertimesetlim(~, evnt, GHandle, vIdx, viewerC)

fs = viewerC.updateRate;
timeLim = evnt.AffectedObject.timeLim;

%% Set main axes limits
GHandle.Viewer(vIdx).PlotPanel.Time.MainAxes.XLim = timeLim;
GHandle.Viewer(vIdx).PlotPanel.Time.SupportAxes.XLim = timeLim.*fs;

%% Set editmin and editmax string
GHandle.Viewer(vIdx).PlotPanel.Time.XEditMin.String = timeLim(1);
GHandle.Viewer(vIdx).PlotPanel.Time.XEditMax.String = timeLim(2);

%% Set rectangle position
rectangle_x = GHandle.Viewer(vIdx).PlotPanel.Time.MainAxes.XLim(1);
rectangle_y = GHandle.Viewer(vIdx).PlotPanel.Time.MainAxes.YLim(1);
rectangle_w = GHandle.Viewer(vIdx).PlotPanel.Time.MainAxes.XLim(2) - rectangle_x;
rectangle_h = GHandle.Viewer(vIdx).PlotPanel.Time.MainAxes.YLim(2) - rectangle_y;

GHandle.Viewer(vIdx).PlotPanel.Time.Rectangle.Position = [rectangle_x rectangle_y rectangle_w rectangle_h];

%% Set rectangle labels
txt_x = rectangle_w/2 + rectangle_x;
txt_y = [rectangle_y+rectangle_h+5 rectangle_y-5];
GHandle.Viewer(vIdx).PlotPanel.Time.TxtSeconds.Position = [txt_x, txt_y(1)];
GHandle.Viewer(vIdx).PlotPanel.Time.TxtSeconds.String = [num2str(timeLim(2)-timeLim(1)) ' s'];
GHandle.Viewer(vIdx).PlotPanel.Time.TxtSamples.Position = [txt_x, txt_y(2)];
GHandle.Viewer(vIdx).PlotPanel.Time.TxtSamples.String = [num2str(round((timeLim(2)-timeLim(1))*fs)) ' samples'];

%% Set timefrequency time axis limit
GHandle.Viewer(vIdx).PlotPanel.TimeFrequency.MainAxes.XLim = timeLim;
end

