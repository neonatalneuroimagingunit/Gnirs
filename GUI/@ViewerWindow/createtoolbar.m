function createtoolbar(obj)
obj.Toolbar.MainToolbar = uitoolbar('Parent',obj.MainFigure);

img1 = rand(16,16,3);
obj.Toolbar.pushtool1 = uipushtool(obj.Toolbar.MainToolbar,...
    'CData', img1, 'Separator', 'on', ...
    'TooltipString', 'Your toggle tool', ...
    'HandleVisibility', 'off');

%img2 = 0.5.*ones(16,16,3);
[X,map] = imread([obj.GHandle.Preference.Path.currentPath filesep 'Images' filesep 'lock.png']);
img2 = ind2rgb(X,map);
obj.Toolbar.LockMultipleWiewer  = uitoggletool(obj.Toolbar.MainToolbar,...
    'CData', img2, 'Separator', 'on', ...
    'TooltipString', 'Your toggle tool', ...
    'ClickedCallback',@(h,e)lockmultiplewiewer_callback(h, e, obj),...
    'HandleVisibility', 'off');
img3 = rand(16,16,3);
obj.Toolbar.toggletool2 = uitoggletool(obj.Toolbar.MainToolbar,...
    'CData', img3, 'Separator', 'off', ...
    'TooltipString', 'Your toggle tool', ...
    'HandleVisibility', 'off');
img4 = rand(16,16,3);
obj.Toolbar.toggletool3 = uitoggletool(obj.Toolbar.MainToolbar,...
    'CData', img4, 'Separator', 'off', ...
    'TooltipString', 'Your toggle tool', ...
    'HandleVisibility', 'off');
end

function lockmultiplewiewer_callback(handle, ~, obj)
    for VieverList = obj.GHandle.Viewer
        VieverList.Toolbar.LockMultipleWiewer.State = handle.State;
    end
end