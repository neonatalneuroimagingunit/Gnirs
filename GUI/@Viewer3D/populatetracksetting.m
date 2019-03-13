function populatetracksetting(obj)
obj.MainSetting.Panel.Children.delete;

obj.TrackSetting.DownSamplingLabel = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.95 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Downsampling Factor [> 1]');
obj.TrackSetting.DownSampling = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'edit', ...
    'Units', 'normalized',...
    'Position', [0.1 0.91 0.8 0.04],...
    'String', '10', ...
    'Visible', 'on', ...
    'Callback', @(h,e)Viewer3D.trackrefresh(h,e,obj));

obj.TrackSetting.MaxMarkerSizeLabel = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.85 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Max Marker Size');
obj.TrackSetting.MaxMarkerSize = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'edit', ...
    'Units', 'normalized',...
    'Position', [0.1 0.81 0.8 0.04],...
    'String', '10', ...
    'Visible', 'on', ...
    'Callback', @(h,e)Viewer3D.trackrefresh(h,e,obj));

obj.TrackSetting.AngleLabel = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.75 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Plane cut angles');
obj.TrackSetting.Angle1 = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'edit', ...
    'Units', 'normalized',...
    'Position', [0.1 0.71 0.35 0.04],...
    'String', '0', ...
    'Visible', 'on', ...
    'Callback', @(h,e)Viewer3D.photonrefresh(h,e,obj));
obj.TrackSetting.Angle2 = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'edit', ...
    'Units', 'normalized',...
    'Position', [0.55 0.71 0.35 0.04],...
    'String', '0', ...
    'Visible', 'on', ...
    'Callback', @(h,e)Viewer3D.trackrefresh(h,e,obj));

% obj.TrackSetting.ThresholdLabel = uicontrol('Parent', obj.MainSetting.Panel, ...
%     'Style', 'text', ...
%     'Units', 'normalized',...
%     'Position', [0.1 0.65 0.8 0.03],...
%     'HorizontalAlignment', 'left', ...
%     'Visible', 'on', ...
%     'String', 'Threshold');
% obj.TrackSetting.Threshold = uicontrol('Parent', obj.MainSetting.Panel, ...
%     'Style', 'edit', ...
%     'Units', 'normalized',...
%     'Position', [0.1 0.61 0.8 0.04],...
%     'String', '-6', ...
%     'Visible', 'on', ...
%     'Callback', @(h,e)Viewer3D.trackrefresh(h,e,obj));

obj.TrackSetting.PlayButtonLabel = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.45 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'off', ...
    'String', 'Play');
obj.TrackSetting.PlayButton = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'togglebutton', ...
    'Units', 'normalized',...
    'Position', [0.1 0.41 0.8 0.04],...
    'String', 'PLAY', ...
    'Visible', 'on', ...
    'Callback', @(h,e)play_reconstruction(h,e,obj));

obj.TrackSetting.ScaleLabel = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.55 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Scale');
obj.TrackSetting.Scale = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'popup', ...
    'Units', 'normalized',...
    'Position', [0.1 0.51 0.8 0.04],...
    'String', {'linear'; 'log10'; 'log'; 'exp'; 'sqrt'; 'cube root'}, ...
    'Value', 2, ...
    'Visible', 'on', ...
    'Callback', @(h,e)Viewer3D.trackrefresh(h,e,obj));

%% time slider
obj.TrackSetting.TimeSliderLabel = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.35 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Time Slider');

obj.TrackSetting.TimeSlider = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'slider', ...
    'Units', 'normalized',...
    'Position', [0.1 0.31 0.8 0.04],...
    'SliderStep', [0.01 0.1], ...
    'Visible', 'on', ...
    'Callback', @(h,e)Viewer3D.trackrefresh(h,e,obj));

%% histogram
obj.TrackSetting.HistogramPanel = uipanel('Parent', obj.MainSetting.Panel,...
    'Units', 'normalized', ...
    'BorderType', 'none', ...
    'Position', [0.1 0.02 0.8 0.25]);

obj.TrackSetting.HistogramLabel = uicontrol('Parent', obj.TrackSetting.HistogramPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0 0.9 1 0.1],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Histogram');

obj.TrackSetting.HistogramAxes = axes('Parent', obj.TrackSetting.HistogramPanel, ...
    'Units', 'normalized', ...
    'NextPlot', 'add', ...
    'Position', [0.1 0.45 0.9 0.4], ...
    'Visible', 'on');

obj.TrackSetting.Histogram = histogram(obj.TrackSetting.HistogramAxes, ...
    obj.Track.Value(:), ...
    'EdgeAlpha',0);

y1 = obj.TrackSetting.HistogramAxes.YLim(1);
h1 = obj.TrackSetting.HistogramAxes.YLim(2)- obj.TrackSetting.HistogramAxes.YLim(1);
obj.TrackSetting.Rectangle1 = rectangle('Position',[0 y1 0 h1], ...
    'EdgeColor', 'none', ...
    'FaceColor', [1 0 0 0.3], ...
    'Curvature',0);

y2 = obj.TrackSetting.HistogramAxes.YLim(1);
h2 = obj.TrackSetting.HistogramAxes.YLim(2)- obj.TrackSetting.HistogramAxes.YLim(1);
obj.TrackSetting.Rectangle2 = rectangle('Position',[0 y2 0 h2], ...
    'EdgeColor', 'none', ...
    'FaceColor', [1 0 0 0.3], ...
    'Curvature',0);


x1 = obj.TrackSetting.HistogramAxes.XLim(1);
x2 = obj.TrackSetting.HistogramAxes.XLim(2);
obj.TrackSetting.HistogramMin1 = uicontrol('Parent', obj.TrackSetting.HistogramPanel, ...
    'Style', 'edit', ...
    'Units', 'normalized',...
    'Position', [0.2 0.2 0.2 0.1],...
    'HorizontalAlignment', 'left', ...
    'Callback', @(h,e)rescale_plot(h,e,obj), ...
    'Visible', 'on', ...
    'String', num2str(x1));
obj.TrackSetting.HistogramMax1 = uicontrol('Parent', obj.TrackSetting.HistogramPanel, ...
    'Style', 'edit', ...
    'Units', 'normalized',...
    'Position', [0.2 0.1 0.2 0.1],...
    'HorizontalAlignment', 'left', ...
    'Callback', @(h,e)rescale_plot(h,e,obj), ...
    'Visible', 'on', ...
    'String', '-1');
obj.TrackSetting.HistogramMin2 = uicontrol('Parent', obj.TrackSetting.HistogramPanel, ...
    'Style', 'edit', ...
    'Units', 'normalized',...
    'Position', [0.6 0.2 0.2 0.1],...
    'HorizontalAlignment', 'left', ...
    'Callback', @(h,e)rescale_plot(h,e,obj), ...
    'Visible', 'on', ...
    'String', '1');
obj.TrackSetting.HistogramMax2 = uicontrol('Parent', obj.TrackSetting.HistogramPanel, ...
    'Style', 'edit', ...
    'Units', 'normalized',...
    'Position', [0.6 0.1 0.2 0.1],...
    'HorizontalAlignment', 'left', ...
    'Callback', @(h,e)rescale_plot(h,e,obj), ...
    'Visible', 'on', ...
    'String', num2str(x2));

rescale_plot([],[],obj);
end

function rescale_plot(~,~,obj)
x1 = str2double(obj.TrackSetting.HistogramMin1.String);
w1 = str2double(obj.TrackSetting.HistogramMax1.String) - x1;
obj.TrackSetting.Rectangle1.Position(1) = x1;
obj.TrackSetting.Rectangle1.Position(3) = w1;
x2 = str2double(obj.TrackSetting.HistogramMin2.String);
w2 = str2double(obj.TrackSetting.HistogramMax2.String) - x2;
obj.TrackSetting.Rectangle2.Position(1) = x2;
obj.TrackSetting.Rectangle2.Position(3) = w2;
obj.trackrefresh([],[],obj);
end

function play_reconstruction(~,~,obj)
step = 1/size(obj.Track.Value,1);
while (obj.TrackSetting.PlayButton.Value)
    nextframe = obj.TrackSetting.TimeSlider.Value + step;
    if nextframe > 1
        nextframe = 0;
    end
    obj.TrackSetting.TimeSlider.Value = nextframe;
    obj.trackrefresh([], [], obj)
    drawnow;
    %pause(0.01);
end
end