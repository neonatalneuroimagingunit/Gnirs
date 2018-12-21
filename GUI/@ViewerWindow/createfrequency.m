function  createfrequency(obj)

obj.Panel.Plot.Frequency.MainAxes = axes('parent', obj.Panel.Plot.Frequency.Tab,...
    'Position', [0.07 0.22 0.88 0.66], ...
    'Units', 'normalized', ...
    'Color', obj.Preference.backgroundColor, ...
    'XColor', obj.Preference.foregroundColor, ...
    'YColor', obj.Preference.foregroundColor, ...
    'Xgrid', 'on', ...
    'Ygrid', 'on', ...
    'GridColor', obj.Preference.foregroundColor, ...
    'NextPlot', 'add',...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', obj.Preference.defaultFontName, ...
    'Visible', 'on', ...
    'Title', 'Main plots');

obj.Panel.Plot.Frequency.SupportAxes = axes('parent', obj.Panel.Plot.Frequency.Tab,...
    'Position', [0.07 0.22 0.88 0.66], ...
    'Units', 'normalized', ...
    'HitTest', 'off',...
    'Color', 'none', ...
    'XColor', obj.Preference.foregroundColor, ...
    'YColor', obj.Preference.foregroundColor, ...
    'Xgrid', 'off', ...
    'Ygrid', 'off', ...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'NextPlot', 'add',...
    'GridColor', obj.Preference.foregroundColor, ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', obj.Preference.defaultFontName, ...
    'Visible', 'on', ...
    'Title', 'Main plots');

obj.Panel.Plot.Frequency.SmallAxes = axes('parent', obj.Panel.Plot.Frequency.Tab,...
    'Units', 'normalized', ...
    'Position', [0.1 0.04 0.8 0.07], ...
    'Color', obj.Preference.backgroundColor, ...
    'Color', obj.Preference.backgroundColor, ...
    'XColor', obj.Preference.foregroundColor, ...
    'YColor', obj.Preference.foregroundColor, ...
    'NextPlot', 'add',...
    'GridColor', obj.Preference.foregroundColor, ...
    'ButtonDownFcn', {@move_time_window, obj},...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'FontName', obj.Preference.defaultFontName, ...
    'Visible', 'on', ...
    'Box', 'on', ...
    'XLimMode', 'auto', ...
    'YLimMode', 'auto', ...
    'XGrid', 'off', ...
    'YGrid', 'off');
obj.Panel.Plot.Frequency.SmallAxes.XAxis.Visible = 'off';
obj.Panel.Plot.Frequency.SmallAxes.YAxis.Visible = 'off';

obj.Panel.Plot.Frequency.XEditMin = uicontrol('Parent', obj.Panel.Plot.Frequency.Tab, ...
    'Style', 'edit', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.06 0.04 0.05], ...
    'FontSize',obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Tag','min',...
    'Callback', {@move_frequency_window, obj}, ...
    'String', 'min');

obj.Panel.Plot.Frequency.XEditMax = uicontrol('Parent', obj.Panel.Plot.Frequency.Tab, ...
    'Style', 'edit', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.91 0.06 0.04 0.05], ...
    'FontSize', obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Tag','max',...
    'Callback', {@move_frequency_window, obj}, ...
    'String', 'max');

obj.Panel.Plot.Frequency.YEditMin = uicontrol('Parent', obj.Panel.Plot.Frequency.Tab, ...
    'Style', 'edit', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.01 0.20 0.04 0.05], ...
    'FontSize', obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Visible','off',...
    'String', 'min',...
    'Tag','min',...plot
    'Callback', {@editY_callback, obj});

obj.Panel.Plot.Frequency.YEditMax = uicontrol('Parent', obj.Panel.Plot.Frequency.Tab, ...
    'Style', 'edit', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.01 0.85 0.04 0.05], ...
    'FontSize', obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Visible','off',...
    'String', 'max',...
    'Tag','max',...
    'Callback', {@editY_callback, obj});

obj.Panel.Plot.Frequency.ButtonFirst = uicontrol('Parent', obj.Panel.Plot.Frequency.Tab, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.03 0.03 0.02 0.08], ...
    'FontSize', obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_frequency_window, obj}, ...
    'Tag','F',...
    'String', 'F');
obj.Panel.Plot.Frequency.ButtonBackwardS = uicontrol('Parent', obj.Panel.Plot.Frequency.Tab, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.03 0.02 0.03], ...
    'FontSize', obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_frequency_window, obj}, ...
    'Tag','<<',...
    'String', '<<');
obj.Panel.Plot.Frequency.ButtonBackwardL = uicontrol('Parent', obj.Panel.Plot.Frequency.Tab, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.07 0.03 0.02 0.03], ...
    'FontSize', obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_frequency_window, obj}, ...
    'Tag','<',...
    'String', '<');
obj.Panel.Plot.Frequency.ButtonLast = uicontrol('Parent', obj.Panel.Plot.Frequency.Tab, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.95 0.03 0.02 0.08], ...
    'FontSize', obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_frequency_window, obj}, ...
    'Tag','L',...
    'String', 'L');
obj.Panel.Plot.Frequency.ButtonForwardL = uicontrol('Parent', obj.Panel.Plot.Frequency.Tab, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.93 0.03 0.02 0.03], ...
    'FontSize', obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_frequency_window, obj}, ...
    'Tag','>>',...
    'String', '>>');
obj.Panel.Plot.Frequency.ButtonForwardS = uicontrol('Parent', obj.Panel.Plot.Frequency.Tab, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.91 0.03 0.02 0.03], ...
    'FontSize', obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_frequency_window, obj}, ...
    'Tag','>',...
    'String', '>');

end

function editY_callback(handle, ~, obj)
mask = contains({'min', 'max'}, handle.Tag);
obj.Panel.Plot.Frequency.MainAxes.YLim(mask) = str2double(handle.String);
obj.WatchList.edvLine = obj.WatchList.edvLine;
end

function move_frequency_window(~, eventData, obj)
small_step = 1;
big_step = 10;

switch eventData.EventName
    case 'Action'
        switch eventData.Source.Tag
            case '<'
                xmin = obj.WatchList.freqLim(1) - small_step;
                xmax = obj.WatchList.freqLim(2) - small_step;
                
            case '>'
                xmin = obj.WatchList.freqLim(1) + small_step;
                xmax = obj.WatchList.freqLim(2) + small_step;
                
            case '<<'
                xmin = obj.WatchList.freqLim(1) - big_step;
                xmax = obj.WatchList.freqLim(2) - big_step;
                
            case '>>'
                xmin = obj.WatchList.freqLim(1) + big_step;
                xmax = obj.WatchList.freqLim(2) + big_step;
                
            case 'F'
                xmin = 0;
                xmax = obj.WatchList.freqLim(2);
                
            case 'L'
                xmin = obj.WatchList.freqLim(1);
                xmax = obj.Preference.updateRate/2;
                
            case 'max'
                xmin = obj.WatchList.freqLim(1);
                xmax = str2double(eventData.Source.String);
                if xmax < xmin
                    xmax = obj.WatchList.freqLim(2);
                    msgbox('Invalid value - max must be larger than min')
                end
                
            case 'min'
                xmax = obj.WatchList.freqLim(2);
                xmin = str2double(eventData.Source.String);
                if xmin > xmax
                    xmin = obj.WatchList.freqLim(1);
                    msgbox('Invalid value - min must be smaller than max')
                end
        end
    case 'Hit'
        xmin = eventData.IntersectionPoint(1);
        xmax = obj.WatchList.freqLim(2) - obj.WatchList.freqLim(1) + xmin;
end

if strcmp(obj.Toolbar.LockMultipleWiewer.State,'on')
    for VieverList = obj.GHandle.Viewer
        VieverList.WatchList.freqLim = [xmin , xmax];
    end
else
    obj.WatchList.freqLim = [xmin , xmax];
end

end




