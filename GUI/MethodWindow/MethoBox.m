classdef MethoBox < handle & matlab.mixin.SetGet
    
    properties (Transient)
        parent
        Position
        methodString = ''
        methodTag = ''
    end
    
    properties (Hidden)
        OutputBtn = uipanel;
        InputBtn = uicontrol;
        Text = uicontrol;
        
        parentH
        PositionH = [0 0 1 1]
    end
    
    methods
        %% set prop
        function set.Position(obj,value)
            obj.Panel.Position = value;
            obj.PositionH = value;
        end
        function set.parent(obj,value)
            [obj.Label.Position, obj.Text.Position] = spacing_text(obj.parent,obj.Position,obj.configuration,value,obj.sizeratio,obj.textHeight);
            obj.parentH = value;
        end
        function set.labelString(obj,value)
            obj.Label.String = value;
        end
        function set.textString(obj,value)
            obj.Text.String = value;
        end
        function set.spacing(obj,value)
            [obj.Label.Position, obj.Text.Position] = spacing_text(obj.parent,obj.Position,obj.configuration,value,obj.sizeratio,obj.textHeight);
            obj.spacingH = value;
        end
        function set.sizeratio(obj,value)
            [obj.Label.Position, obj.Text.Position] = spacing_text(obj.parent,obj.Position,obj.configuration,obj.spacing,value,obj.textHeight);
            obj.sizeratioH = value;
        end
        function set.BackgroundColor(obj,value)
            obj.Panel.BackgroundColor = value;
        end
        function set.TextBackgroundColor(obj,value)
            obj.Text.BackgroundColor = value;
        end
        function set.LabelBackgroundColor(obj,value)
            obj.Label.BackgroundColor = value;
        end
        function set.configuration(obj,value)
            [obj.Label.Position, obj.Text.Position] = spacing_text(obj.parent,obj.Position,value,obj.spacing,obj.sizeratio,obj.textHeight);
            obj.configurationH = value;
        end
        function set.texttype(obj,value)
            obj.Text.Style = value;
        end
        function set.textHeight(obj,value)
            [obj.Label.Position, obj.Text.Position] = spacing_text(obj.parent,obj.Position,obj.configuration,obj.spacing,obj.sizeratio,value);
            obj.textHeightH = value;
        end
        function set.callback(obj,value)
            obj.Text.Callback = value;
        end
        
        %% get prop
        function value = get.Position(obj)
            value = obj.Panel.Position;
        end
        function value = get.parent(obj)
            value = obj.parentH;
        end
        function value = get.labelString(obj)
            value = obj.Label.String;
        end
        function value = get.textString(obj)
            value = obj.Text.String;
        end
        function value = get.spacing(obj)
            value = obj.spacingH;
        end
        function value = get.sizeratio(obj)
            value = obj.sizeratioH;
        end
        function value = get.BackgroundColor(obj)
            value =  obj.Panel.BackgroundColor;
        end
        function value = get.TextBackgroundColor(obj)
            value = obj.Text.BackgroundColor;
        end
        function value = get.LabelBackgroundColor(obj)
            value = obj.Label.BackgroundColor;
        end
        function value = get.configuration(obj)
            value = obj.configurationH;
        end
        function value = get.texttype(obj)
            value = obj.Text.Style;
        end
        function value = get.textHeight(obj)
            value = obj.textHeightH;
        end
        function value = get.callback(obj)
            value = obj.Text.Callback;
        end
        
        %% constructor
        function  obj = gtextedit(varargin)
            callback = [];
            texttype = 'text';
            
            for i = 1 : 2 : nargin
                switch lower(varargin{i})
                    case 'parent'
                        obj.parentH = varargin{i+1};
                    case 'position'
                        obj.PositionH = varargin{i+1};
                    case 'label'
                        labelString = varargin{i+1};
                    case 'text'
                        textString = varargin{i+1};
                    case 'spacing'
                        obj.spacingH = varargin{i+1};
                    case 'callback'
                        callback = varargin{i+1};
                    case 'sizeratio'
                        obj.sizeratioH = varargin{i+1};
                    case 'textheight'
                        obj.textHeightH = varargin{i+1};
                    case 'configuration'
                        obj.configurationH = varargin{i+1};
                    case 'texttype'
                        texttype = varargin{i+1};
                    otherwise
                        warning(['field ' varargin{i} ' not found'])
                end
            end
            
            [positionLabel, positionText] = spacing_text(obj.parentH,obj.PositionH,obj.configurationH,obj.spacingH,obj.sizeratioH,obj.textHeightH);
            LabelBackgroundColor = 'r';
            TextBackgroundColor = 'b';
            obj.Panel = uipanel(...
                'Parent', obj.parentH,...
                'Units', 'normalize', ...
                'BorderType', 'none', ...
                'Position', obj.PositionH);
            
            
            obj.Label = uicontrol('Style', 'text',...
                'Parent', obj.Panel, ...
                'String', labelString,...
                'BackgroundColor',LabelBackgroundColor,...
                'Visible','on',...
                'Units', 'normalize', ...
                'HorizontalAlignment', 'left', ...
                'Position',positionLabel);
            
            obj.Text = uicontrol('Style', texttype,...
                'Parent', obj.Panel, ...
                'String', textString,...
                'BackgroundColor',TextBackgroundColor,...
                'Visible','on',...
                'Callback',callback,...
                'Units', 'normalize', ...
                'HorizontalAlignment', 'left', ...
                'Position',positionText);
        end
    end
    
end


end