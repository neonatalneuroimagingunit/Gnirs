classdef MethodBox < handle & matlab.mixin.SetGet
    
    properties (Transient)
        Position
    end
    
    properties
        Method
        
        Box
        ButtonInput
        ButtonOutput
        ArrowOutput(:,1) BrokenArrow
        ArrowInput BrokenArrow
        
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
            
            if ~isempty(obj.ArrowInput)
                arrowPos = get(obj.ArrowInput, 'Position');
                arrowPos(3:4) = posTB(1:2)+posTB(3:4)/2;
                set(obj.ArrowInput, 'Position', arrowPos);
            end
            if ~isempty(obj.ArrowOutput)
                for iArr = 1 : length(obj.ArrowOutput) % provare a levarloarrow
                    ArrP = get(obj.ArrowOutput(iArr), 'Position');
                    ArrP(1:2) = posBB(1:2) + posBB(3:4)/2;
                    set(obj.ArrowOutput(iArr), 'Position', ArrP);
                end
            end
        end
        %% constructor
        function  obj = MethodBox(Pos,Par,Method)
            obj.Method = Method;
            BtRatio = 0.1;
            BtSize = Pos(3)*BtRatio;
            HPos = Pos(1)+(1-BtRatio)*Pos(3)/2;
            obj.Position = Pos;
            posTB = [HPos, Pos(2)+Pos(4)-BtSize, BtSize, BtSize];
            posBB = [HPos, Pos(2), BtSize, BtSize];
            obj.Box = annotation(Par,'textbox',...
                'Units','normalized',...
                'String',Method.tag,...
                'Position',Pos,...
                'ButtonDownFcn',@(h,evnt)start_moving_box(h,evnt,obj));
            obj.ButtonInput = uicontrol('Style', 'pushbutton','Parent',Par,'Units','normalized',...
                'String', 'o', 'Position', posTB, 'Callback',@(h,evnt)stop_moving(h,evnt,obj));
            obj.ButtonOutput = uicontrol('Style', 'pushbutton','Parent',Par,'Units','normalized',...
                'String', 'o', 'Position', posBB, 'Callback',@(h,evnt)line_draw(h,evnt,obj));
        end
    end
    
end

function line_draw(h,~,obj)
fig = ancestor(h,'Figure');
ArrowHandle = BrokenArrow(h.Parent, [h.Position(1:2) + h.Position(3:4)/2, h.Position(1:2) + h.Position(3:4)/2]);
fig.CurrentArrow = ArrowHandle;
obj.ArrowOutput = [obj.ArrowOutput; ArrowHandle];
ArrowHandle.BoxOutput = obj;
fig.WindowButtonMotionFcn = @(h,e)moving_arrow(h,e,ArrowHandle);
end
function start_moving_box(h,~,obj)
fig = ancestor(h,'Figure');
fig.WindowButtonMotionFcn = @(h,e)moving_box(h,e,obj);
fig.WindowButtonUpFcn = @(h,e)stop_moving_box(h,e);
end
function stop_moving_box(h,~)
h.WindowButtonMotionFcn = [];
h.WindowButtonUpFcn = [];
end
function moving_arrow(h,~,ArrowHandle)
pos = ((h.CurrentPoint./h.Position(3:4))-[0.2, 0])./([0.8, 1]);%sistemare;
ArrowHandle.Position(3:4) = pos;
end
function moving_box(h,~,obj)
pos = ((h.CurrentPoint./h.Position(3:4))-[0.2, 0])./([0.8, 1]);%sistemare;
pos = pos - obj.Position(3:4)/2;
obj.Position(1:2) = pos;
end
function stop_moving(handle,~,obj)
fig = ancestor(handle,'Figure');
fig.WindowButtonMotionFcn = [];
if ~isempty(fig.CurrentArrow)
    if ~isempty(obj.ArrowInput)
        obj.ArrowInput.delete;
    end
    fig.CurrentArrow.BoxInput = obj;
    obj.ArrowInput = fig.CurrentArrow;
    fig.CurrentArrow.Position(3:4) = [obj.ButtonInput.Position(1) + obj.ButtonInput.Position(3)/2, obj.ButtonInput.Position(2) + obj.ButtonInput.Position(4)];
    fig.CurrentArrow = [];
else
    if ~isempty(obj.ArrowInput)
        obj.ArrowInput.delete;
    end
end
end





