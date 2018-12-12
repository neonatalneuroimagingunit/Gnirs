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
                'Units','pixels','Position',[0 hB+dividerSize wTL hT], 'Units','normalized');
            obj.PanelInfo = uipanel('Parent',obj.MainFigure,...
                'Units','pixels','Position',[3*wTot hB+dividerSize wTR hT], 'Units','normalized');
            obj.PanelVideo = uipanel('Parent',obj.MainFigure,...
                'Units','pixels','Position',[0 0 wB hB], 'Units','normalized');
            obj.PanelPreference = uipanel('Parent',obj.MainFigure,...
                'Units','pixels','Position',[wTot  0 wB hB], 'Units','normalized');
            obj.PanelProbe = uipanel('Parent',obj.MainFigure,...
                'Units','pixels','Position',[2*wTot 0 wB hB], 'Units','normalized');
            obj.PanelData = uipanel('Parent',obj.MainFigure,...
                'Units','pixels','Position',[3*wTot 0 wB hB], 'Units','normalized');
            
            
            obj.ResizeHorizontal = annotation(obj.MainFigure,'textbox',...
                'Units','pixels','Position',[1 hB figureSize(3) dividerSize],'Units','normalized',...
                'ButtonDownFcn' ,@(h,e)resize_vertical(h,e,obj));
            
            obj.ResizePlotInfo = annotation(obj.MainFigure,'textbox',...
                'Units','pixels','Position',[wTL hB+dividerSize dividerSize figureSize(4)-(hB+dividerSize)],'Units','normalized',...
                'ButtonDownFcn' ,@(h,e)resize_lr(h,e,obj,obj.PanelPlot,obj.PanelInfo));
            
            obj.ResizeVideoPreference = annotation(obj.MainFigure,'textbox',...
                'Units','pixels','Position',[wB 1 dividerSize hB-1],'Units','normalized',...
                'ButtonDownFcn' ,@(h,e)resize_lr(h,e,obj,obj.PanelVideo,obj.PanelPreference));
            
            obj.ResizePreferenceProbe = annotation(obj.MainFigure,'textbox',...
                'Units', 'pixels','Position',[wB+wTot 1 dividerSize hB-1],'Units','normalized',...
                'ButtonDownFcn' ,@(h,e)resize_lr(h,e,obj,obj.PanelPreference,obj.PanelProbe));
            
            obj.ResizeProbeData = annotation(obj.MainFigure,'textbox',...
                'Units','pixels','Position',[wB+2*wTot 1 dividerSize hB-1],'Units','normalized',...
                'ButtonDownFcn' ,@(h,e)resize_lr(h,e,obj,obj.PanelProbe,obj.PanelData));
            
        end
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
LPan.Position(3) =  h.CurrentPoint(1) - LPan.Position(1);
Div.Position(1) = LPan.Position(3) + LPan.Position(1);
RPan.Position(3) = RPan.Position(1)+RPan.Position(3) - (Div.Position(1)+Div.Position(3));
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
obj.PanelVideo.Units = 'pixels';
obj.PanelPreference.Units = 'pixels';
obj.PanelProbe.Units = 'pixels';
obj.PanelData.Units = 'pixels';
obj.ResizeHorizontal.Units = 'pixels';
obj.ResizePlotInfo.Units = 'pixels';
obj.ResizeVideoPreference.Units = 'pixels';
obj.ResizePreferenceProbe.Units = 'pixels';
obj.ResizeProbeData.Units = 'pixels';

obj.PanelVideo.Position(4) = h.CurrentPoint(2);
obj.PanelPreference.Position(4) = h.CurrentPoint(2);
obj.PanelProbe.Position(4) = h.CurrentPoint(2);
obj.PanelData.Position(4) = h.CurrentPoint(2);
obj.ResizeVideoPreference.Position(4) = h.CurrentPoint(2);
obj.ResizePreferenceProbe.Position(4) = h.CurrentPoint(2);
obj.ResizeProbeData.Position(4) = h.CurrentPoint(2);

obj.ResizeHorizontal.Position(2) = h.CurrentPoint(2);

obj.PanelPlot.Position(2) = obj.ResizeHorizontal.Position(2) + obj.ResizeHorizontal.Position(4);
obj.PanelInfo.Position(2) = obj.ResizeHorizontal.Position(2) + obj.ResizeHorizontal.Position(4);
obj.ResizePlotInfo.Position(2) = obj.ResizeHorizontal.Position(2) + obj.ResizeHorizontal.Position(4);

obj.PanelPlot.Position(4) = h.Position(4) - obj.PanelPlot.Position(2);
obj.PanelInfo.Position(4) = h.Position(4) - obj.PanelInfo.Position(2);
obj.ResizePlotInfo.Position(4) = h.Position(4) - obj.ResizePlotInfo.Position(2);



obj.PanelPlot.Units = 'normalized';
obj.PanelInfo.Units = 'normalized';
obj.PanelVideo.Units = 'normalized';
obj.PanelPreference.Units = 'normalized';
obj.PanelProbe.Units = 'normalized';
obj.PanelData.Units = 'normalized';
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

