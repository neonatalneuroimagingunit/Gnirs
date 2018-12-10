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
        InfoSetPanel
        MethodPanel
        Divider
        ResizeButton1
        ResizeButton2
        
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
            obj.MainFigure = figure('Position', [100 100 1200 600]); % cambiare con g handle
            obj.MainFigure.addprop('CurrentArrow');
            
            obj.TreePanel = uipanel('Parent',obj.MainFigure,...
                'Units','normalized','Position',[0 0 0.2 1]);
            obj.MethodPanel = uipanel('Parent',obj.MainFigure,...
                'Units','normalized','Position',[0.21 0 0.59 1]);
            obj.InfoSetPanel = uipanel('Parent',obj.MainFigure,...
                'Units','normalized','Position',[0.81 0 0.2 1]);
            obj.Tree = MethodTree([ 0 0 1 1 ],obj.TreePanel,MethodList);
            obj.Tree.Root.MouseClickedCallback = @(h,e)add_method(h,e,obj);
            
            obj.ResizeButton1 = annotation(obj.MainFigure,'textbox','Units','normalized','Position',[0.2 0 0.01 1],'ButtonDownFcn' ,@(h,e)resize_1(h,e,obj));
            obj.ResizeButton2 = annotation(obj.MainFigure,'textbox','Units','normalized','Position',[0.8 0 0.01 1],'ButtonDownFcn' ,@(h,e)resize_2(h,e,obj));
            
            
            InputMethod = NirsMethod('tag', 'Input');
            obj.MethodBoxList = MethodBox([0.4 0.8 0.16 0.08],obj.MethodPanel,InputMethod); %sistemare inputmethod
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
            if ~isempty(method2Add)
                obj.MethodBoxList = [obj.MethodBoxList; MethodBox([rand-0.08 rand-0.04 0.16 0.08],obj.MethodPanel,method2Add)];
            end
        case 'alt' %dxstudy
    end
end
end

function resize_1(~, ~, obj)
obj.MainFigure.WindowButtonMotionFcn = @(h,e)panel_resizing1(h,e,obj);
obj.MainFigure.WindowButtonUpFcn = @(h,e)stop_resizing(h,e);
end
function panel_resizing1(h,~,obj)
relXPos = h.CurrentPoint(1)./h.Position(3);
obj.TreePanel.Position(3) = relXPos - 0.005;
obj.ResizeButton1.Position(1) = relXPos - 0.005;
obj.MethodPanel.Position(1) = relXPos + 0.005;
obj.MethodPanel.Position(3) = obj.ResizeButton2.Position(1) - obj.MethodPanel.Position(1);
end

function resize_2(~,~, obj)
obj.MainFigure.WindowButtonMotionFcn = @(h,e)panel_resizing2(h,e,obj);
obj.MainFigure.WindowButtonUpFcn = @(h,e)stop_resizing(h,e);
end
function panel_resizing2(h,~,obj)
relXPos = h.CurrentPoint(1)./h.Position(3);
obj.InfoSetPanel.Position(1) = relXPos + 0.005;
obj.InfoSetPanel.Position(3) = 1 - obj.InfoSetPanel.Position(1);
obj.ResizeButton2.Position(1) = obj.InfoSetPanel.Position(1) - 0.01;
obj.MethodPanel.Position(3) = obj.ResizeButton2.Position(1) - obj.MethodPanel.Position(1);
end

function stop_resizing(h,~)
h.WindowButtonMotionFcn = [];
h.WindowButtonUpFcn = [];
end

