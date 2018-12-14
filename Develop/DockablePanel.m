classdef DockablePanel < handle & matlab.mixin.SetGet
    
    properties (Transient)
        Position
    end
    
    properties
        
    end
    
    properties
        UndockedFigure
        DockPanel
        InnerPanel
        UndockButton
        
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
        function  obj = Boh(Par, Pos, Nwind)
            borderColor = [0 0 0];
            dividerSize = 5; %pixels
            Nsep = Nwind - 1;
            
            obj.MainFigure = Par;
            obj.MainPanel = uipanel('Parent',Par,...
                'BorderType','none',...
                'Units','normalized','Position',Pos, 'Units','pixels');
            wid = (obj.MainPanel.Position(3) - (Nsep*dividerSize)) /Nwind;
            
            obj.DockPanel = gobjects(Nwind,1);
            obj.InnerPanel = gobjects(Nwind,1);
            obj.UndockButton = gobjects(Nwind,1);
            obj.UndockedFigure = gobjects(Nwind,1);
            undockButtonPosition = [0.9 0.9 0.1 0.1];
            for iPan = 1 : Nwind
                obj.DockPanel(iPan) = uipanel('Parent',obj.MainPanel,...
                    'BorderType','line','HighLightColor',borderColor,...
                    'Units','pixels','Position',[(wid+dividerSize)*(iPan-1) 0 wid obj.MainPanel.Position(4)], 'Units','normalized');
                
                obj.InnerPanel(iPan) = uipanel('Parent',obj.DockPanel(iPan),...
                    'BorderType','line',...
                    'Units','normalized','Position',[0 0 1 1]);
                
                obj.UndockButton(iPan) = uicontrol('Parent', obj.InnerPanel(iPan), 'Style','pushbutton', ...
                    'Units','normalized','Position',undockButtonPosition,...
                    'String','↗',...
                    'Callback',@(h,e)undock_video(h,e,obj));
            end
            
            obj.ResizeVertical = gobjects(Nsep,1);
            for iDiv = 1 : Nsep
                obj.ResizeVertical(iDiv) = annotation(obj.MainPanel,'textbox',...
                    'LineStyle','none',...
                    'Units','pixels','Position',[(wid+dividerSize)*(iDiv-1)+wid 0 dividerSize obj.MainPanel.Position(4)],'Units','normalized',...
                    'ButtonDownFcn' ,@(h,e)resize_lr(h,e,obj));
                
            end
            obj.MainPanel.Units = 'normalized';
        end
    end
end

function undock_video(h, ~, obj)
idx = find(h == obj.UndockButton);
if ~isgraphics(obj.UndockedFigure(idx),'figure')
    
    obj.UndockedFigure(idx) = figure('CloseRequestFcn',@(h,e)undock_video(h, e, obj));
    obj.UndockedFigure(idx).Units = 'pixels';
    obj.InnerPanel(idx).Parent = obj.UndockedFigure(idx);
    obj.UndockButton(idx).String = '↘';
    obj.UndockButton(idx).Position(1:2) = obj.UndockedFigure(idx).Position(3:4)-obj.UndockedFigure(idx).Position(3:4);
    

%     
% else
%     obj.DockVideo.Units = 'pixels';
%     obj.ResizeVideoPreference.Units = 'pixels';
%     obj.PanelPreference.Units = 'pixels';
%     obj.ResizeVideoPreference.Position(3) = 5;
%     obj.DockVideo.Position(3) = max(obj.PanelPreference.Position(3)/2 - 5,0);
%     obj.ResizeVideoPreference.Position(1) = obj.DockVideo.Position(1) + obj.DockVideo.Position(3);
%     obj.PanelPreference.Position(3) = max((obj.PanelPreference.Position(3) + obj.PanelPreference.Position(1)) - (obj.ResizeVideoPreference.Position(1) + obj.ResizeVideoPreference.Position(3)),1);
%     obj.PanelPreference.Position(1) = obj.PanelPreference.Position(1) + obj.PanelPreference.Position(3)/2;
%     obj.PanelPreference.Position(1) = (obj.ResizeVideoPreference.Position(1) + obj.ResizeVideoPreference.Position(3));
%     
%     obj.PanelVideo.Parent = obj.DockVideo;
%     obj.UndockedVideo.delete;
%     obj.UndockedVideo = [];
%     obj.UndockVideo.String = '↗';
%     obj.UndockVideo.Position(1:2) = obj.DockVideo.Position(3:4)-obj.UndockVideo.Position(3:4);
%     obj.UndockVideo.Units = 'normalized';
%     obj.DockVideo.Units = 'normalized';
%     obj.ResizeVideoPreference.Units = 'normalized';
%     obj.PanelPreference.Units = 'normalized';
end
end





function resize_lr(Div, ~, obj)
idx = find(Div ==obj.ResizeVertical);
obj.MainFigure.WindowButtonMotionFcn = @(h,e)panel_resizing_lr(h,e,obj.DockPanel(idx),obj.ResizeVertical(idx),obj.DockPanel(idx+1));
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
function stop_resizing(h,~)
h.WindowButtonMotionFcn = [];
h.WindowButtonUpFcn = [];
end