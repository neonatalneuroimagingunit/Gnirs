function viewerfrequencysetlim(~,evnt,GHandle, vIdx, viewerC)

freqLim = evnt.AffectedObject.freqLim;

%% Set main axes limits
GHandle.Viewer(vIdx).PlotPanel.Frequency.MainAxes.XLim = freqLim;

%% Set editmin and editmax string
GHandle.Viewer(vIdx).PlotPanel.Frequency.XEditMin.String = freqLim(1);
GHandle.Viewer(vIdx).PlotPanel.Frequency.XEditMax.String = freqLim(2);

%% Set rectangle position
rectangle_x = GHandle.Viewer(vIdx).PlotPanel.Frequency.MainAxes.XLim(1);
rectangle_y = GHandle.Viewer(vIdx).PlotPanel.Frequency.MainAxes.YLim(1);
rectangle_w = GHandle.Viewer(vIdx).PlotPanel.Frequency.MainAxes.XLim(2) - rectangle_x;
rectangle_h = GHandle.Viewer(vIdx).PlotPanel.Frequency.MainAxes.YLim(2) - rectangle_y;

GHandle.Viewer(vIdx).PlotPanel.Frequency.Rectangle.Position = [rectangle_x rectangle_y rectangle_w rectangle_h];

%% Set rectangle labels

%% Set timefrequency frequency axis limit
GHandle.Viewer(vIdx).PlotPanel.TimeFrequency.MainAxes.YLim = freqLim;
end

