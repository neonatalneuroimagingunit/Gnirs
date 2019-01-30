function dispmethod(obj)
backgroundColor = [0.9 0.9 0.9];

Method = obj.Method;
paramNames = fieldnames(Method.Parameters);

%% Calculate sizing parameters
nParam = length(paramNames);
inter = 1/(5*nParam+1);
intra = 2*inter;

%% Create GUI objects
for iParam = 1:1:nParam
    value = num2str(Method.Parameters.(paramNames{iParam}));
    labelPos = [0.1, intra*iParam + 3*inter*(iParam-1)+inter, 0.8, inter];
    valuePos = [0.1, intra*iParam + 3*inter*(iParam-1), 0.8, inter];
    textLabel(iParam) = uicontrol('Parent', obj.Parent.InfoSetPanel, ...
        'Style', 'text', ...
        'Units', 'normalized',...
        'Position', labelPos,...
        'HorizontalAlignment', 'left', ...
        'BackgroundColor', backgroundColor*0.9, ...
        'Visible', 'on', ...
        'String', paramNames{iParam});
    textValue(iParam) = uicontrol('Parent', obj.Parent.InfoSetPanel, ...
        'Style', 'edit', ...
        'Units', 'normalized',...
        'Position', valuePos,...
        'HorizontalAlignment', 'left', ...
        'BackgroundColor', backgroundColor*1.1, ...
        'Visible', 'on', ...
        'String', value);
end

end

