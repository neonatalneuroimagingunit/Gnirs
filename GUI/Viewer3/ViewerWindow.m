classdef ViewerWindow < handle & matlab.mixin.SetGet
    
    properties (Transient)
        Position
        
        
    end
    
    properties
        GHandle
    end
    
    properties
        MainFigure
        UndockedVideo
        UndockedProbe
        UndockedData
        
        DockVideo
        DockProbe
        DockData
        
        PanelPlot
        PanelInfo
        PanelVideo
        PanelPreference
        PanelProbe
        PanelData
        
        ResizeHorizontal
        ResizePlotInfo
        ResizeVideoPreference
        ResizePreferenceProbe
        ResizeProbeData
        
        UndockVideo
        UndockProbe
        UndockData
        
        
        Position_
    end
    
    methods
        function Value = get.Position(obj)
            Value = obj.Position_;
        end
        function set.Position(obj,Pos)
            obj.Position_ = Pos;
        end
        %% constructor
        function  obj = ViewerWindow(GHandle)
            obj.GHandle = GHandle;
            borderColor = [0 0 0];
            dividerSize = 5; %pixels
            figureSize = GHandle.Preference.Figure.sizeLarge;
            obj.MainFigure = figure('Position', figureSize); % cambiare con g handle
            hB = (figureSize(4) - dividerSize)/4;
            hT = hB * 3;
            wB = (figureSize(3) - 3*dividerSize)/4;
            wTR = (figureSize(3) - dividerSize)/4;
            
            wTot = wB + dividerSize;
            wTL = 3*wTot - dividerSize;
            
            obj.PanelPlot = uipanel('Parent',obj.MainFigure,...
                'BorderType','line','HighLightColor',borderColor,...
                'Units','pixels','Position',[0 hB+dividerSize wTL hT], 'Units','normalized');
            obj.PanelInfo = uipanel('Parent',obj.MainFigure,...
                'BorderType','line','HighLightColor',borderColor,...
                'Units','pixels','Position',[3*wTot hB+dividerSize wTR hT], 'Units','normalized');
            obj.DockVideo = uipanel('Parent',obj.MainFigure,...
                'BorderType','line','HighLightColor',borderColor,...
                'Units','pixels','Position',[0 0 wB hB], 'Units','normalized');
            obj.PanelPreference = uipanel('Parent',obj.MainFigure,...
                'BorderType','line','HighLightColor',borderColor,...
                'Units','pixels','Position',[wTot  0 wB hB], 'Units','normalized');
            obj.DockProbe = uipanel('Parent',obj.MainFigure,...
                'BorderType','line','HighLightColor',borderColor,...
                'Units','pixels','Position',[2*wTot 0 wB hB], 'Units','normalized');
            obj.DockData = uipanel('Parent',obj.MainFigure,...
                'BorderType','line','HighLightColor',borderColor,...
                'Units','pixels','Position',[3*wTot 0 wB hB], 'Units','normalized');
            
            obj.PanelVideo = uipanel('Parent',obj.DockVideo,...
                'BorderType','none',...
                'Units','normalized','Position',[0 0 1 1]);
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
            obj.ResizeVideoPreference = annotation(obj.MainFigure,'textbox',...
                'LineStyle','none',...
                'Units','pixels','Position',[wB 1 dividerSize hB-1],'Units','normalized',...
                'ButtonDownFcn' ,@(h,e)resize_lr(h,e,obj,obj.DockVideo,obj.PanelPreference));
            obj.ResizePreferenceProbe = annotation(obj.MainFigure,'textbox',...
                'LineStyle','none',...
                'Units', 'pixels','Position',[wB+wTot 1 dividerSize hB-1],'Units','normalized',...
                'ButtonDownFcn' ,@(h,e)resize_lr(h,e,obj,obj.PanelPreference,obj.DockProbe));
            obj.ResizeProbeData = annotation(obj.MainFigure,'textbox',...
                'LineStyle','none',...
                'Units','pixels','Position',[wB+2*wTot 1 dividerSize hB-1],'Units','normalized',...
                'ButtonDownFcn' ,@(h,e)resize_lr(h,e,obj,obj.DockProbe,obj.DockData));
            
            
            undockButtonPosition = [0.9 0.9 0.1 0.1];
            obj.UndockVideo = uicontrol('Parent', obj.PanelVideo, 'Style','pushbutton', ...
                'Units','normalized','Position',undockButtonPosition,...
                'String','↗',...
                'Callback',@(h,e)undock_video(h,e,obj));
            obj.UndockProbe = uicontrol('Parent', obj.PanelProbe, 'Style','pushbutton', ...
                'Units','normalized','Position',undockButtonPosition, ...
                'String','↗',...
                'Callback',@(h,e)undock_probe(h,e,obj));
            obj.UndockData = uicontrol('Parent', obj.PanelData, 'Style','pushbutton', ...
                'Units','normalized','Position',undockButtonPosition, ...
                'String','↗',...
                'Callback',@(h,e)undock_data(h,e,obj));
        end
    end
    
end


function undock_video(~, ~, obj)
if isempty(obj.UndockedVideo)
    obj.UndockedVideo = figure('CloseRequestFcn',@(h,e)undock_video(h, e, obj));
    obj.UndockVideo.Units = 'pixels';
    obj.PanelVideo.Parent = obj.UndockedVideo;
    obj.UndockVideo.String = '↘';
    obj.UndockVideo.Position(1:2) = obj.UndockedVideo.Position(3:4)-obj.UndockVideo.Position(3:4);
    obj.DockVideo.Units = 'pixels';
    obj.ResizeVideoPreference.Units = 'pixels';
    obj.PanelPreference.Units = 'pixels';
    obj.DockVideo.Position(3) = 0;
    obj.ResizeVideoPreference.Position(1) = 0;
    obj.ResizeVideoPreference.Position(3) = 0;
    obj.PanelPreference.Position(3) =  obj.PanelPreference.Position(1)+ obj.PanelPreference.Position(3);
    obj.PanelPreference.Position(1) = obj.ResizeVideoPreference.Position(1);
    obj.DockVideo.Units = 'normalized';
    obj.ResizeVideoPreference.Units = 'normalized';
    obj.PanelPreference.Units = 'normalized';
    
else
    obj.DockVideo.Units = 'pixels';
    obj.ResizeVideoPreference.Units = 'pixels';
    obj.PanelPreference.Units = 'pixels';
    obj.ResizeVideoPreference.Position(3) = 5;
    obj.DockVideo.Position(3) = max(obj.PanelPreference.Position(3)/2 - 5,0);
    obj.ResizeVideoPreference.Position(1) = obj.DockVideo.Position(1) + obj.DockVideo.Position(3);
    obj.PanelPreference.Position(3) = max((obj.PanelPreference.Position(3) + obj.PanelPreference.Position(1)) - (obj.ResizeVideoPreference.Position(1) + obj.ResizeVideoPreference.Position(3)),1);
    obj.PanelPreference.Position(1) = obj.PanelPreference.Position(1) + obj.PanelPreference.Position(3)/2;
    obj.PanelPreference.Position(1) = (obj.ResizeVideoPreference.Position(1) + obj.ResizeVideoPreference.Position(3));
    
    obj.PanelVideo.Parent = obj.DockVideo;
    obj.UndockedVideo.delete;
    obj.UndockedVideo = [];
    obj.UndockVideo.String = '↗';
    obj.UndockVideo.Position(1:2) = obj.DockVideo.Position(3:4)-obj.UndockVideo.Position(3:4);
    obj.UndockVideo.Units = 'normalized';
    obj.DockVideo.Units = 'normalized';
    obj.ResizeVideoPreference.Units = 'normalized';
    obj.PanelPreference.Units = 'normalized';
end
end
function undock_probe(~, ~, obj)
if isempty(obj.UndockedProbe)
    obj.UndockedProbe = figure('CloseRequestFcn',@(h,e)undock_video(h, e, obj));
    obj.UndockProbe.String = '↘';
    obj.PanelProbe.Parent = obj.UndockedProbe;
else
    obj.PanelProbe.Parent = obj.DockProbe;
    obj.UndockedProbe.delete;
    obj.UndockedProbe = [];
    obj.UndockProbe.String = '↗';
end
end
function undock_data(~, ~, obj)
if isempty(obj.UndockedData)
    obj.UndockedData = figure('CloseRequestFcn',@(h,e)undock_video(h, e, obj));
    obj.UndockData.String = '↘';
    obj.PanelData.Parent = obj.UndockedData;
else
    obj.PanelData.Parent = obj.DockData;
    obj.UndockedData.delete;
    obj.UndockedData = [];
    obj.UndockData.String = '↗';
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

