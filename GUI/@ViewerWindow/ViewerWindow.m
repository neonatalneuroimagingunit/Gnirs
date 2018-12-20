classdef ViewerWindow < handle & matlab.mixin.SetGet
    
    properties (Transient)
        Position
        
    end
    
    properties
        GHandle
    end
    
    properties
        WatchList
        Listener
        Dataset
        Preference
        
        MainFigure
        Menu
        Toolbar
        
        Undocked(1,1) struct
        Dock
        Panel
        Resize
        
        Position_
    end
    methods
        loadpreference(obj)
        loaddataset(obj)
        
        createpanel(obj)
        createtoolbar(obj)
        createmenu(obj)
        
        createtime(obj)
        createfrequency(obj)
        createtimefrequency(obj)
        
        activatelistener(obj)
        
        populatetime(obj, src, evnt)
        populatefrequency(obj, src, evnt)
        populatetimefrequency(obj, src, evnt)
        populateprobe(obj)
        populatepreference(obj)
        populateinfo(obj)
        
        setlimtime(obj, src, evnt)
        setlimfrequency(obj, src, evnt)
        setselectedtrack(obj, src, evnt)
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
            obj.WatchList = ViewerWatchList; % Create the watchlist
            
            obj.loadpreference;
            obj.loaddataset;
            
            obj.createmenu;
            obj.createtoolbar;
            obj.createpanel;
            
            obj.activatelistener;
            
            obj.MainFigure.Visible  = 'on';
        end
        
    end
end


