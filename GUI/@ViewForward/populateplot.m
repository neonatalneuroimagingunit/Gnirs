function populateplot(obj)

obj.MainPlot.Axes = axes('Parent', obj.PlotPanel, ...
    'Units', 'normalized', ...
    'NextPlot', 'add', ...
    'Position', [0.1 0.1 0.8 0.8], ...
    'Visible', 'off');

axis equal
axis off
axis vis3d

obj.MainPlot.Light1 = light('Position',[100 0 100]);     % x is left->right, y is back->front
obj.MainPlot.Light2 = light('Position',[-100 0 100]);


if ~isempty(obj.Atlas) 
    obj.popatlasplot;
end

if ~isempty(obj.Probe) 
    obj.popprobeplot;
end

if ~isempty(obj.Forward)  
    obj.popforwardplot;
end

if ~isempty(obj.Track) 
    obj.poptrackplot;
end

end
