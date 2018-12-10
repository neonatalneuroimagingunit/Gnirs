classdef MethodBox < handle & matlab.mixin.SetGet
    
    properties (Transient)
        Position
    end
    
    properties
        Box
        ButtonInput
        ButtonOutput
        ArrowOutput
        ArrowInput
        
        Position_
    end
    
    methods
        function Value = get.Position(obj)
            Value = obj.Position_;
        end
        function set.Position(obj,Pos)
            obj.Position_ = Pos;
            BtRatio = 0.1;
            
            BtSize = Pos(3)*BtRatio;
            HPos = Pos(1)+(1-BtRatio)*Pos(3)/2;
            posTB = [HPos, Pos(2)+Pos(4)-BtSize, BtSize, BtSize];
            posBB = [HPos, Pos(2), BtSize, BtSize];
            
            set(obj.Box,'Position',Pos);
            set(obj.ButtonInput,'Position',posTB);
            set(obj.ButtonOutput,'Position',posBB);
        end
        %% constructor
        function  obj = MethodBox(Pos,Par)
            BtRatio = 0.1;
            BtSize = Pos(3)*BtRatio;
            HPos = Pos(1)+(1-BtRatio)*Pos(3)/2;
            obj.Position = Pos;
            posTB = [HPos, Pos(2)+Pos(4)-BtSize, BtSize, BtSize];
            posBB = [HPos, Pos(2), BtSize, BtSize];
            obj.Box = annotation(Par,'textbox','Units','normalized','Position',Pos);
            obj.ButtonInput = uicontrol('Style', 'pushbutton','Parent',Par,'Units','normalized',...
                'String', 'o', 'Position', posTB, 'Callback',@(h,evnt)stop_mooving(h,evnt,obj));
            obj.ButtonOutput = uicontrol('Style', 'pushbutton','Parent',Par,'Units','normalized',...
                'String', 'o', 'Position', posBB, 'Callback',@(h,evnt)line_draw(h,evnt,obj));
        end
    end
    
end

function line_draw(h,~,obj)
    obj.ArrowOutput = BrokenArrow(h.Parent, [h.Position(1:2) + h.Position(3:4)/2, h.Position(1:2) + h.Position(3:4)/2]);
    fig = ancestor(h,'Figure');
    fig.CurrentArrow = obj.ArrowOutput;
    fig.WindowButtonMotionFcn = @(h,e)mouse_mooving(h,e,obj);
end

function mouse_mooving(h,~,obj)
    pos = ((h.CurrentPoint./h.Position(3:4))-[0.2, 0])./([0.8, 1]);%sistemare;
    obj.ArrowOutput.Position(3:4) = pos;   
end

function stop_mooving(handle,~,obj)
    fig = ancestor(handle,'Figure');
    fig.WindowButtonMotionFcn = [];
    obj.ArrowInput = fig.CurrentArrow;
    fig.CurrentArrow.Position(3:4) = [obj.ButtonInput.Position(1) + obj.ButtonInput.Position(3)/2, obj.ButtonInput.Position(2) + obj.ButtonInput.Position(4)];
end