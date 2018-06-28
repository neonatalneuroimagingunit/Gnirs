classdef (Sealed) Toolstrip < uiw.abstract.WidgetContainer & ...
        uiw.mixin.HasCallback & dynamicprops
    % Toolstrip - A toolstrip containing groups of push and toggle buttons
    %
    % Create a toolstrip of buttons
    %
    % Syntax:
    %           w = uiw.widget.Toolstrip('Property','Value',...)
    %           addSection(obj,Title)
    %           addButton(obj,Icon,Tag,'Property','Value',...)
    %           addToggleSection(obj,Title)
    %           addToggleButton(obj,Icon,Tag,'Property','Value',...)
    %
    
    % Copyright 2017-2018 The MathWorks, Inc.
    %
    % Auth/Revision:
    %   MathWorks Consulting
    %   $Author: rjackey $
    %   $Revision: 58 $
    %   $Date: 2018-02-27 14:53:00 -0500 (Tue, 27 Feb 2018) $
    % ---------------------------------------------------------------------
    
    
    %% Properties
    properties (AbortSet)
        NewButtonSize double = 40; % Size of new buttons in pixels (default=40)
        NewPanelHeight double = 80; % Height of new sections in pixels (default=80)
    end
    
    properties (Access=private)
        hGroupPanel matlab.ui.container.Panel % The group panel array
        hGroupLabel matlab.ui.control.UIControl % The group label array
        hMinPanelButton matlab.ui.control.UIControl % The minimized panel buttons
        hAllButton matlab.ui.control.UIControl % All toolstrip buttons
        Items = cell(1,0) % Cell array containing each panel's button set
        NumItems double = zeros(1,0) % Number of buttons on each panel
        PWidth double  = zeros(1,0) % Width of each panel
        PMinWidth double = zeros(1,0) % Minimum width of each panel
        Priority double = zeros(1,0) % Priority of each panel to display
        FocusChangedListener % Listener for focus changes
    end
    
    
    
    %% Constructor / Destructor
    methods
        
        function obj = Toolstrip(varargin)
            % Construct the control
            
            % Standards that may be overridden by inputs
            obj.Padding = 6;
            obj.Spacing = 4;
            obj.FontSize = 8;
            obj.ForegroundColor = [1 1 1]*0.2;
            obj.BackgroundColor = [1 1 1]*0.7;
            
            % Populate public properties from P-V input pairs
            obj.assignPVPairs(varargin{:});
            
            % Assign the construction flag
            obj.IsConstructed = true;
            
            % Redraw the widget
            obj.onStyleChanged();
            obj.onEnableChanged();
            obj.redraw();
            obj.onResized();
            
        end %constructor
        
    end %methods - constructor/destructor
    
    
    
    %% Public methods
    methods
        
        function hPanel = addSection(obj,title,varargin)
            % Adds a new section for buttons and/or toggle buttons
            
            hPanel = createSection(obj,title,'Panel',varargin{:});
            
        end %function
        
        
        function hPanel = addToggleSection(obj,title,varargin)
            % Adds a section for toggle buttons
            
            hPanel = createSection(obj,title,'ButtonGroup',varargin{:});
            
        end %function
        
        
        function hButton = addButton(obj,icon,tag,varargin)
            % Adds a normal button to the current section
            
            hButton = createButton(obj,'pushbutton',icon,tag);
            if numel(varargin)
                set(hButton,varargin{:});
            end
            
        end %function
        
        
        function hButton = addToggleButton(obj,icon,tag,varargin)
            % Adds a new toggle button to the current section
            
            hButton = createButton(obj,'togglebutton',icon,tag);
            if numel(varargin)
                set(hButton,varargin{:});
            end
            
        end %function
        
    end %public methods
    
    
    
    %% Protected methods
    methods (Access=protected)
        
        function onResized(obj)
            % Handle changes to widget size
            
            % Ensure the construction is complete
            if obj.IsConstructed
                
                % Get widget dimensions
                [w,~] = obj.getInnerPixelSize;
                
                % Panel sizes
                posP = {obj.hGroupPanel.Position};
                posMPB = {obj.hMinPanelButton.Position};
                if iscell(posP)
                    posP = vertcat(posP{:});
                    posMPB = vertcat(posMPB{:});
                end
                
                % Get panel sizes
                if isempty(posP)
                    return
                else
                    wP = posP(:,3);
                    wMPB = posMPB(:,3);
                end
                
                % Ensure all panels are parented (in rare cases, the popup
                % version of the panel might not be restored)
                for idx=1:numel(obj.hGroupPanel)
                    if ~isequal(obj.hGroupPanel(idx).Parent, obj.hBasePanel)
                        obj.hGroupPanel(idx).Parent = obj.hBasePanel;
                    end
                end
                
                % Position each panel
                %xNext = 1;
                wRem = w;
                needSpace = true(size(obj.hGroupPanel));
                for idx=1:numel(obj.hGroupPanel)
                    
                    % Position next group and minimized button
                    xNext = w - wRem + 1;
                    if any(obj.hGroupPanel(idx).Position(1:2)~=[xNext 1])
                        obj.hGroupPanel(idx).Position(1:2) = [xNext 1];
                        obj.hMinPanelButton(idx).Position(1) = xNext;
                    end
                    
                    % Which other sections are higher priority?
                    needPriority = needSpace & obj.Priority < obj.Priority(idx);
                    
                    % How much space to remaining contents need?
                    wNeed = wP(idx) ...
                        + sum( wP(needPriority) ) ... % Width for smaller button
                        + sum( wMPB(~needPriority & needSpace) ); % Width for full section
                    
                    % Can we fit the full group or just the button?
                    %wNeed = xNext + wP(idx) + sum(wMPB(idx+1:end));
                    if wNeed < wRem
                        if ~strcmp(obj.hGroupPanel(idx).Visible,'on')
                            if ~isequal(obj.hGroupPanel(idx).Parent,obj.hBasePanel)
                                obj.hGroupPanel(idx).Parent = obj.hBasePanel;
                            end
                            obj.hGroupPanel(idx).Visible = 'on';
                            obj.hMinPanelButton(idx).Visible = 'off';
                        end
                        wRem = wRem - wP(idx);
                    else
                        if ~strcmp(obj.hGroupPanel(idx).Visible,'off')
                            obj.hGroupPanel(idx).Visible = 'off';
                            obj.hMinPanelButton(idx).Visible = 'on';
                        end
                        wRem = wRem - wMPB(idx);
                    end
                    
                    % Mark this one complete
                    needSpace(idx) = false;
                    
                    
                end %for idx=1:numel(obj.hGroupPanel)
                
            end %if obj.IsConstructed && strcmp(obj.Visible,'on')
            
        end %function
        
        
        function onEnableChanged(obj,~)
            % Handle updates to Enable state
            
            % Ensure the construction is complete
            if obj.IsConstructed
                
                hEnableGroup = [obj.hMinPanelButton,obj.hAllButton];
                set(hEnableGroup,'Enable',obj.Enable);
                
            end %if obj.IsConstructed
            
        end %function
        
        
        function onVisibleChanged(obj)
            % Handle updates to Visible state
            
            % Ensure the construction is complete
            if obj.IsConstructed
                
                % Resize when visible is turned on
                if strcmp(obj.Visible,'on')
                    obj.onStyleChanged();
                    obj.onResized();
                end
                
            end %if obj.IsConstructed
            
        end %function
        
        
        function onStyleChanged(obj,~)
            % Handle updates to style changes
            
            % Ensure the construction is complete
            if obj.IsConstructed && strcmp(obj.Visible,'on')
                
                % Update styles of most items
                hStyleGroup = [obj.hGroupPanel, obj.hMinPanelButton,...
                    obj.hAllButton, obj.hGroupLabel, obj.hBasePanel];
                set(hStyleGroup,...
                    'ForegroundColor',obj.ForegroundColor,...
                    'BackgroundColor',obj.BackgroundColor,...
                    'FontName',obj.FontName,...
                    'FontWeight',obj.FontWeight,...
                    'FontAngle',obj.FontAngle,...
                    'FontUnits',obj.FontUnits,...
                    'FontSize',obj.FontSize);
                
                % Label background is slightly off from other background,
                % and height is 4px higher than the font (Note: 3pt=4px)
                hL = obj.FontSize * 4/3 + 4;
                bgLabel = min((obj.BackgroundColor * 1.1), 1);
                set(obj.hGroupLabel,'BackgroundColor',bgLabel)
                for idx=1:numel(obj.hGroupLabel)
                    obj.hGroupLabel(idx).Position(4) = hL;
                end
                
                % Draw the down arrow on min size buttons
                if ~isempty(obj.hMinPanelButton)
                    startRow = 45;
                    nRow = 6;
                    cData = nan(50,2*nRow,3);
                    for idx=1:nRow
                        rIdx = idx + startRow - 1;
                        cData(rIdx,idx:(end-idx+1),1) = obj.ForegroundColor(1);
                        cData(rIdx,idx:(end-idx+1),2) = obj.ForegroundColor(2);
                        cData(rIdx,idx:(end-idx+1),3) = obj.ForegroundColor(3);
                    end
                    set(obj.hMinPanelButton,'CData',cData);
                end
                
            end %obj.IsConstructed && strcmp(obj.Visible,'on')
        end %function
        
    end %methods
    
    
    
    %% Private methods
    methods (Access=private)
        
        function [hPanel,hLabel] = createSection(obj,title,type,priority)
            
            % Sizing info
            pad = obj.Padding;
            % Find min width. Assume number of pixels per character
            pxPerChar = 8;
            pMinPad = 6;
            wMin = pxPerChar * numel(title) + pMinPad;
            hP = obj.NewPanelHeight - 1;
            
            % Create the empty panel
            hPanel = matlab.ui.container.(type)(...
                'Parent', obj.hBasePanel,...
                'HandleVisibility','on',... %must be on for figure CurrentObject
                'Units', 'pixels',...
                'Position',[1 1 pad hP],...
                'BorderWidth',2,...
                'BorderType','beveledout');
            
            hLabel = matlab.ui.control.UIControl(...
                'Parent', hPanel,...
                'HandleVisibility','on',... %must be on for figure CurrentObject
                'HitTest','off',...
                'Enable','inactive',...
                'Style','text',...
                'Units', 'pixels',...
                'Position',[1 1 pad 15],...
                'HorizontalAlignment','center',...
                'String', title);
            
            % Size panel from InnerPosition
            posInP = hPanel.InnerPosition;
            posOutP = hPanel.OuterPosition;
            wAdj = posOutP(3) - posInP(3);
            hPanel.Position(3) = pad + wAdj;
            
            % Create the button, when width is too narrow
            hButton = matlab.ui.control.UIControl(...
                'Parent', obj.hBasePanel,...
                'HandleVisibility','off',...
                'Style','pushbutton',...
                'Units', 'pixels',...
                'Position',[1 1 wMin hP],...
                'String', title,...
                'Visible','off',...
                'Callback',@(h,e)onPanelButtonPressed(obj,h,e) );
            
            % Add the panel to the list
            obj.hGroupPanel(end+1) = hPanel;
            obj.hGroupLabel(end+1) = hLabel;
            obj.hMinPanelButton(end+1) = hButton;
            obj.Items{end+1} = matlab.graphics.GraphicsPlaceholder.empty(1,0);
            obj.NumItems(end+1) = 0;
            obj.PWidth(end+1) = 0;
            obj.PMinWidth(end+1) = wMin;
            if nargin<4
                priority = 10;
            end
            obj.Priority(end+1) = priority;
            
            % Resize now or later?
            if strcmp(obj.Visible,'on')
                obj.onStyleChanged();
                obj.onResized();
            end
            
        end %function
        
        
        function hButton = createButton(obj,Style,Icon,Tag)
            
            % Which panel are we adding to?
            if isempty(obj.hGroupPanel)
                [hPanel,hLabel] = obj.addSection('');
            else
                hPanel = obj.hGroupPanel(end);
                hLabel = obj.hGroupLabel(end);
            end
            
            % Get sizing info
            pad = obj.Padding;
            spc = obj.Spacing;
            wB = obj.NewButtonSize;
            hB = wB;
            posInP = hPanel.InnerPosition;
            posOutP = hPanel.OuterPosition;
            
            % Calculate positions
            wP = hPanel.InnerPosition(3);
            xB = wP - pad + spc + 1;
            yB = posInP(4)-pad-hB;
            wNewP = xB + wB - 1 + pad;
            posB = [xB yB wB hB];
            
            % Size the panel
            wAdj = posOutP(3) - posInP(3);
            hPanel.Position(3) = wNewP + wAdj;
            hLabel.Position(3) = wNewP + wAdj;
            
            % Move the label
            
            % Load the icon
            CData = uiw.utility.loadIcon(Icon);
            
            % Create a button
            hButton = uicontrol(...
                'Parent', hPanel,...
                'HandleVisibility','on',... %must be on for figure CurrentObject
                'Style', Style,...
                'Callback', @(h,e)onButtonPressed(obj,h,e),...
                'Units', 'pixels',...
                'Position',posB,...
                'Tag',Tag,...
                'CData', CData);
            
            % Add the button to the list
            obj.hAllButton(end+1) = hButton;
            if obj.NumItems(end)
                obj.Items{end}(end+1) = hButton;
            else
                obj.Items{end} = hButton;
            end
            obj.NumItems(end) = obj.NumItems(end) + 1;
            
            % Add the button's tag as a dynamicprop
            ExcludedTags = properties(obj);
            Tag = matlab.lang.makeUniqueStrings(Tag,ExcludedTags);
            addprop(obj,Tag);
            obj.(Tag) = hButton;
            
            % Resize now or later?
            if strcmp(obj.Visible,'on')
                obj.onStyleChanged();
                obj.onResized();
            end
            
        end %function
        
        
        function onPanelButtonPressed(obj,h,~)
            
            % Which panel?
            idxP = (obj.hMinPanelButton == h);
            hPanel = obj.hGroupPanel(idxP);
            hFig = ancestor(hPanel,'figure');
            
            % Where are things located now?
            bPos = getpixelposition(h,true);
            pPos = hPanel.Position;
            
            % Calculate panel dropdown position within the figure
            pos = [bPos(1) (bPos(2)-pPos(4)) pPos(3) pPos(4)];
            wFig = hFig.Position(3);
            xAdj = wFig - (pos(1)+pos(3));
            if xAdj<0
                % Move left to fit in window
                pos(1) = pos(1) + xAdj;
            end
            
            % Now, position and show the panel as a dropdown
            hPanel.Parent = hFig;
            setpixelposition(hPanel,pos,true);
            hPanel.Visible = 'on';
            
            % Listen for focus changes in figure, to know when to remove
            % the dropdown panel
            obj.FocusChangedListener = event.proplistener(hFig,...
                findprop(hFig,'CurrentObject'),...
                'PostSet',@(h,e)onFocusChanged(obj,hPanel));
            
        end %function
        
        
        function onFocusChanged(obj,hPanel)
            
            % Was the click on something other than the panel?
            hFig = ancestor(hPanel,'figure');
            hFocusObj = hFig.CurrentObject;
            hPanelObj = [hPanel; hPanel.Children];
            inPanel = isscalar(hFocusObj) && any(hFocusObj==hPanelObj);
            
            % Only close here if the click was not within the panel. If it
            % was in the panel, the button press will close it.
            if ~inPanel
                obj.closePanel(hPanel);
            end
            
        end %function
        
        
        function onButtonPressed(obj,h,evt)
            
            % Is the button on a pulldown panel? If so, close the panel.
            obj.closePanel(h.Parent);
            
            % Prepare event data
            evt = struct(...
                'Source',obj,...
                'Control',evt.Source,...
                'Interaction',evt.Source.Tag);
            
            % Call the callback
            obj.callCallback(evt);
            
        end %function
        
        
        function closePanel(obj,hPanel)
            % If the panel is a pull down, it will be parented to the
            % figure rather than it's base panel. In that case, close it by
            % hiding and reparenting to the base panel
            if (hPanel.Parent~=obj.hBasePanel)
                set(hPanel,...
                    'Visible','off',...
                    'Parent',obj.hBasePanel );
                obj.FocusChangedListener = [];
            end
        end %function
        
    end %methods
    
    
    
    %% Get/Set methods
    methods
        
        % NewButtonSize
        function set.NewButtonSize(obj,value)
            uiw.utility.validatePosIntScalar(value);
            obj.NewButtonSize = value;
        end
        
        % NewPanelHeight
        function set.NewPanelHeight(obj,value)
            uiw.utility.validatePosIntScalar(value);
            obj.NewPanelHeight = value;
        end
        
    end % Get/Set methods
    
    
end %classdef