classdef MetodWW < handle & matlab.mixin.SetGet
    
    properties (Transient)
        Position
        nMethodBox
    end
    
    properties
        MethodList
        
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
        function  obj = MetodWW(MethodList)
            obj.MethodList = MethodList;
            obj.MainFigure = figure;
            obj.MainFigure.addprop('CurrentArrow');
            
            obj.TreePanel = uipanel('Parent',obj.MainFigure,...
                'Units','normalized','Position',[0 0 0.2 1]);
            obj.MethodPanel = uipanel('Parent',obj.MainFigure,...
                'Units','normalized','Position',[0.2 0 0.8 1]);
            obj.Tree = MethodTree([ 0 0 1 1 ],obj.TreePanel,MethodList);
            obj.Tree.Root.MouseClickedCallback = @(h,e)add_method(h,e,obj);
            
            InputMethod = NirsMethod('tag', 'Input');
            obj.MethodBoxList = MethodBox([0.4 0.8 0.25 0.15],obj.MethodPanel,InputMethod); %sistemare inputmethod
            obj.MethodBoxList.ButtonInput.Visible = 'off';
        end
    end
    
end

function add_method(~, Event, obj)
if ~isempty(Event.Nodes) % click on a node
    switch Event.SelectionType 
        case 'normal' %displaymethod
        case 'open'
            methodIdx = strcmp({obj.MethodList.tag}, Event.Nodes.Value);
            method2Add = obj.MethodList(methodIdx);
            obj.MethodBoxList = [obj.MethodBoxList; MethodBox([rand-0.125 rand-0.075 0.25 0.15],obj.MethodPanel,method2Add)];
        case 'alt' %dxstudy
    end
end
end

