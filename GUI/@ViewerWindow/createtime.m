function createtime(obj)

obj.Panel.Plot.Time.MainAxes = axes('parent', obj.Panel.Plot.Time.Tab,...
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

obj.Panel.Plot.Time.SupportAxes = axes('parent', obj.Panel.Plot.Time.Tab,...
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

obj.Panel.Plot.Time.SmallAxes = axes('parent', obj.Panel.Plot.Time.Tab,...
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
obj.Panel.Plot.Time.SmallAxes.XAxis.Visible = 'off';
obj.Panel.Plot.Time.SmallAxes.YAxis.Visible = 'off';

obj.Panel.Plot.Time.XEditMin = uicontrol('Parent', obj.Panel.Plot.Time.Tab, ...
    'Style', 'edit', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.06 0.04 0.05], ...
    'FontSize',obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Tag','min',...
    'Callback', {@move_time_window, obj}, ...
    'String', 'min');

obj.Panel.Plot.Time.XEditMax = uicontrol('Parent', obj.Panel.Plot.Time.Tab, ...
    'Style', 'edit', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.91 0.06 0.04 0.05], ...
    'FontSize',obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Tag','max',...
    'Callback', {@move_time_window, obj}, ...
    'String', 'max');

obj.Panel.Plot.Time.YEditMin = uicontrol('Parent', obj.Panel.Plot.Time.Tab, ...
    'Style', 'edit', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.01 0.20 0.04 0.05], ...
    'FontSize',obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Visible','off',...
    'String', 'min',...
    'Tag','min',...
    'Callback', {@editY_callback, obj});

obj.Panel.Plot.Time.YEditMax = uicontrol('Parent', obj.Panel.Plot.Time.Tab, ...
    'Style', 'edit', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.01 0.85 0.04 0.05], ...
    'FontSize',obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Visible','off',...
    'String', 'max',...
    'Tag','max',...
    'Callback', {@editY_callback, obj});

obj.Panel.Plot.Time.ButtonFirst = uicontrol('Parent', obj.Panel.Plot.Time.Tab, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.03 0.03 0.02 0.08], ...
    'FontSize',obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, obj}, ...
    'Tag','F',...
    'String', 'F');
obj.Panel.Plot.Time.ButtonBackwardS = uicontrol('Parent', obj.Panel.Plot.Time.Tab, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.05 0.03 0.02 0.03], ...
    'FontSize',obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, obj}, ...
    'Tag','<<',...
    'String', '<<');
obj.Panel.Plot.Time.ButtonBackwardL = uicontrol('Parent', obj.Panel.Plot.Time.Tab, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.07 0.03 0.02 0.03], ...
    'FontSize',obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, obj}, ...
    'Tag','<',...
    'String', '<');
obj.Panel.Plot.Time.ButtonLast = uicontrol('Parent', obj.Panel.Plot.Time.Tab, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.95 0.03 0.02 0.08], ...
    'FontSize',obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, obj}, ...
    'Tag','L',...
    'String', 'L');
obj.Panel.Plot.Time.ButtonForwardL = uicontrol('Parent', obj.Panel.Plot.Time.Tab, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.93 0.03 0.02 0.03], ...
    'FontSize',obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, obj}, ...
    'Tag','>>',...
    'String', '>>');
obj.Panel.Plot.Time.ButtonForwardS = uicontrol('Parent', obj.Panel.Plot.Time.Tab, ...
    'Style', 'pushbutton', ...
    'BackgroundColor', obj.Preference.backgroundColor, ...
    'ForegroundColor', obj.Preference.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.91 0.03 0.02 0.03], ...
    'FontSize',obj.Preference.defaultFontSize,...
    'FontWeight', 'bold', ...
    'FontAngle', 'italic', ...
    'Callback', {@move_time_window, obj}, ...
    'Tag','>',...
    'String', '>');

end

function editY_callback(handle, ~, obj)
mask = contains({'min', 'max'}, handle.Tag);
obj.Panel.Plot.Time.MainAxes.YLim(mask) = str2double(handle.String);
obj.WatchList.edvLine = obj.WatchList.edvLine; % replace with reset/redraw
end

function move_time_window(~, eventData, obj)
small_step = 1;
big_step = 10;
switch eventData.EventName
    case 'Action'
        switch eventData.Source.Tag
            case '<'
                xmin = obj.WatchList.timeLim(1) - small_step;
                xmax = obj.WatchList.timeLim(2) - small_step;
                
            case '>'
                xmin = obj.WatchList.timeLim(1) + small_step;
                xmax = obj.WatchList.timeLim(2) + small_step;
                
            case '<<'
                xmin = obj.WatchList.timeLim(1) - big_step;
                xmax = obj.WatchList.timeLim(2) - big_step;
                
            case '>>'
                xmin = obj.WatchList.timeLim(1) + big_step;
                xmax = obj.WatchList.timeLim(2) + big_step;
                
            case 'F'
                xmin = obj.Dataset.Data.Time.Time(1);
                xmax = obj.WatchList.timeLim(2);
                
            case 'L'
                xmin = obj.WatchList.timeLim(1);
                xmax = obj.Dataset.Data.Time.Time(end);
                
            case 'max'
                xmin = obj.WatchList.timeLim(1);
                xmax = str2double(eventData.Source.String);
                if xmax > obj.WatchList.timeLim(1)
                    obj.WatchList.timeLim(2) = xmax;
                else
                    msgbox('Invalid value - max must be larger than min')
                    xmin = obj.WatchList.timeLim(1);
                    xmax = obj.WatchList.timeLim(2);
                end
                
            case 'min'
                xmax = obj.WatchList.timeLim(2);
                xmin = str2double(eventData.Source.String);
                if xmin < obj.WatchList.timeLim(2)
                    obj.WatchList.timeLim(1) = xmin;
                else
                    msgbox('Invalid value - min must be smaller than max')
                    xmin = obj.WatchList.timeLim(1);
                    xmax = obj.WatchList.timeLim(2);
                end
        end
        
    case 'Hit'
        xrange = obj.WatchList.timeLim(2) - obj.WatchList.timeLim(1);
        xmin = eventData.IntersectionPoint(1) - xrange/2;
        xmax = xmin + xrange;
end
if strcmp(obj.Toolbar.LockMultipleWiewer.State,'on')
    for ViewerList = obj.GHandle.Viewer
        ViewerList.WatchList.timeLim = [xmin , xmax];
    end
else
    obj.WatchList.timeLim = [xmin , xmax];
end
end
