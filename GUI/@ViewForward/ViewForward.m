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
        ExtraInfo
        
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
        ExtraInfoButton
        
        ProbeAxes
        Scalp
        GreyMatter
        WhiteMatter
        Light1
        Light2
        SourceOptode
        DetectorOptode
        Sensitivity
        SrcDirectionArrow
        DetDirectionArrow
        
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
        extrainfo(h,e,obj);
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
            
            obj.MainFigure = figure(...
                'Position', obj.GHandle.Preference.Figure.sizeLarge, ...
                'Units','pixels',...
                'Visible', 'off', ...
                'Resize', 'on',...
                'Name', 'View Forward', ...
                'Numbertitle', 'off', ...
                'Toolbar', 'none', ...
                'Menubar', 'none', ...
                'CloseRequestFcn',  @(h,e)close_function(h,e,obj),...
                'DoubleBuffer', 'on', ...
                'DockControls', 'off', ...
                'Renderer', 'OpenGL');
            obj.InfoPanel = uipanel('Parent', obj.MainFigure,...
                'Units', 'normalized', ...
                'Position', [0 0 0.2 1]);
            obj.PlotPanel = uipanel('Parent', obj.MainFigure,...
                'Units', 'normalized', ...
                'Position', [0.2 0 0.6 1]);
            obj.SettingPanel = uipanel('Parent', obj.MainFigure,...
                'Units', 'normalized', ...
                'Position', [0.8 0 0.2 1]);
            
            obj.populateinfo;
            obj.populateplot;
            obj.populatesetting;
            
            rotate3d(obj.ProbeAxes);
            
            obj.MainFigure.Visible = 'on';
        end
    end
end

function close_function(h, ~, obj)
delete(h);
obj.GHandle.TempWindow = [];
end






