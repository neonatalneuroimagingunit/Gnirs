function populateinfo(obj)
obj.DataTypeLabel = uicontrol('Parent', obj.InfoPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.95 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'String', 'Data type');
obj.DataType = uicontrol('Parent', obj.InfoPanel, ...
    'Style', 'popup', ...
    'Units', 'normalized',...
    'Position', [0.1 0.9 0.8 0.05],...
    'String', {'SrcDet'; 'Channels'}, ...
    'Callback', @(h,e)switch_datatype(h,e,obj));

obj.SrcListLabel = uicontrol('Parent', obj.InfoPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.85 0.35 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Sources');
obj.SrcList = uicontrol('Parent', obj.InfoPanel, ...
    'Style', 'listbox', ...
    'Units', 'normalized',...
    'Position', [0.1 0.45 0.35 0.4],...
    'String', obj.Probe.source.label, ...
    'Value', [], ...
    'Max', 2, ...
    'Visible', 'on', ...
    'Callback', @(h,e)srclist_callback(h,e,obj));

obj.DetListLabel = uicontrol('Parent', obj.InfoPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.55 0.85 0.35 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Detectors');
obj.DetList = uicontrol('Parent', obj.InfoPanel, ...
    'Style', 'listbox', ...
    'Units', 'normalized',...
    'Position', [0.55 0.45 0.35 0.4],...
    'String', obj.Probe.detector.label, ...
    'Value', [], ...
    'Max', 2, ...
    'Visible', 'on', ...
    'Callback', @(h,e)detlist_callback(h,e,obj));

obj.ChannelListLabel = uicontrol('Parent', obj.InfoPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.85 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'off', ...
    'String', 'Channels');
obj.ChannelList = uicontrol('Parent', obj.InfoPanel, ...
    'Style', 'listbox', ...
    'Units', 'normalized',...
    'Position', [0.1 0.45 0.8 0.4],...
    'String', obj.Probe.channel.label, ...
    'Max', 2, ...
    'Value', [], ...
    'Visible', 'off', ...
    'Callback', @(h,e)channellist_callback(h,e,obj));

obj.OptodeCheckbox = uicontrol('Parent', obj.InfoPanel, ...
    'Style', 'checkbox', ...
    'Units', 'normalized',...
    'Position', [0.1 0.35 0.8 0.05],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Optodes', ...
    'Value', true, ...
    'Callback', @(h,e)optode_checkbox(h,e,obj));
obj.ArrowCheckbox = uicontrol('Parent', obj.InfoPanel, ...
    'Style', 'checkbox', ...
    'Units', 'normalized',...
    'Position', [0.1 0.3 0.8 0.05],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Direction', ...
    'Value', true, ...
    'Callback', @(h,e)arrow_checkbox(h,e,obj));
obj.PhotonCheckbox = uicontrol('Parent', obj.InfoPanel, ...
    'Style', 'checkbox', ...
    'Units', 'normalized',...
    'Position', [0.1 0.25 0.8 0.05],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Photon density', ...
    'Callback', @(h,e)ViewForward.photonrefresh(h,e,obj));

end

function switch_datatype(h, ~, obj)
if h.Value == 1
    obj.SrcListLabel.Visible = 'on';
    obj.SrcList.Visible = 'on';
    obj.DetListLabel.Visible = 'on';
    obj.DetList.Visible = 'on';
    obj.ChannelList.Visible = 'off';
    obj.ChannelListLabel.Visible = 'off';
else
    obj.SrcListLabel.Visible = 'off';
    obj.SrcList.Visible = 'off';
    obj.DetListLabel.Visible = 'off';
    obj.DetList.Visible = 'off';
    obj.ChannelList.Visible = 'on';
    obj.ChannelListLabel.Visible = 'on';
end
end

function srclist_callback(h, ~, obj)
colorOn = 'r';
colorOff = [0.2 0 0];
if all(obj.SrcActive' == h.Value,'all') && ~isempty(obj.SrcActive)
    h.Value = [];
end
set(obj.SourceOptode,'Color', colorOff);
set(obj.SourceOptode(h.Value),'Color', colorOn);
ViewForward.photonrefresh([],[],obj);
obj.SrcActive = h.Value;
end
function detlist_callback(h, ~, obj)
colorOn = [0 0 1];
colorOff = [0 0 0.2];
if all(obj.DetActive' == h.Value,'all') && ~isempty(obj.DetActive)
    h.Value = [];
end
set(obj.DetectorOptode,'Color', colorOff);
set(obj.DetectorOptode(h.Value),'Color', colorOn);
ViewForward.photonrefresh([],[],obj);
obj.DetActive = h.Value;
end
function channellist_callback(h, ~, obj)
src = obj.Probe.channel.pairs(h.Value,1);
det = obj.Probe.channel.pairs(h.Value,2);
colorOn = [1 0 0];
colorOff = [0.2 0 0];
if all(obj.ChannelActive' == h.Value,'all') && ~isempty(obj.ChannelActive)
    h.Value = [];
end
set(obj.SourceOptode,'Color', colorOff);
set(obj.SourceOptode(src),'Color', colorOn);
colorOn = [0 0 1];
colorOff = [0 0 0.2];
set(obj.DetectorOptode,'Color', colorOff);
set(obj.DetectorOptode(det),'Color', colorOn);
ViewForward.photonrefresh([],[],obj);
obj.ChannelActive = h.Value;
end

function optode_checkbox(h, ~, obj)
if h.Value == true
    set(obj.SourceOptode,'Visible', 'on');
    set(obj.DetectorOptode,'Visible', 'on');
else
    set(obj.SourceOptode,'Visible', 'off');
    set(obj.DetectorOptode,'Visible', 'off');
end
end

function arrow_checkbox(h, ~, obj)

end
