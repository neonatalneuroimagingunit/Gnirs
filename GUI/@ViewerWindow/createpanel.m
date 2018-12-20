function createpanel(obj)

borderColor = [0 0 0];
dividerSize = 5; %pixels
figureSize = obj.GHandle.Preference.Figure.sizeLarge;

obj.MainFigure = figure('Position', figureSize, ...
    'Units','pixels',...
    'Visible', 'on', ...
    'Resize', 'on',...
    'Name', 'Viewer', ...
    'Numbertitle', 'off', ...
    'Color', obj.Preference.backgroundColor, ...
    'Toolbar', 'none', ...
    'Menubar', 'none', ...
    'CloseRequestFcn',  @(h,e)close_request(h,e,obj),...
    'DoubleBuffer', 'on', ...
    'DockControls', 'off', ...
    'Renderer', 'OpenGL');

hB = (figureSize(4) - dividerSize)/4;
hT = hB * 3;
wB = (figureSize(3) - 2*dividerSize)/3;
wTR = (figureSize(3) - dividerSize)/3;

wTot = wB + dividerSize;
wTL = 2*wTot - dividerSize;

obj.Panel.PanelPlot = uipanel('Parent',obj.MainFigure,...
    'BorderType','line','HighLightColor',borderColor,...
    'Units','pixels','Position',[0 hB+dividerSize wTL hT], 'Units','normalized');
obj.Panel.PanelInfo = uipanel('Parent',obj.MainFigure,...
    'BorderType','line','HighLightColor',borderColor,...
    'Units','pixels','Position',[2*wTot hB+dividerSize wTR hT], 'Units','normalized');
obj.Panel.PanelPreference = uipanel('Parent',obj.MainFigure,...
    'BorderType','line','HighLightColor',borderColor,...
    'Units','pixels','Position',[wTot  0 wB hB], 'Units','normalized');
obj.Dock.PanelProbe = uipanel('Parent',obj.MainFigure,...
    'BorderType','line','HighLightColor',borderColor,...
    'Units','pixels','Position',[2*wTot 0 wB hB], 'Units','normalized');
obj.Dock.PanelData = uipanel('Parent',obj.MainFigure,...
    'BorderType','line','HighLightColor',borderColor,...
    'Units','pixels','Position',[0 0 wB hB], 'Units','normalized');


obj.Panel.PanelProbe = uipanel('Parent',obj.Dock.PanelProbe,...
    'BorderType','none',...
    'Units','normalized','Position',[0 0 1 1]);
obj.Panel.PanelData = uipanel('Parent',obj.Dock.PanelData,...
    'BorderType','none',...
    'Units','normalized','Position',[0 0 1 1]);

obj.Resize.Horizontal = annotation(obj.MainFigure,'textbox',...
    'LineStyle','none',...
    'Units','pixels','Position',[1 hB figureSize(3) dividerSize],'Units','normalized',...
    'ButtonDownFcn' ,@(h,e)resize_vertical(h,e,obj));
obj.Resize.PlotInfo = annotation(obj.MainFigure,'textbox',...
    'LineStyle','none',...
    'Units','pixels','Position',[wTL hB+dividerSize dividerSize figureSize(4)-(hB+dividerSize)],'Units','normalized',...
    'ButtonDownFcn' ,@(h,e)resize_lr(h,e,obj,obj.Panel.PanelPlot,obj.Panel.PanelInfo));
obj.Resize.PreferenceProbe = annotation(obj.MainFigure,'textbox',...
    'LineStyle','none',...
    'Units', 'pixels','Position',[wB+wTot 1 dividerSize hB-1],'Units','normalized',...
    'ButtonDownFcn' ,@(h,e)resize_lr(h,e,obj,obj.Panel.PanelPreference,obj.Dock.PanelProbe));
obj.Resize.DataPreference = annotation(obj.MainFigure,'textbox',...
    'LineStyle','none',...
    'Units','pixels','Position',[wB 1 dividerSize hB-1],'Units','normalized',...
    'ButtonDownFcn' ,@(h,e)resize_lr(h,e,obj,obj.Dock.PanelData,obj.Panel.PanelPreference));

obj.Undocked = struct('FigureProbe',[],'FigureData',[]);

undockButtonPosition = [0.9 0.9 0.1 0.1];
obj.Panel.UndockButtonProbe = uicontrol('Parent', obj.Panel.PanelProbe, 'Style','pushbutton', ...
    'Units','normalized','Position',undockButtonPosition, ...
    'String','↗',...
    'Callback',@(h,e)undock_probe(h,e,obj));
obj.Panel.UndockButtonData = uicontrol('Parent', obj.Panel.PanelData, 'Style','pushbutton', ...
    'Units','normalized','Position',undockButtonPosition, ...
    'String','↗',...
    'Callback',@(h,e)undock_data(h,e,obj));
end



function undock_probe(~, ~, obj)
if isempty(obj.Undocked.FigureProbe)
    obj.Undocked.FigureProbe = figure('CloseRequestFcn',@(h,e)undock_probe(h, e, obj));
    obj.Panel.UndockButtonProbe.Units = 'pixels';
    obj.Panel.PanelProbe.Parent = obj.Undocked.FigureProbe;
    obj.Panel.UndockButtonProbe.String = '↘';
    obj.Panel.UndockButtonProbe.Position(1:2) = obj.Undocked.FigureProbe.Position(3:4)-obj.Panel.UndockButtonProbe.Position(3:4);
    obj.Dock.PanelProbe.Units = 'pixels';
    obj.Resize.PreferenceProbe.Units = 'pixels';
    obj.Panel.PanelPreference.Units = 'pixels';
    obj.Dock.PanelProbe.Position(3) = 0;
    obj.Resize.PreferenceProbe.Position(1) = 0;
    obj.Resize.PreferenceProbe.Position(3) = 0;
    obj.Panel.PanelPreference.Position(3) = obj.MainFigure.Position(3)- obj.Panel.PanelPreference.Position(1) ;
    obj.Dock.PanelProbe.Units = 'normalized';
    obj.Resize.PreferenceProbe.Units = 'normalized';
    obj.Panel.PanelPreference.Units = 'normalized';
    
else
    obj.Dock.PanelProbe.Units = 'pixels';
    obj.Resize.PreferenceProbe.Units = 'pixels';
    obj.Panel.PanelPreference.Units = 'pixels';
    obj.Resize.PreferenceProbe.Position(3) = 5;
    obj.Dock.PanelProbe.Position(3) = max(obj.Panel.PanelPreference.Position(3)/2 - 5,0);
    obj.Panel.PanelPreference.Position(3) = max(obj.Panel.PanelPreference.Position(3)/2 ,0);
    obj.Resize.PreferenceProbe.Position(1) = obj.Panel.PanelPreference.Position(1) + obj.Panel.PanelPreference.Position(3);
    obj.Dock.PanelProbe.Position(1) = max(obj.Resize.PreferenceProbe.Position(1) + obj.Resize.PreferenceProbe.Position(3) , 0 );
    
    obj.Panel.PanelProbe.Parent = obj.Dock.PanelProbe;
    obj.Undocked.FigureProbe.delete;
    obj.Undocked.FigureProbe = [];
    obj.Panel.UndockButtonProbe.String = '↗';
    obj.Panel.UndockButtonProbe.Position(1:2) = obj.Dock.PanelProbe.Position(3:4)-obj.Panel.UndockButtonProbe.Position(3:4);
    obj.Dock.PanelProbe.Units = 'normalized';
    obj.Panel.UndockButtonProbe.Units = 'normalized';
    obj.Resize.PreferenceProbe.Units = 'normalized';
    obj.Panel.PanelPreference.Units = 'normalized';
end
end
function undock_data(~, ~, obj)
if isempty(obj.Undocked.FigureData)
    obj.Undocked.FigureData = figure('CloseRequestFcn',@(h,e)undock_data(h, e, obj));
    obj.Panel.UndockButtonData.Units = 'pixels';
    obj.Panel.PanelData.Parent = obj.Undocked.FigureData;
    obj.Panel.UndockButtonData.String = '↘';
    obj.Panel.UndockButtonData.Position(1:2) = obj.Undocked.FigureData.Position(3:4)-obj.Panel.UndockButtonData.Position(3:4);
    obj.Dock.PanelData.Units = 'pixels';
    obj.Resize.DataPreference.Units = 'pixels';
    obj.Panel.PanelPreference.Units = 'pixels';
    obj.Dock.PanelData.Position(3) = 0;
    obj.Resize.DataPreference.Position(1) = 0;
    obj.Resize.DataPreference.Position(3) = 0;
    obj.Panel.PanelPreference.Position(3) =  obj.Panel.PanelPreference.Position(1)+ obj.Panel.PanelPreference.Position(3);
    obj.Panel.PanelPreference.Position(1) = obj.Resize.DataPreference.Position(1);
    obj.Panel.UndockButtonData.Units = 'normalized';
    obj.Resize.DataPreference.Units = 'normalized';
    obj.Panel.PanelPreference.Units = 'normalized';
    obj.Dock.PanelData.Units = 'normalized';
    
else
    obj.Dock.PanelData.Units = 'pixels';
    obj.Resize.DataPreference.Units = 'pixels';
    obj.Panel.PanelPreference.Units = 'pixels';
    obj.Panel.UndockButtonData.Units = 'pixels';
    obj.Resize.DataPreference.Position(3) = 5;
    obj.Dock.PanelData.Position(3) = max(obj.Panel.PanelPreference.Position(3)/2 - obj.Resize.DataPreference.Position(3),0);
    obj.Resize.DataPreference.Position(1) = obj.Dock.PanelData.Position(1) + obj.Dock.PanelData.Position(3);
    obj.Panel.PanelPreference.Position(3) = max((obj.Panel.PanelPreference.Position(3) + obj.Panel.PanelPreference.Position(1)) - (obj.Resize.DataPreference.Position(1) + obj.Resize.DataPreference.Position(3)),1);
    obj.Panel.PanelPreference.Position(1) = (obj.Resize.DataPreference.Position(1) + obj.Resize.DataPreference.Position(3));
    
    obj.Panel.PanelData.Parent = obj.Dock.PanelData;
    obj.Undocked.FigureData.delete;
    obj.Undocked.FigureData = [];
    obj.Panel.UndockButtonData.String = '↗';
    obj.Panel.UndockButtonData.Position(1:2) = obj.Dock.PanelData.Position(3:4)-obj.Panel.UndockButtonData.Position(3:4);
    obj.Panel.UndockButtonData.Units = 'normalized';
    obj.Dock.PanelData.Units = 'normalized';
    obj.Resize.DataPreference.Units = 'normalized';
    obj.Panel.PanelPreference.Units = 'normalized';
end
end




function resize_lr(Div, ~, obj,LPan,RPan)
obj.MainFigure.WindowButtonMotionFcn = @(h,e)panel_resizing_lr(h,e,LPan,Div,RPan, obj);
obj.MainFigure.WindowButtonUpFcn = @(h,e)stop_resizing(h,e);
end
function panel_resizing_lr(h,~,LPan,Div,RPan,obj)
LPan.Units = 'pixels';
Div.Units = 'pixels';
RPan.Units = 'pixels';

LPan.Position(3) =  min(max(h.CurrentPoint(1) - LPan.Position(1),1),RPan.Position(1)+RPan.Position(3)-LPan.Position(1)-Div.Position(3)-1);
Div.Position(1) = min(max(LPan.Position(3) + LPan.Position(1),LPan.Position(1)),RPan.Position(1)+RPan.Position(3)-Div.Position(3));
RPan.Position(3) =  RPan.Position(1)+RPan.Position(3) - (Div.Position(1)+Div.Position(3));
RPan.Position(1) = (Div.Position(1)+Div.Position(3));

LPan.Units = 'normalized';
Div.Units = 'normalized';
RPan.Units = 'normalized';
end

function resize_vertical(~, ~, obj)
obj.MainFigure.WindowButtonMotionFcn = @(h,e)panel_resizing_vertical(h,e,obj);
obj.MainFigure.WindowButtonUpFcn = @(h,e)stop_resizing(h,e);
end
function panel_resizing_vertical(h,~,obj)

obj.Panel.PanelPlot.Units = 'pixels';
obj.Panel.PanelInfo.Units = 'pixels';
obj.Dock.PanelVideo.Units = 'pixels';
obj.Panel.PanelPreference.Units = 'pixels';
obj.Dock.PanelProbe.Units = 'pixels';
obj.Dock.PanelData.Units = 'pixels';
obj.Resize.Horizontal.Units = 'pixels';
obj.Resize.PlotInfo.Units = 'pixels';
obj.Resize.VideoPreference.Units = 'pixels';
obj.Resize.PreferenceProbe.Units = 'pixels';
obj.Resize.ProbeData.Units = 'pixels';

obj.Panel.UndockButtonData.Units = 'pixels';
obj.Panel.UndockButtonProbe.Units = 'pixels';

yPos = max(min(h.CurrentPoint(2),h.Position(4) - obj.Resize.Horizontal.Position(4)),0);
obj.Dock.PanelVideo.Position(4) = yPos;
obj.Panel.PanelPreference.Position(4) = yPos;
obj.Dock.PanelProbe.Position(4) = yPos;
obj.Dock.PanelData.Position(4) = yPos;
obj.Resize.VideoPreference.Position(4) = yPos;
obj.Resize.PreferenceProbe.Position(4) = yPos;
obj.Resize.ProbeData.Position(4) = yPos;

obj.Resize.Horizontal.Position(2) = yPos;

obj.Panel.PanelPlot.Position(2) = obj.Resize.Horizontal.Position(2) + obj.Resize.Horizontal.Position(4);
obj.Panel.PanelInfo.Position(2) = obj.Resize.Horizontal.Position(2) + obj.Resize.Horizontal.Position(4);
obj.Resize.PlotInfo.Position(2) = obj.Resize.Horizontal.Position(2) + obj.Resize.Horizontal.Position(4);
obj.Panel.PanelPlot.Position(4) = h.Position(4) - obj.Panel.PanelPlot.Position(2);
obj.Panel.PanelInfo.Position(4) = h.Position(4) - obj.Panel.PanelInfo.Position(2);
obj.Resize.PlotInfo.Position(4) = h.Position(4) - obj.Resize.PlotInfo.Position(2);
obj.Panel.UndockButtonData.Position(1:2) = obj.Dock.PanelData.Position(3:4)-obj.Panel.UndockButtonData.Position(3:4);
obj.Panel.UndockButtonProbe.Position(1:2) = obj.Dock.PanelProbe.Position(3:4)-obj.Panel.UndockButtonProbe.Position(3:4);

obj.Panel.UndockButtonData.Units = 'normalized';
obj.Panel.UndockButtonProbe.Units = 'normalized';

obj.Panel.PanelPlot.Units = 'normalized';
obj.Panel.PanelInfo.Units = 'normalized';
obj.Dock.PanelVideo.Units = 'normalized';
obj.Panel.PanelPreference.Units = 'normalized';
obj.Dock.PanelProbe.Units = 'normalized';
obj.Dock.PanelData.Units = 'normalized';
obj.Resize.Horizontal.Units = 'normalized';
obj.Resize.PlotInfo.Units = 'normalized';
obj.Resize.VideoPreference.Units = 'normalized';
obj.Resize.PreferenceProbe.Units = 'normalized';
obj.Resize.ProbeData.Units = 'normalized';
end
function stop_resizing(h,~)
h.WindowButtonMotionFcn = [];
h.WindowButtonUpFcn = [];
end

function close_request(Handle, ~, obj)
delete(obj.Undocked.FigureProbe);
delete(obj.Undocked.FigureData); % delete all open undocked figures of viewer
delete(Handle);
obj.GHandle.deleteviewer(obj);
end
