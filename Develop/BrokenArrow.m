classdef BrokenArrow < handle & matlab.mixin.SetGet
    
    properties (Transient)
        Position
    end
    
    properties
        OrizLine
        VerLine
        Arrow
        
        Position_
    end
    
    methods
        function Value = get.Position(obj)
            Value = obj.Position_;
        end
        function set.Position(obj,Pos)
            obj.Position_ = Pos;
            start = Pos(1:2);
            fin = Pos(3:4);
            hmed = (start(2)+fin(2))/2;
            
            set(obj.OrizLine,'X',[start(1), start(1)],'Y',[start(2), hmed]);
            set(obj.VerLine,'X',[start(1) fin(1)],'Y',[hmed , hmed]);
            set(obj.Arrow,'X',[fin(1), fin(1)],'Y',[hmed, fin(2)]);
        end
        %% constructor
        function  obj = BrokenArrow(Par,Pos)
            start = Pos(1:2);
            fin = Pos(3:4);
            hmed = (start(2)+fin(2))/2;
            
            obj.OrizLine = annotation(Par, 'line',[start(1), start(1)],[start(2), hmed]);
            obj.VerLine = annotation(Par ,'line',[start(1) fin(1)],[hmed , hmed]);
            obj.Arrow = annotation(Par, 'arrow',[fin(1), fin(1)],[hmed, fin(2)]);
            obj.Position_ = Pos;
        end
    end
    
end