function dispmethod(obj)
backgroundColor = [0.9 0.9 0.9];

Method = obj.Method;
paramNames = {Method.Parameters.name};
paramValue = {Method.Parameters.value};
paramStyle = {Method.Parameters.style};

%% Calculate sizing parameters
nParam = length(paramNames);
inter = 1/(5*nParam+1);
%% 
intra = 2*inter;
obj.Parent.InfoSetPanelUp.Children.delete;

%% Create GUI objects
for iParam = 1:1:nParam
    labelPos = [0.1, intra*iParam + 3*inter*(iParam-1)+inter, 0.8, inter];
    valuePos = [0.1, intra*iParam + 3*inter*(iParam-1), 0.8, inter];   
    textLabel(iParam) = uicontrol('Parent', obj.Parent.InfoSetPanelUp, ...
        'Style', 'text', ...
        'Units', 'normalized',...
        'Position', labelPos,...
        'HorizontalAlignment', 'left', ...
        'BackgroundColor', backgroundColor*0.9, ...
        'Visible', 'on', ...
        'String', paramNames{iParam});
    textValue(iParam) = uicontrol('Parent', obj.Parent.InfoSetPanelUp, ...
        'Style', paramStyle{iParam}, ...
        'Units', 'normalized',...
        'Position', valuePos,...
        'Callback', @(h,e)update_parameter(h,e,obj,iParam),...
        'HorizontalAlignment', 'left', ...
        'BackgroundColor', backgroundColor*1.1, ...
        'Visible', 'on', ...
        'String', num2str(paramValue{iParam}));
end

end

function update_parameter(h,~,obj,iParam)
paramNames = fieldnames(obj.Method.Parameters);
obj.Method.Parameters.(paramNames{iParam}) = str2double(h.String);
end








