classdef MetodWW < handle & matlab.mixin.SetGet
    
    properties (Transient)
        Position
        nMethodBox
    end
    
    properties
        MainFigure
        MethodBoxList(:,1) MethodBox
        Tree
        TreePanel
        MethodPanel
        Divider
        
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
        function  obj = MetodWW
            obj.MainFigure = figure;
            obj.MainFigure.addprop('CurrentArrow');
            
            obj.TreePanel = uipanel('Parent',obj.MainFigure,...
                'Units','normalized','Position',[0 0 0.2 1]);
            obj.MethodPanel = uipanel('Parent',obj.MainFigure,...
                 'Units','normalized','Position',[0.2 0 0.8 1]);
            obj.Tree = uicontrol('Parent',obj.TreePanel,'Units','normalized',...
                'Position',[0.05 0 0.9 0.1],...
                'Style','pushbutton','Callback',@(h,e)add_method(h,e,obj));
        end
    end
    
end

function add_method(~,~,obj)
    obj.MethodBoxList = [obj.MethodBoxList; MethodBox([rand-0.125 rand-0.075 0.25 0.15],obj.MethodPanel)];
end
