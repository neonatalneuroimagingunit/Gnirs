function setlimtime(obj, ~, evnt)

fs = obj.Dataset.updateRate;
timeLim = evnt.AffectedObject.timeLim;

%% Set main axes limits
obj.Panel.Plot.Time.MainAxes.XLim = timeLim;
obj.Panel.Plot.Time.SupportAxes.XLim = timeLim.*fs;

%% Set editmin and editmax string
obj.Panel.Plot.Time.XEditMin.String = timeLim(1);
obj.Panel.Plot.Time.XEditMax.String = timeLim(2);

%% Set rectangle position
rectangle_x = obj.Panel.Plot.Time.MainAxes.XLim(1);
rectangle_y = obj.Panel.Plot.Time.MainAxes.YLim(1);
rectangle_w = obj.Panel.Plot.Time.MainAxes.XLim(2) - rectangle_x;
rectangle_h = obj.Panel.Plot.Time.MainAxes.YLim(2) - rectangle_y;

obj.Panel.Plot.Time.Rectangle.Position = [rectangle_x rectangle_y rectangle_w rectangle_h];

%% Set rectangle labels
txt_x = rectangle_w/2 + rectangle_x;
txt_y = [rectangle_y+rectangle_h+5 rectangle_y-5];
obj.Panel.Plot.Time.TxtSeconds.Position = [txt_x, txt_y(1)];
obj.Panel.Plot.Time.TxtSeconds.String = [num2str(timeLim(2)-timeLim(1)) ' s'];
obj.Panel.Plot.Time.TxtSamples.Position = [txt_x, txt_y(2)];
obj.Panel.Plot.Time.TxtSamples.String = [num2str(round((timeLim(2)-timeLim(1))*fs)) ' samples'];

%% Set timefrequency time axis limit
obj.Panel.Plot.TimeFrequency.MainAxes.XLim = timeLim;

%% Set Info
edvLine = obj.WatchList.edvLine;
if sum(edvLine) == 1
    xVal = obj.Panel.Plot.Time.Lines(edvLine).XData;
    yVal = obj.Panel.Plot.Time.Lines(edvLine).YData;
    mask = (xVal>=timeLim(1) & xVal<=timeLim(2));
    yLimit = [min(yVal(mask)), max(yVal(mask))];
    
    minValue = yLimit(1);
    maxValue = yLimit(2);
    avgValue = mean(yVal(mask));
    stdValue = std(yVal(mask));
  
    paramValue = {datestr(obj.Dataset.Analysis.date); ...
        obj.Dataset.Analysis.note; ...
        obj.Dataset.Analysis.id; ...
        {obj.Dataset.Analysis.MethodList.name}; ...
        [num2str(obj.Dataset.Measure.timeLength) ' s']; ...
        num2str(height(obj.Dataset.Data.Time));...
        [num2str(obj.Dataset.updateRate) ' Hz'];...
        [num2str(size(obj.Dataset.Event.type,1)) ' events (' num2str(size(obj.Dataset.Event.Dictionary,1)) ' unique)'];...
        obj.Panel.Plot.Time.Lines(edvLine).Tag;...
        num2str(minValue);...
        num2str(maxValue);...
        num2str(avgValue);...
        num2str(stdValue)};
    
    nParam = length(paramValue);
    for iParam = 1:1:nParam
        obj.Panel.Info.textValue(iParam).String = paramValue{iParam};
    end
else
    paramValue = {datestr(obj.Dataset.Analysis.date); ...
        obj.Dataset.Analysis.note; ...
        obj.Dataset.Analysis.id; ...
        {obj.Dataset.Analysis.MethodList.name}; ...
        [num2str(obj.Dataset.Measure.timeLength) ' s']; ...
        num2str(height(obj.Dataset.Data.Time));...
        [num2str(obj.Dataset.updateRate) ' Hz'];...
        [num2str(size(obj.Dataset.Event.type,1)) ' events (' num2str(size(obj.Dataset.Event.Dictionary,1)) ' unique)'];...
        '';...
        '';...
        '';...
        '';...
        ''};
    
    nParam = length(paramValue);
    for iParam = 1:1:nParam
        obj.Panel.Info.textValue(iParam).String = paramValue{iParam};
    end
end

