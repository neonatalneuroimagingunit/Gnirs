function createpanel(obj)

borderColor = [0 0 0];
dividerSize = 5; %pixels
figureSize = obj.GHandle.Preference.Figure.sizeLarge;
obj.MainFigure = figure('Position', figureSize, 'CloseRequestFcn', @(h,e)close_request(h,e,obj));
hB = (figureSize(4) - dividerSize)/4;
hT = hB * 3;
wB = (figureSize(3) - 2*dividerSize)/3;
wTR = (figureSize(3) - dividerSize)/3;

wTot = wB + dividerSize;
wTL = 2*wTot - dividerSize;

obj.PanelPlot = uipanel('Parent',obj.MainFigure,...
    'BorderType','line','HighLightColor',borderColor,...
    'Units','pixels','Position',[0 hB+dividerSize wTL hT], 'Units','normalized');
obj.PanelInfo = uipanel('Parent',obj.MainFigure,...
    'BorderType','line','HighLightColor',borderColor,...
    'Units','pixels','Position',[2*wTot hB+dividerSize wTR hT], 'Units','normalized');
obj.PanelPreference = uipanel('Parent',obj.MainFigure,...
    'BorderType','line','HighLightColor',borderColor,...
    'Units','pixels','Position',[wTot  0 wB hB], 'Units','normalized');
obj.DockProbe = uipanel('Parent',obj.MainFigure,...
    'BorderType','line','HighLightColor',borderColor,...
    'Units','pixels','Position',[2*wTot 0 wB hB], 'Units','normalized');
obj.DockData = uipanel('Parent',obj.MainFigure,...
    'BorderType','line','HighLightColor',borderColor,...
    'Units','pixels','Position',[0 0 wB hB], 'Units','normalized');


obj.PanelProbe = uipanel('Parent',obj.DockProbe,...
    'BorderType','none',...
    'Units','normalized','Position',[0 0 1 1]);
obj.PanelData = uipanel('Parent',obj.DockData,...
    'BorderType','none',...
    'Units','normalized','Position',[0 0 1 1]);

obj.ResizeHorizontal = annotation(obj.MainFigure,'textbox',...
    'LineStyle','none',...
    'Units','pixels','Position',[1 hB figureSize(3) dividerSize],'Units','normalized',...
    'ButtonDownFcn' ,@(h,e)resize_vertical(h,e,obj));
obj.ResizePlotInfo = annotation(obj.MainFigure,'textbox',...
    'LineStyle','none',...
    'Units','pixels','Position',[wTL hB+dividerSize dividerSize figureSize(4)-(hB+dividerSize)],'Units','normalized',...
    'ButtonDownFcn' ,@(h,e)resize_lr(h,e,obj,obj.PanelPlot,obj.PanelInfo));
obj.ResizePreferenceProbe = annotation(obj.MainFigure,'textbox',...
    'LineStyle','none',...
    'Units', 'pixels','Position',[wB+wTot 1 dividerSize hB-1],'Units','normalized',...
    'ButtonDownFcn' ,@(h,e)resize_lr(h,e,obj,obj.PanelPreference,obj.DockProbe));
obj.ResizeDataPreference = annotation(obj.MainFigure,'textbox',...
    'LineStyle','none',...
    'Units','pixels','Position',[wB 1 dividerSize hB-1],'Units','normalized',...
    'ButtonDownFcn' ,@(h,e)resize_lr(h,e,obj,obj.DockData,obj.PanelPreference));


undockButtonPosition = [0.9 0.9 0.1 0.1];
obj.UndockProbe = uicontrol('Parent', obj.PanelProbe, 'Style','pushbutton', ...
    'Units','normalized','Position',undockButtonPosition, ...
    'String','↗',...
    'Callback',@(h,e)undock_probe(h,e,obj));
obj.UndockData = uicontrol('Parent', obj.PanelData, 'Style','pushbutton', ...
    'Units','normalized','Position',undockButtonPosition, ...
    'String','↗',...
    'Callback',@(h,e)undock_data(h,e,obj));
end



function undock_probe(~, ~, obj)
if isempty(obj.UndockedProbe)
    obj.UndockedProbe = figure('CloseRequestFcn',@(h,e)undock_probe(h, e, obj));
    obj.UndockProbe.Units = 'pixels';
    obj.PanelProbe.Parent = obj.UndockedProbe;
    obj.UndockProbe.String = '↘';
    obj.UndockProbe.Position(1:2) = obj.UndockedProbe.Position(3:4)-obj.UndockProbe.Position(3:4);
    obj.DockProbe.Units = 'pixels';
    obj.ResizePreferenceProbe.Units = 'pixels';
    obj.PanelPreference.Units = 'pixels';
    obj.DockProbe.Position(3) = 0;
    obj.ResizePreferenceProbe.Position(1) = 0;
    obj.ResizePreferenceProbe.Position(3) = 0;
    obj.PanelPreference.Position(3) = obj.MainFigure.Position(3)- obj.PanelPreference.Position(1) ;
    obj.DockProbe.Units = 'normalized';
    obj.ResizePreferenceProbe.Units = 'normalized';
    obj.PanelPreference.Units = 'normalized';
    
else
    obj.DockProbe.Units = 'pixels';
    obj.ResizePreferenceProbe.Units = 'pixels';
    obj.PanelPreference.Units = 'pixels';
    obj.ResizePreferenceProbe.Position(3) = 5;
    obj.DockProbe.Position(3) = max(obj.PanelPreference.Position(3)/2 - 5,0);
    obj.PanelPreference.Position(3) = max(obj.PanelPreference.Position(3)/2 ,0);
    obj.ResizePreferenceProbe.Position(1) = obj.PanelPreference.Position(1) + obj.PanelPreference.Position(3);
    obj.DockProbe.Position(1) = max(obj.ResizePreferenceProbe.Position(1) + obj.ResizePreferenceProbe.Position(3) , 0 );
    
    obj.PanelProbe.Parent = obj.DockProbe;
    obj.UndockedProbe.delete;
    obj.UndockedProbe= [];
    obj.UndockProbe.String = '↗';
    obj.UndockProbe.Position(1:2) = obj.DockProbe.Position(3:4)-obj.UndockProbe.Position(3:4);
    obj.UndockProbe.Units = 'normalized';
    obj.DockProbe.Units = 'normalized';
    obj.ResizePreferenceProbe.Units = 'normalized';
    obj.PanelPreference.Units = 'normalized';
end
end
function undock_data(~, ~, obj)
if isempty(obj.UndockedData)
    obj.UndockedData = figure('CloseRequestFcn',@(h,e)undock_data(h, e, obj));
    obj.UndockData.Units = 'pixels';
    obj.PanelData.Parent = obj.UndockedData;
    obj.UndockData.String = '↘';
    obj.UndockData.Position(1:2) = obj.UndockedData.Position(3:4)-obj.UndockData.Position(3:4);
    obj.DockData.Units = 'pixels';
    obj.ResizeDataPreference.Units = 'pixels';
    obj.PanelPreference.Units = 'pixels';
    obj.DockData.Position(3) = 0;
    obj.ResizeDataPreference.Position(1) = 0;
    obj.ResizeDataPreference.Position(3) = 0;
    obj.PanelPreference.Position(3) =  obj.PanelPreference.Position(1)+ obj.PanelPreference.Position(3);
    obj.PanelPreference.Position(1) = obj.ResizeDataPreference.Position(1);
    obj.DockData.Units = 'normalized';
    obj.ResizeDataPreference.Units = 'normalized';
    obj.PanelPreference.Units = 'normalized';
    
else
    obj.DockData.Units = 'pixels';
    obj.ResizeDataPreference.Units = 'pixels';
    obj.PanelPreference.Units = 'pixels';
    obj.ResizeDataPreference.Position(3) = 5;
    obj.DockData.Position(3) = max(obj.PanelPreference.Position(3)/2 - 5,0);
    obj.ResizeDataPreference.Position(1) = obj.DockData.Position(1) + obj.DockData.Position(3);
    obj.PanelPreference.Position(3) = max((obj.PanelPreference.Position(3) + obj.PanelPreference.Position(1)) - (obj.ResizeDataPreference.Position(1) + obj.ResizeDataPreference.Position(3)),1);
    obj.PanelPreference.Position(1) = (obj.ResizeDataPreference.Position(1) + obj.ResizeDataPreference.Position(3));
    
    obj.PanelData.Parent = obj.DockData;
    obj.UndockedData.delete;
    obj.UndockedData = [];
    obj.UndockData.String = '↗';
    obj.UndockData.Position(1:2) = obj.DockData.Position(3:4)-obj.UndockData.Position(3:4);
    obj.UndockData.Units = 'normalized';
    obj.DockData.Units = 'normalized';
    obj.ResizeDataPreference.Units = 'normalized';
    obj.PanelPreference.Units = 'normalized';
end
end




function resize_lr(Div, ~, obj,LPan,RPan)
obj.MainFigure.WindowButtonMotionFcn = @(h,e)panel_resizing_lr(h,e,LPan,Div,RPan);
obj.MainFigure.WindowButtonUpFcn = @(h,e)stop_resizing(h,e);
end
function panel_resizing_lr(h,~,LPan,Div,RPan)
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

obj.PanelPlot.Units = 'pixels';
obj.PanelInfo.Units = 'pixels';
obj.DockVideo.Units = 'pixels';
obj.PanelPreference.Units = 'pixels';
obj.DockProbe.Units = 'pixels';
obj.DockData.Units = 'pixels';
obj.ResizeHorizontal.Units = 'pixels';
obj.ResizePlotInfo.Units = 'pixels';
obj.ResizeVideoPreference.Units = 'pixels';
obj.ResizePreferenceProbe.Units = 'pixels';
obj.ResizeProbeData.Units = 'pixels';

yPos = max(min(h.CurrentPoint(2),h.Position(4) - obj.ResizeHorizontal.Position(4)),0);
obj.DockVideo.Position(4) = yPos;
obj.PanelPreference.Position(4) = yPos;
obj.DockProbe.Position(4) = yPos;
obj.DockData.Position(4) = yPos;
obj.ResizeVideoPreference.Position(4) = yPos;
obj.ResizePreferenceProbe.Position(4) = yPos;
obj.ResizeProbeData.Position(4) = yPos;

obj.ResizeHorizontal.Position(2) = yPos;

obj.PanelPlot.Position(2) = obj.ResizeHorizontal.Position(2) + obj.ResizeHorizontal.Position(4);
obj.PanelInfo.Position(2) = obj.ResizeHorizontal.Position(2) + obj.ResizeHorizontal.Position(4);
obj.ResizePlotInfo.Position(2) = obj.ResizeHorizontal.Position(2) + obj.ResizeHorizontal.Position(4);
obj.PanelPlot.Position(4) = h.Position(4) - obj.PanelPlot.Position(2);
obj.PanelInfo.Position(4) = h.Position(4) - obj.PanelInfo.Position(2);
obj.ResizePlotInfo.Position(4) = h.Position(4) - obj.ResizePlotInfo.Position(2);

obj.PanelPlot.Units = 'normalized';
obj.PanelInfo.Units = 'normalized';
obj.DockVideo.Units = 'normalized';
obj.PanelPreference.Units = 'normalized';
obj.DockProbe.Units = 'normalized';
obj.DockData.Units = 'normalized';
obj.ResizeHorizontal.Units = 'normalized';
obj.ResizePlotInfo.Units = 'normalized';
obj.ResizeVideoPreference.Units = 'normalized';
obj.ResizePreferenceProbe.Units = 'normalized';
obj.ResizeProbeData.Units = 'normalized';
end
function stop_resizing(h,~)
h.WindowButtonMotionFcn = [];
h.WindowButtonUpFcn = [];
end


function close_request(Handle, ~, obj)
delete(obj.UndockedProbe);
delete(obj.UndockedData); % delete all open undocked figures of viewer
delete(Handle);
obj.GHandle.deleteviewer(obj);
end
