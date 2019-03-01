function extrainfo(~, ~, obj)
obj.ForwardExtra.MainFigure = figure(...
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

            
obj.ForwardExtra.LPanel = uipanel('Parent', obj.ForwardExtra.MainFigure,...
                'Units', 'normalized', ...
                'Position', [0 0 0.5 1]);
obj.ForwardExtra.RPanel = uipanel('Parent', obj.ForwardExtra.MainFigure,...
                'Units', 'normalized', ...
                'Position', [0.5 0 0.5 1]);            

%% Left
obj.ForwardExtra.NPhotonLabel = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.9 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'N photons');
obj.ForwardExtra.NPhotonValue = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.9 0.4 0.05],...
    'String', sprintf('%e', obj.Forward.Settings.nphoton));

obj.ForwardExtra.TStartLabel = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.8 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Tstart');
obj.ForwardExtra.TStartValue = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.8 0.4 0.05],...
    'String', num2str(obj.Forward.Settings.tstart));

obj.ForwardExtra.TStepLabel = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.7 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Tstep');
obj.ForwardExtra.TStepValue = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.7 0.4 0.05],...
    'String', num2str(obj.Forward.Settings.tstep));

obj.ForwardExtra.TStopLabel = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.6 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Tend');
obj.ForwardExtra.TStopValue = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.6 0.4 0.05],...
    'String', num2str(obj.Forward.Settings.tend));

obj.ForwardExtra.SrcTypeLabel = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.5 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Source Type');
obj.ForwardExtra.SrcTypeValue = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.5 0.4 0.05],...
    'String', obj.Forward.Settings.srctype);

obj.ForwardExtra.SrcParam1Label = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.4 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Source Param 1');
obj.ForwardExtra.SrcParam1Value = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.4 0.4 0.05],...
    'String', num2str(obj.Forward.Settings.srcparam1));

obj.ForwardExtra.SrcParam2Label = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.3 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Source Param 2');
obj.ForwardExtra.SrcParam2Value = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.3 0.4 0.05],...
    'String', num2str(obj.Forward.Settings.srcparam1));

obj.ForwardExtra.SourceTypeLabel = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.2 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'off', ...
    'String', 'Label');
obj.ForwardExtra.SourceTypeValue = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Visible', 'off', ...
    'Position', [0.5 0.2 0.4 0.05],...
    'String', 'Text');

obj.ForwardExtra.SourceTypeLabel = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.1 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'off', ...
    'String', 'Label');
obj.ForwardExtra.SourceTypeValue = uicontrol('Parent', obj.ForwardExtra.LPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.1 0.4 0.05],...
    'Visible', 'off', ...
    'String', 'Text');

%% Right
obj.ForwardExtra.TotalTimeLabel = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.9 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Total Time');
obj.ForwardExtra.TotalTimeValue = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.9 0.4 0.05],...
    'String', num2str(obj.Forward.Timing.total));

obj.ForwardExtra.SrcPosTimeLabel = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.8 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'SrcPos Time');
obj.ForwardExtra.SrcPosTimeValue = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.8 0.4 0.05],...
    'String', num2str(obj.Forward.Timing.srcpos));

obj.ForwardExtra.SrcDirTimeLabel = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.7 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'SrcDir Time');
obj.ForwardExtra.SrcDirTimeValue = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.7 0.4 0.05],...
    'String', num2str(obj.Forward.Timing.srcdir));

obj.ForwardExtra.SimulationTimeLabel = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.6 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Simulation Time');
obj.ForwardExtra.SimulationTimeValue = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.6 0.4 0.05],...
    'String', num2str(obj.Forward.Timing.simulation));

obj.ForwardExtra.SimulationTimeAvgLabel = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.5 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'String', 'Avg Simulation Time');
obj.ForwardExtra.SimulationTimeAvgValue = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.5 0.4 0.05],...
    'String', num2str(obj.Forward.Timing.simulationAvg));

obj.ForwardExtra.SourceTypeLabel = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.4 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'off', ...
    'String', 'Label');
obj.ForwardExtra.SourceTypeValue = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.4 0.4 0.05],...
    'Visible', 'off', ...
    'String', 'Text');

obj.ForwardExtra.SourceTypeLabel = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.3 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'off', ...
    'String', 'Label');
obj.ForwardExtra.SourceTypeValue = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.3 0.4 0.05],...
    'Visible', 'off', ...
    'String', 'Text');

obj.ForwardExtra.SourceTypeLabel = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.2 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'off', ...
    'String', 'Label');
obj.ForwardExtra.SourceTypeValue = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.2 0.4 0.05],...
    'Visible', 'off', ...
    'String', 'Text');

obj.ForwardExtra.SourceTypeLabel = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'Position', [0.1 0.1 0.5 0.05],...
    'HorizontalAlignment', 'left', ...
    'Visible', 'off', ...
    'String', 'Label');
obj.ForwardExtra.SourceTypeValue = uicontrol('Parent', obj.ForwardExtra.RPanel, ...
    'Style', 'text', ...
    'Units', 'normalized',...
    'HorizontalAlignment', 'left', ...
    'Position', [0.5 0.1 0.4 0.05],...
    'Visible', 'off', ...
    'String', 'Text');

obj.ForwardExtra.MainFigure.Position(3) = 3/2*obj.ForwardExtra.MainFigure.Position(3);
end

function close_function(h, ~, obj)
delete(h)
obj.ForwardExtra = [];
end
