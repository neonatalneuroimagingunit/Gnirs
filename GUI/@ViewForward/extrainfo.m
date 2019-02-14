function extrainfo(~, ~, obj)
obj.ExtraInfo.MainFigure = figure(...
                'Position', obj.GHandle.Preference.Figure.sizeSmall, ...
                'Units','pixels',...
                'Visible', 'on', ...
                'Resize', 'on',...
                'Name', 'Viewer', ...
                'Numbertitle', 'off', ...
                'Toolbar', 'none', ...
                'Menubar', 'none', ...
                'CloseRequestFcn',  @(h,e)close_function(h,e,obj),...
                'DoubleBuffer', 'on', ...
                'DockControls', 'off', ...
                'Renderer', 'OpenGL');

            
obj.ExtraInfo.LPanel = uipanel('Parent', obj.ExtraInfo.MainFigure,...
                'Units', 'normalized', ...
                'Position', [0 0 0.5 1]);
obj.ExtraInfo.RPanel = uipanel('Parent', obj.ExtraInfo.MainFigure,...
                'Units', 'normalized', ...
                'Position', [0.5 0 0.5 1]);            

%% Left
obj.ExtraInfo.NPhotonLabel = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.9 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'N photons');
obj.ExtraInfo.NPhotonValue = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.9 0.4 0.05],...
    'String', sprintf('%e', obj.Forward.Settings.nphoton));

obj.ExtraInfo.TStartLabel = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.8 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Tstart');
obj.ExtraInfo.TStartValue = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.8 0.4 0.05],...
    'String', num2str(obj.Forward.Settings.tstart));

obj.ExtraInfo.TStepLabel = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.7 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Tstep');
obj.ExtraInfo.TStepValue = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.7 0.4 0.05],...
    'String', num2str(obj.Forward.Settings.tstep));

obj.ExtraInfo.TStopLabel = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.6 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Tend');
obj.ExtraInfo.TStopValue = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.6 0.4 0.05],...
    'String', num2str(obj.Forward.Settings.tend));

obj.ExtraInfo.SrcTypeLabel = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.5 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Source Type');
obj.ExtraInfo.SrcTypeValue = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.5 0.4 0.05],...
    'String', obj.Forward.Settings.srctype);

obj.ExtraInfo.SrcParam1Label = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.4 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Source Param 1');
obj.ExtraInfo.SrcParam1Value = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.4 0.4 0.05],...
    'String', num2str(obj.Forward.Settings.srcparam1));

obj.ExtraInfo.SrcParam2Label = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.3 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Source Param 2');
obj.ExtraInfo.SrcParam2Value = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.3 0.4 0.05],...
    'String', num2str(obj.Forward.Settings.srcparam1));

obj.ExtraInfo.SourceTypeLabel = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.2 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Label');
obj.ExtraInfo.SourceTypeValue = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.2 0.4 0.05],...
    'String', 'Text');

obj.ExtraInfo.SourceTypeLabel = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.1 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Label');
obj.ExtraInfo.SourceTypeValue = uicontrol('Parent', obj.ExtraInfo.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.1 0.4 0.05],...
    'String', 'Text');

%% Right
obj.ExtraInfo.TotalTimeLabel = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.9 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Total Time');
obj.ExtraInfo.TotalTimeValue = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.9 0.4 0.05],...
    'String', num2str(obj.Forward.Timing.total));

obj.ExtraInfo.SrcPosTimeLabel = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.8 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'SrcPos Time');
obj.ExtraInfo.SrcPosTimeValue = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.8 0.4 0.05],...
    'String', num2str(obj.Forward.Timing.srcpos));

obj.ExtraInfo.SrcDirTimeLabel = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.7 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'SrcDir Time');
obj.ExtraInfo.SrcDirTimeValue = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.7 0.4 0.05],...
    'String', num2str(obj.Forward.Timing.srcdir));

obj.ExtraInfo.SimulationTimeLabel = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.6 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Simulation Time');
obj.ExtraInfo.SimulationTimeValue = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.6 0.4 0.05],...
    'String', num2str(obj.Forward.Timing.simulation));

obj.ExtraInfo.SimulationTimeAvgLabel = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.5 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Avg Simulation Time');
obj.ExtraInfo.SimulationTimeAvgValue = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.5 0.4 0.05],...
    'String', num2str(obj.Forward.Timing.simulationAvg));

obj.ExtraInfo.SourceTypeLabel = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.4 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Label');
obj.ExtraInfo.SourceTypeValue = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.4 0.4 0.05],...
    'String', 'Text');

obj.ExtraInfo.SourceTypeLabel = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.3 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Label');
obj.ExtraInfo.SourceTypeValue = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.3 0.4 0.05],...
    'String', 'Text');

obj.ExtraInfo.SourceTypeLabel = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.2 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Label');
obj.ExtraInfo.SourceTypeValue = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.2 0.4 0.05],...
    'String', 'Text');

obj.ExtraInfo.SourceTypeLabel = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.1 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Label');
obj.ExtraInfo.SourceTypeValue = uicontrol('Parent', obj.ExtraInfo.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.1 0.4 0.05],...
    'String', 'Text');

obj.ExtraInfo.MainFigure.Position(3) = 3/2*obj.ExtraInfo.MainFigure.Position(3);
end

function close_function(h, ~, obj)
delete(h)
obj.ExtraInfo = [];
end