classdef MainWindow < handle &  matlab.mixin.SetGet
    
    % Properties that correspond to app components
    properties (Access = public)
        GHandle
        
        UIFigure    matlab.ui.Figure
        FileMenu    matlab.ui.container.Menu
        ExportMenu  matlab.ui.container.Menu
        ImportMenu  matlab.ui.container.Menu
        Menu2       matlab.ui.container.Menu
        Menu3       matlab.ui.container.Menu
        TabGroup    matlab.ui.container.TabGroup
        StudyTab    matlab.ui.container.Tab
        ProbeTab    matlab.ui.container.Tab
        AtlasTab    matlab.ui.container.Tab
        AnatomyAxes      matlab.ui.control.UIAxes
        TrackAxes      matlab.ui.control.UIAxes
        DispPanel      matlab.ui.container.Panel
        InfoPanel       matlab.ui.container.Panel
        
    end
    
    % App initialization and construction
    methods (Access = private)
        
        % Create UIFigure and components
        function createComponents(app)
            
            % Create UIFigure
            app.UIFigure = uifigure('Position',[100 100 800 450],...
                'Name','YottaNIRS');
            
            % Create FileMenu
            app.FileMenu = uimenu(app.UIFigure,...
                'Text','File');
            % Create ExportMenu
            app.ExportMenu = uimenu(app.FileMenu,...
                'Text','Export');
            % Create ImportMenu
            app.ImportMenu = uimenu(app.FileMenu,...
                'Text','Import');
            % Create Menu2
            app.Menu2 = uimenu(app.UIFigure,...
                'Text','Menu2');
            % Create Menu3
            app.Menu3 = uimenu(app.UIFigure,...
                'Text','Menu3');

            % Create Panel3
            app.DispPanel = uipanel(app.UIFigure,...
                'Units','normalized',...
                'Position',[0.2 0 0.8 1]);
            % Create Panel
            app.InfoPanel = uipanel(app.DispPanel,...
                'Visible', 'on',...
                'Units','normalized',...
                'Position',[0 0 0.3 1]);
            % Create UIAxes
            app.AnatomyAxes = uiaxes(app.DispPanel,...
                'Title','Anatomy',...
                'Visible', 'on',...
                'Units','normalized',...
                'Position',[0.3 0 0.7 1]);
            % Create UIAxes
            app.TrackAxes = uiaxes(app.DispPanel,...
                'Title','Tracks',...
                'Visible', 'on',...
                'Units','normalized',...
                'Position',[0.3 0.5 0.7 0.5]);
            
        end
    end
    
    methods (Access = public)
        
        % Construct app
        function obj = MainWindow(GHandle)
            obj.GHandle = GHandle;
            createComponents(obj);
        end
    end
end