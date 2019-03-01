function populateforwardsetting(obj)
obj.MainSetting.Panel.Children.delete;

obj.ForwardSetting.DownSamplingLabel = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.95 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Downsampling Factor [> 1]');
obj.ForwardSetting.DownSampling = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'edit', ...
    'Units', 'normalized',...
    'Position', [0.1 0.91 0.8 0.04],...
    'String', '10', ...
    'Visible', 'on', ...
    'Callback', @(h,e)Viewer3D.photonrefresh(h,e,obj));

obj.ForwardSetting.MaxMarkerSizeLabel = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.85 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Max Marker Size');
obj.ForwardSetting.MaxMarkerSize = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'edit', ...
    'Units', 'normalized',...
    'Position', [0.1 0.81 0.8 0.04],...
    'String', '10', ...
    'Visible', 'on', ...
    'Callback', @(h,e)Viewer3D.photonrefresh(h,e,obj));

obj.ForwardSetting.AngleLabel = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.75 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Plane cut angles');
obj.ForwardSetting.Angle1 = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'edit', ...
    'Units', 'normalized',...
    'Position', [0.1 0.71 0.35 0.04],...
    'String', '0', ...
    'Visible', 'on', ...
    'Callback', @(h,e)Viewer3D.photonrefresh(h,e,obj));
obj.ForwardSetting.Angle2 = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'edit', ...
    'Units', 'normalized',...
    'Position', [0.55 0.71 0.35 0.04],...
    'String', '0', ...
    'Visible', 'on', ...
    'Callback', @(h,e)Viewer3D.photonrefresh(h,e,obj));

obj.ForwardSetting.SensitivityThresholdLabel = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.65 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Sensitivity Threshold');
obj.ForwardSetting.SensitivityThreshold = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'edit', ...
    'Units', 'normalized',...
    'Position', [0.1 0.61 0.8 0.04],...
    'String', '-6', ...
    'Visible', 'on', ...
    'Callback', @(h,e)Viewer3D.photonrefresh(h,e,obj));

obj.ForwardSetting.ColormapLabel = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.55 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Colormap');
obj.ForwardSetting.Colormap = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'popup', ...
    'Units', 'normalized',...
    'Position', [0.1 0.51 0.8 0.04],...
    'String', {'parula'; 'hsv'; 'hot'; 'gray'; 'bone'; ...
    'copper';'pink'; 'white'; 'flag';  'lines'; ...
    'colorcube';'jet'; 'prism'; 'cool'; ...
    'autumn'; 'spring'; 'winter';'summer'}, ...
    'Visible', 'on', ...
    'Callback', @(h,e)Viewer3D.photonrefresh(h,e,obj));

obj.ForwardSetting.ScaleLabel = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.45 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Scale');
obj.ForwardSetting.Scale = uicontrol('Parent', obj.MainSetting.Panel, ...
    'Style', 'popup', ...
    'Units', 'normalized',...
    'Position', [0.1 0.41 0.8 0.04],...
    'String', {'linear'; 'log10'; 'log'; 'exp'; 'sqrt'; 'cube root'}, ...
    'Value', 2, ...
    'Visible', 'on', ...
    'Callback', @(h,e)Viewer3D.photonrefresh(h,e,obj));
end