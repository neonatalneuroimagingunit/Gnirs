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
        UIAxes      matlab.ui.control.UIAxes
        DispPanel      matlab.ui.container.Panel
        InfoPanel       matlab.ui.container.Panel

    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 800 450];
            app.UIFigure.Name = 'UI Figure';

            % Create FileMenu
            app.FileMenu = uimenu(app.UIFigure);
            app.FileMenu.Text = 'File';

            % Create ExportMenu
            app.ExportMenu = uimenu(app.FileMenu);
            app.ExportMenu.Text = 'Export';

            % Create ImportMenu
            app.ImportMenu = uimenu(app.FileMenu);
            app.ImportMenu.Text = 'Import';

            % Create Menu2
            app.Menu2 = uimenu(app.UIFigure);
            app.Menu2.Text = 'Menu2';

            % Create Menu3
            app.Menu3 = uimenu(app.UIFigure);
            app.Menu3.Text = 'Menu3';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 1 178 450];

            % Create StudyTab
            app.StudyTab = uitab(app.TabGroup);
            app.StudyTab.Title = 'Study';

            % Create ProbeTab
            app.ProbeTab = uitab(app.TabGroup);
            app.ProbeTab.Title = 'Probe';

            % Create AtlasTab
            app.AtlasTab = uitab(app.TabGroup);
            app.AtlasTab.Title = 'Atlas';

            % Create Panel3
            app.DispPanel = uipanel(app.UIFigure);
            app.DispPanel.Title = 'DispPanel';
            app.DispPanel.Position = [178 2 623 449];

            % Create UIAxes
            app.UIAxes = uiaxes(app.DispPanel);
            title(app.UIAxes, 'Title')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            app.UIAxes.Position = [211 1 375 424];

            % Create Panel
            app.InfoPanel = uipanel(app.DispPanel);
            app.InfoPanel.Position = [1 0 211 425];
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