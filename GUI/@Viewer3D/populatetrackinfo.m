function populatetrackinfo(obj)

%%%% aggiornare col CUBBONE
DetectorList = obj.Track.Channel;
TrackList = obj.Track.List;
%%%%%%%%

obj.TrackInfo.ChannelLabel = uicontrol('Parent', obj.MainInfo.TabTrack, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.85 0.35 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Channel');
obj.TrackInfo.Channel = uicontrol('Parent', obj.MainInfo.TabTrack, ...
    'Style', 'listbox', ...
    'Units', 'normalized',...
    'Position', [0.1 0.45 0.35 0.4],...
    'String', DetectorList, ...
    'Value', [], ...
    'Max', 2, ...
    'Visible', 'on', ...
    'Callback', @(h,e)channel_callback(h,e,obj));

obj.TrackInfo.TrackListLabel = uicontrol('Parent', obj.MainInfo.TabTrack, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.55 0.85 0.35 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Tracks');
obj.TrackInfo.TrackList = uicontrol('Parent', obj.MainInfo.TabTrack, ...
    'Style', 'listbox', ...
    'Units', 'normalized',...
    'Position', [0.55 0.45 0.35 0.4],...
    'String', TrackList, ...
    'Value', [], ...
    'Max', 2, ...
    'Visible', 'on', ...
    'Callback', @(h,e)track_list_callback(h,e,obj));

obj.TrackInfo.TrackCheckbox = uicontrol('Parent', obj.MainInfo.TabTrack, ...
    'Style', 'checkbox', ...
    'Units', 'normalized',...
    'Position', [0.1 0.25 0.8 0.05],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Track Visibility', ...
    'Callback', @(h,e)track_checkbox_callback(h,e,obj));


obj.TrackInfo.ChannelActive = [];
obj.TrackInfo.TrackActive = [];
end

function channel_callback(h, ~, obj)

if all(obj.TrackInfo.Channel' == h.Value, 'all') && ~isempty(obj.TrackInfo.ChannelActive)
    h.Value = [];
end
Viewer3D.trackrefresh([],[],obj);
obj.TrackInfo.ChannelActive = h.Value;
end

function track_list_callback(h, ~, obj)

if all(obj.TrackInfo.TrackList' == h.Value,'all') && ~isempty(obj.TrackInfo.TrackActive)
    h.Value = [];
end
Viewer3D.trackrefresh([],[],obj);
obj.TrackInfo.TrackActive = h.Value;
end

function track_checkbox_callback(h, ~, obj)

if h.Value
    obj.ForwardInfo.PhotonCheckbox.Value = false;
end
Viewer3D.trackrefresh([],[],obj)
end




