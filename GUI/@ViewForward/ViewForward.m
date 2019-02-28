classdef ViewForward < handle & matlab.mixin.SetGet
    
    properties (Transient)
        Position
        Forward
        Probe
        Atlas
        Track
    end
    
    properties
        GHandle
        
        MainFigure
        MainInfo
        MainPlot
        MainSetting
        MainExtra
        
        AtlasInfo
        ProbeInfo
        ForwardInfo
        TrackInfo
        
        AtlasPlot
        ProbePlot
        ForwardPlot
        TrackPlot
        
        AtlasSettings
        ProbeSettings
        ForwardSettings
        TrackSettings
        
        AtlasExtra
        ProbeExtra
        ForwardExtra
        TrackExtra
        
        
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
        
        populateatlasinfo(obj)
        populateatlasplot(obj)
        populateatlassetting(obj)
        
        populateprobeinfo(obj)
        populateprobeplot(obj)
        populateprobesetting(obj)
        
        populateforwardinfo(obj)
        populateforwardplot(obj)
        populateforwardsetting(obj)
        
        populatetrackinfo(obj)
        populatetrackplot(obj)
        populatetracksetting(obj)
        
        
        function Value = get.Position(obj)
            Value = obj.Position_;
        end
        function set.Position(obj,Pos)
            obj.Position_ = Pos;
        end
        %% Constructor
        function  obj = ViewForward(GHandle, Atlas, Probe, Forward, Track)
            
            if ~isempty(GHandle)
                obj.GHandle = GHandle;
            end
            
            if nargin >= 2
                obj.Atlas = Atlas;
                if nargin >= 3
                    obj.Probe = Probe;
                    if nargin >= 4
                        obj.Forward = Forward;
                        if nargin == 5
                            obj.Track = Track;
                        end
                    end
                end
            end
            
            
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
            obj.MainInfo.Panel = uipanel('Parent', obj.MainFigure,...
                'Units', 'normalized', ...
                'Position', [0 0 0.2 1]);
            obj.MainPlot.Panel = uipanel('Parent', obj.MainFigure,...
                'Units', 'normalized', ...
                'Position', [0.2 0 0.6 1]);
            obj.MainSetting.Panel = uipanel('Parent', obj.MainFigure,...
                'Units', 'normalized', ...
                'Position', [0.8 0 0.2 1]);
            
            obj.populateinfo;
            obj.populateplot;
            obj.populatesetting;
            
            rotate3d(obj.MainPlot.Axes);
            obj.MainFigure.Visible = 'on';
        end
    end
end

function close_function(h, ~, obj)
delete(h);
obj.GHandle.TempWindow = [];
end






