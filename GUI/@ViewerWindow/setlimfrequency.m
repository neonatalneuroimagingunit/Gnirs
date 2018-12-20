function setlimfrequency(obj, ~,evnt)

freqLim = evnt.AffectedObject.freqLim;

%% Set main axes limits
obj.Panel.Plot.Frequency.MainAxes.XLim = freqLim;

%% Set editmin and editmax string
obj.Panel.Plot.Frequency.XEditMin.String = freqLim(1);
obj.Panel.Plot.Frequency.XEditMax.String = freqLim(2);

%% Set rectangle position
rectangle_x = obj.Panel.Plot.Frequency.MainAxes.XLim(1);
rectangle_y = obj.Panel.Plot.Frequency.MainAxes.YLim(1);
rectangle_w = obj.Panel.Plot.Frequency.MainAxes.XLim(2) - rectangle_x;
rectangle_h = obj.Panel.Plot.Frequency.MainAxes.YLim(2) - rectangle_y;

obj.Panel.Plot.Frequency.Rectangle.Position = [rectangle_x rectangle_y rectangle_w rectangle_h];

%% Set rectangle labels

%% Set timefrequency frequency axis limit
obj.Panel.Plot.TimeFrequency.MainAxes.YLim = freqLim;
end

