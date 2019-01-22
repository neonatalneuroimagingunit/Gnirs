classdef ViewForward < handle & matlab.mixin.SetGet
    
    properties (Transient)
        Position
        Forward
        Probe
        Atlas
    end
    
    properties
        GHandle
        
        MainFigure
        InfoPanel
        PlotPanel
        SettingPanel
        ResizeButton1
        ResizeButton2
        
        DataTypeLabel
        DataType
        SrcListLabel
        SrcList
        SrcActive
        DetListLabel
        DetList
        DetActive
        ChannelListLabel
        ChannelList
        ChannelActive
        OptodeCheckbox
        ArrowCheckbox
        PhotonCheckbox
        
        ProbeAxes
        Scalp
        GreyMatter
        WhiteMatter
        Light1
        Light2
        SourceOptode
        DetectorOptode
        Sensitivity
        
        DownSamplingLabel
        DownSampling
        MaxMarkerSizeLabel
        MaxMarkerSize
        AngleLabel
        Angle1
        Angle2
        SensitivityThresholdLabel
        SensitivityThreshold
        ColormapLabel
        Colormap
        ScaleLabel
        Scale
        
        Position_
    end
    methods (Static)
        photonrefresh(h,e,obj);
    end
    methods
        populateinfo(obj)
        populateplot(obj)
        populatesetting(obj)
        
        function Value = get.Position(obj)
            Value = obj.Position_;
        end
        function set.Position(obj,Pos)
            obj.Position_ = Pos;
        end
        %% Constructor
        function  obj = ViewForward(GHandle, Forward)
            obj.GHandle = GHandle;
            
            obj.Probe = GHandle.CurrentDataSet.Probe;
            obj.Atlas = GHandle.CurrentDataSet.Atlas;
            
            obj.Forward = Forward;
            
            obj.MainFigure = figure('Position', [100 100 1200 600], ... % cambiare con g handle
                'CloseRequestFcn', @(h,e)close_function(h,e,obj));
            obj.InfoPanel = uipanel('Parent', obj.MainFigure,...
                'Units', 'normalized', ...
                'Position', [0 0 0.2 1]);
            obj.PlotPanel = uipanel('Parent', obj.MainFigure,...
                'Units', 'normalized', ...
                'Position', [0.21 0 0.59 1]);
            obj.SettingPanel = uipanel('Parent', obj.MainFigure,...
                'Units', 'normalized', ...
                'Position', [0.81 0 0.2 1]);
            
            obj.ResizeButton1 = annotation(obj.MainFigure, 'textbox', ...
                'Units', 'normalized', ...
                'Position', [0.2 0 0.01 1], ...
                'ButtonDownFcn', @(h,e)resize_1(h,e,obj));
            obj.ResizeButton2 = annotation(obj.MainFigure, 'textbox', ...
                'Units', 'normalized',...
                'Position', [0.8 0 0.01 1],...
                'ButtonDownFcn', @(h,e)resize_2(h,e,obj));
            
            obj.populateinfo;
            obj.populateplot;
            obj.populatesetting;
        end
    end
end

function close_function(h, ~, obj)
delete(h);
obj.GHandle.TempWindow = [];
end

function resize_1(~, ~, obj)
obj.MainFigure.WindowButtonMotionFcn = @(h,e)panel_resizing1(h,e,obj);
obj.MainFigure.WindowButtonUpFcn = @(h,e)stop_resizing(h,e);
end
function panel_resizing1(h, ~, obj)
relXPos = h.CurrentPoint(1)./h.Position(3);
obj.ResizeButton1.Position(1) = max(relXPos - 0.005,0);
obj.InfoPanel.Position(3) = obj.ResizeButton1.Position(1);
obj.PlotPanel.Position(1) = obj.ResizeButton1.Position(1) + 0.01;
obj.PlotPanel.Position(3) = obj.ResizeButton2.Position(1) - obj.PlotPanel.Position(1);
end

function resize_2(~, ~, obj)
obj.MainFigure.WindowButtonMotionFcn = @(h,e)panel_resizing2(h,e,obj);
obj.MainFigure.WindowButtonUpFcn = @(h,e)stop_resizing(h,e);
end
function panel_resizing2(h, ~, obj)
relXPos = h.CurrentPoint(1)./h.Position(3);
obj.SettingPanel.Position(1) = min(relXPos + 0.005,1);
obj.SettingPanel.Position(3) = 1 - obj.SettingPanel.Position(1);
obj.ResizeButton2.Position(1) = obj.SettingPanel.Position(1) - 0.01;
obj.PlotPanel.Position(3) = obj.ResizeButton2.Position(1) - obj.PlotPanel.Position(1);
end

function stop_resizing(h, ~)
h.WindowButtonMotionFcn = [];
h.WindowButtonUpFcn = [];
end






