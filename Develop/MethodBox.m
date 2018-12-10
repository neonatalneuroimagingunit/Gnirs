classdef MethodBox < handle & matlab.mixin.SetGet
    
    properties (Transient)
        Position
    end
    
    properties
        Box
        TopB
        BotB
        ArrB
        ArrU
        
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
            set(obj.TopB,'Position',posTB);
            set(obj.BotB,'Position',posBB);
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
            obj.TopB = uicontrol('Style', 'radiobutton','Parent',Par,'Units','normalized',...
                'Position', posTB, 'Callback',@(h,evnt)stop_mooving(h,evnt,obj));
            obj.BotB = uicontrol('Style', 'radiobutton','Parent',Par,'Units','normalized',...
                'Position', posBB, 'Callback',@(h,evnt)line_draw(h,evnt,obj));
        end
    end
    
end

function line_draw(h,~,obj)
    obj.ArrB = BrokenArrow(h.Parent, [h.Position(1:2), h.Position(1:2)]);
    fig = ancestor(h,'Figure');
    fig.CurrentArrow = obj.ArrB;
    fig.WindowButtonMotionFcn = @(h,e)mouse_mooving(h,e,obj);
end

function mouse_mooving(h,~,obj)
    pos = ((h.CurrentPoint./h.Position(3:4))-[0.2, 0])./([0.8, 1]);%sistemare;
    obj.ArrB.Position(3:4) = pos;   
end

function stop_mooving(handle,~,obj)
    fig = ancestor(handle,'Figure');
    fig.WindowButtonMotionFcn = [];
    obj.ArrU = fig.CurrentArrow;
end