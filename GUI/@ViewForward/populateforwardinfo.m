function populateforwardinfo(obj)
obj.ForwardInfo.DataTypeLabel = uicontrol('Parent', obj.MainInfo.TabForward, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.95 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'String', 'Data type');
obj.ForwardInfo.DataType = uicontrol('Parent', obj.MainInfo.TabForward, ...
    'Style', 'popup', ...
    'Units', 'normalized',...
    'Position', [0.1 0.9 0.8 0.05],...
    'String', {'SrcDet'; 'Channels'}, ...
    'Callback', @(h,e)switch_datatype(h,e,obj));

obj.ForwardInfo.SrcListLabel = uicontrol('Parent', obj.MainInfo.TabForward, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.85 0.35 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Sources');
obj.ForwardInfo.SrcList = uicontrol('Parent', obj.MainInfo.TabForward, ...
    'Style', 'listbox', ...
    'Units', 'normalized',...
    'Position', [0.1 0.45 0.35 0.4],...
    'String', obj.Probe.source.label, ...
    'Value', [], ...
    'Max', 2, ...
    'Visible', 'on', ...
    'Callback', @(h,e)srclist_callback(h,e,obj));

obj.ForwardInfo.DetListLabel = uicontrol('Parent', obj.MainInfo.TabForward, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.55 0.85 0.35 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Detectors');
obj.ForwardInfo.DetList = uicontrol('Parent', obj.MainInfo.TabForward, ...
    'Style', 'listbox', ...
    'Units', 'normalized',...
    'Position', [0.55 0.45 0.35 0.4],...
    'String', obj.Probe.detector.label, ...
    'Value', [], ...
    'Max', 2, ...
    'Visible', 'on', ...
    'Callback', @(h,e)detlist_callback(h,e,obj));

obj.ForwardInfo.ChannelListLabel = uicontrol('Parent', obj.MainInfo.TabForward, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.85 0.8 0.03],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'off', ...
    'String', 'Channels');
obj.ForwardInfo.ChannelList = uicontrol('Parent', obj.MainInfo.TabForward, ...
    'Style', 'listbox', ...
    'Units', 'normalized',...
    'Position', [0.1 0.45 0.8 0.4],...
    'String', obj.Probe.channel.label, ...
    'Max', 2, ...
    'Value', [], ...
    'Visible', 'off', ...
    'Callback', @(h,e)channellist_callback(h,e,obj));

obj.ForwardInfo.OptodeCheckbox = uicontrol('Parent', obj.MainInfo.TabForward, ...
    'Style', 'checkbox', ...
    'Units', 'normalized',...
    'Position', [0.1 0.35 0.8 0.05],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Optodes', ...
    'Value', true, ...
    'Callback', @(h,e)optode_checkbox(h,e,obj));
obj.ForwardInfo.ArrowCheckbox = uicontrol('Parent', obj.MainInfo.TabForward, ...
    'Style', 'checkbox', ...
    'Units', 'normalized',...
    'Position', [0.1 0.3 0.8 0.05],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Direction', ...
    'Value', false, ...
    'Callback', @(h,e)arrow_checkbox(h,e,obj));
obj.ForwardInfo.PhotonCheckbox = uicontrol('Parent', obj.MainInfo.TabForward, ...
    'Style', 'checkbox', ...
    'Units', 'normalized',...
    'Position', [0.1 0.25 0.8 0.05],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Photon density', ...
    'Callback', @(h,e)ViewForward.photonrefresh(h,e,obj));
obj.ForwardInfo.ExtraInfoButton = uicontrol('Parent', obj.MainInfo.TabForward, ...
    'Style', 'pushbutton', ...
    'Units', 'normalized',...
    'Position', [0.1 0.1 0.8 0.05],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'on', ...
    'String', 'Forward Details', ...
    'Callback', @(h,e)ViewForward.extrainfo(h,e,obj));

obj.ForwardInfo.SrcActive = [];
obj.ForwardInfo.DetActive = [];
obj.ForwardInfo.ChannelActive = [];
end

function switch_datatype(h, ~, obj)
if h.Value == 1
    obj.ForwardInfo.SrcListLabel.Visible = 'on';
    obj.ForwardInfo.SrcList.Visible = 'on';
    obj.ForwardInfo.DetListLabel.Visible = 'on';
    obj.ForwardInfo.DetList.Visible = 'on';
    obj.ForwardInfo.ChannelList.Visible = 'off';
    obj.ForwardInfo.ChannelListLabel.Visible = 'off';
else
    obj.ForwardInfo.SrcListLabel.Visible = 'off';
    obj.ForwardInfo.SrcList.Visible = 'off';
    obj.ForwardInfo.DetListLabel.Visible = 'off';
    obj.ForwardInfo.DetList.Visible = 'off';
    obj.ForwardInfo.ChannelList.Visible = 'on';
    obj.ForwardInfo.ChannelListLabel.Visible = 'on';
end
end

function srclist_callback(h, ~, obj)
colorOn = 'r';
colorOff = [0.2 0 0];
if all(obj.ForwardInfo.SrcActive' == h.Value, 'all') && ~isempty(obj.ForwardInfo.SrcActive)
    h.Value = [];
end
set(obj.ForwardPlot.SourceOptode, 'Color', colorOff);
set(obj.ForwardPlot.SourceOptode(h.Value), 'Color', colorOn);
set(obj.ForwardPlot.SrcDirectionArrow, 'FaceColor', colorOff);
set(obj.ForwardPlot.SrcDirectionArrow(h.Value), 'FaceColor', colorOn);
ViewForward.photonrefresh([],[],obj);
obj.ForwardInfo.SrcActive = h.Value;
end

function detlist_callback(h, ~, obj)
colorOn = [0 0 1];
colorOff = [0 0 0.2];
if all(obj.ForwardInfo.DetActive' == h.Value,'all') && ~isempty(obj.ForwardInfo.DetActive)
    h.Value = [];
end
set(obj.ForwardPlot.DetectorOptode, 'Color', colorOff);
set(obj.ForwardPlot.DetectorOptode(h.Value), 'Color', colorOn);
set(obj.ForwardPlot.DetDirectionArrow, 'FaceColor', colorOff);
set(obj.ForwardPlot.DetDirectionArrow(h.Value), 'FaceColor', colorOn);
ViewForward.photonrefresh([],[],obj);
obj.ForwardInfo.DetActive = h.Value;
end

function channellist_callback(h, ~, obj)
src = obj.Probe.channel.pairs(h.Value,1);
det = obj.Probe.channel.pairs(h.Value,2);

if all(obj.ForwardInfo.ChannelActive' == h.Value,'all') && ~isempty(obj.ForwardInfo.ChannelActive)
    h.Value = [];
end

colorOn = [1 0 0];
colorOff = [0.2 0 0];
set(obj.ForwardPlot.SourceOptode, 'Color', colorOff);
set(obj.ForwardPlot.SourceOptode(src), 'Color', colorOn);
set(obj.ForwardPlot.SrcDirectionArrow, 'FaceColor', colorOff);
set(obj.ForwardPlot.SrcDirectionArrow(src), 'FaceColor', colorOn);

colorOn = [0 0 1];
colorOff = [0 0 0.2];
set(obj.ForwardPlot.DetectorOptode,'Color', colorOff);
set(obj.ForwardPlot.DetectorOptode(det),'Color', colorOn);
set(obj.ForwardPlot.DetDirectionArrow, 'FaceColor', colorOff);
set(obj.ForwardPlot.DetDirectionArrow(det), 'FaceColor', colorOn);

ViewForward.photonrefresh([],[],obj);
obj.ForwardInfo.ChannelActive = h.Value;
end

function optode_checkbox(h, ~, obj)
if h.Value == true
    set(obj.ForwardPlot.SourceOptode,'Visible', 'on');
    set(obj.ForwardPlot.DetectorOptode,'Visible', 'on');
else
    set(obj.ForwardPlot.SourceOptode,'Visible', 'off');
    set(obj.ForwardPlot.DetectorOptode,'Visible', 'off');
end
end

function arrow_checkbox(h, ~, obj)
if h.Value
    set(obj.ForwardPlot.SrcDirectionArrow, 'Visible', 'on');
    set(obj.ForwardPlot.DetDirectionArrow, 'Visible', 'on');
else
    set(obj.ForwardPlot.SrcDirectionArrow, 'Visible', 'off');
    set(obj.ForwardPlot.DetDirectionArrow, 'Visible', 'off');
end
end
