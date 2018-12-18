classdef ViewerWindow < handle & matlab.mixin.SetGet
    
    properties (Transient)
        Position
        
        
    end
    
    properties
        GHandle
    end
    
    properties
        MainFigure
        UndockedProbe
        UndockedData
        
        DockProbe
        DockData
        
        PanelPlot
        PanelInfo
        PanelPreference
        PanelProbe
        PanelData
        
        ResizeHorizontal
        ResizePlotInfo
        ResizePreferenceProbe
        ResizeDataPreference
        
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
        end
    end
end


