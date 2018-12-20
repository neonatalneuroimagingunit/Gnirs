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
        
        populatepreference(obj)
        populatetime(obj)
        
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
            
            obj.createpanel;
            obj.createtoolbar;
            obj.createmenu;
            
            obj.populatepreference;
%             obj.populatetime;
            
            %             viewerfrequency(viewerC, GHandle, vIdx);
            %             viewertimefrequency(viewerC, GHandle, vIdx);
            %
            %             if ~isempty(viewerC.Probe)
            %                 viewerpopulateprobe(viewerC, GHandle, vIdx);
            %             end
            %             viewerpopulateinfo(viewerC, GHandle, vIdx);
            %
            %             %% Activate Listener
            %             GHandle.Viewer(vIdx).Listener.TimePlot = addlistener(GHandle.Viewer(vIdx).WatchList, 'time2Plot', ...
            %                 'PostSet', @(src,evnt)viewerpopulatetime(src, evnt, GHandle, vIdx, viewerC));
            %             GHandle.Viewer(vIdx).Listener.SpectrumPlot = addlistener(GHandle.Viewer(vIdx).WatchList, 'spectrum2Plot', ...
            %                 'PostSet', @(src,evnt)viewerpopulatefrequency(src, evnt,GHandle, vIdx, viewerC));
            %             GHandle.Viewer(vIdx).Listener.TimeFreqPlot = addlistener(GHandle.Viewer(vIdx).WatchList, 'timefreq2Plot', ...
            %                 'PostSet', @(src,evnt)viewerpopulatetimefrequency(src, evnt, GHandle, vIdx, viewerC));
            %             GHandle.Viewer(vIdx).Listener.TimeWindow = addlistener(GHandle.Viewer(vIdx).WatchList, 'timeLim', ...
            %                 'PostSet', @(src,evnt)viewertimesetlim(src,evnt,GHandle, vIdx, viewerC));
            %             GHandle.Viewer(vIdx).Listener.FreqWindow = addlistener(GHandle.Viewer(vIdx).WatchList, 'freqLim', ...
            %                 'PostSet', @(src,evnt)viewerfrequencysetlim(src, evnt, GHandle, vIdx, viewerC));
            %
            %             %% Assign the data to plot and activate the listener
            %             dataIdx = contains(viewerC.Data.Time.Properties.VariableNames ,[viewerC.dataType(1) 'Time']);
            %             GHandle.Viewer(vIdx).WatchList.time2Plot = viewerC.Data.Time(:,dataIdx);
            %             GHandle.Viewer(vIdx).WatchList.spectrum2Plot = viewerC.Data.Frequency(:,dataIdx);
            %
            %             GHandle.Viewer(vIdx).Listener.SelectedLine = addlistener(GHandle.Viewer(vIdx).WatchList, 'edvLine', ...
            %                 'PostSet', @(src,evnt)viewerselectedtrack(src, evnt, GHandle, vIdx, viewerC));
            %
            %             %% Set default splits
            %             GHandle.Viewer(vIdx).mainLayout.Heights = viewerC.defaultHSplit;
            %             GHandle.Viewer(vIdx).PlotInfoLayout.Widths = viewerC.defaultVTopSplit;
            %             GHandle.Viewer(vIdx).ViewLayout.Widths = viewerC.defaultVBotSplit;
            %             movegui(GHandle.Viewer(vIdx).mainFigure, 'center')
            %
            %             %% Turn figure on
            %             GHandle.Viewer(vIdx).mainFigure.Visible  = 'on';
        end
        
    end
end


