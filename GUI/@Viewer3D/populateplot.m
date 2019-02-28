function populateplot(obj)

obj.MainPlot.Axes = axes('Parent', obj.MainPlot.Panel, ...
    'Units', 'normalized', ...
    'NextPlot', 'add', ...
    'Position', [0.1 0.1 0.8 0.8], ...
    'Visible', 'off');

set(obj.MainPlot.Axes,'CameraViewAngle',get(obj.MainPlot.Axes,'CameraViewAngle'));
set(obj.MainPlot.Axes,'PlotBoxAspectRatio',get(obj.MainPlot.Axes,'PlotBoxAspectRatio'));
set(obj.MainPlot.Axes,'DataAspectRatio',get(obj.MainPlot.Axes,'DataAspectRatio'));
rotate3d(obj.MainPlot.Axes, 'on');

lighting(obj.MainPlot.Axes,'gouraud');
obj.MainPlot.Light(1) = light('Position', [+100 0 50]);
obj.MainPlot.Light(2) = light('Position', [-100 0 50]);

if ~isempty(obj.Atlas) 
    obj.populateatlasplot;
end

if ~isempty(obj.Probe) 
    obj.populateprobeplot;
end

if ~isempty(obj.Forward)  
    obj.populateforwardplot;
end

if ~isempty(obj.Track) 
    obj.populatetrackplot;
end

end
