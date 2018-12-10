classdef BrokenArrow2 < handle & matlab.mixin.SetGet
    
    properties (Transient)
        Position
    end
    
    properties
        HLine1
        HLine2
        VLine1
        VLine2
        Arrow1
        
        Position_
    end
    
    methods
        function Value = get.Position(obj)
            Value = obj.Position_;
        end
        function set.Position(obj,Pos)
                       p1 = Pos(1:2);
            p2 = Pos(3:4);
            pM = (p1+p2) ./ 2;
            
            vshift = 0.05;
            z1 = [p1(1) min(pM(2), p1(2)-vshift)];
            z2 = [pM(1) z1(2)];
            z4 = [p2(1) max(pM(2), p2(2)+vshift)];
            z3 = [pM(1) z4(2)];

            set(obj.VLine1, 'X', [p1(1) z1(1)], 'Y',[p1(2) z1(2)]);
            set(obj.HLine1, 'X', [z1(1) z2(1)], 'Y',[z1(2) z2(2)]);
            set(obj.VLine2, 'X', [z2(1) z3(1)], 'Y',[z2(2) z3(2)]);
            set(obj.HLine2, 'X', [z3(1) z4(1)], 'Y',[z3(2) z4(2)]);
            set(obj.Arrow1, 'X', [z4(1) p2(1)], 'Y',[z4(2) p2(2)]);
            obj.Position_ = Pos;
            
        end
        %% constructor
        function  obj = BrokenArrow2(Par,Pos)
            p1 = Pos(1:2);
            p2 = Pos(3:4);
            pM = (p1+p2) ./ 2;
            
            vshift = 0.05;
            z1 = [p1(1) min(pM(2), p1(2)-vshift)];
            z2 = [pM(1) z1(2)];
            z4 = [p2(1) max(pM(2), p2(2)+vshift)];
            z3 = [pM(1) z4(2)];
            
            obj.VLine1 = annotation(Par ,'line',  [p1(1) z1(1)], [p1(2) z1(2)]);
            obj.HLine1 = annotation(Par, 'line',  [z1(1) z2(1)], [z1(2) z2(2)]);
            obj.VLine2 = annotation(Par ,'line',  [z2(1) z3(1)], [z2(2) z3(2)]);
            obj.HLine2 = annotation(Par, 'line',  [z3(1) z4(1)], [z3(2) z4(2)]);
            obj.Arrow1 = annotation(Par, 'arrow', [z4(1) p2(1)], [z4(2) p2(2)]);
            obj.Position_ = Pos;
            
        end
    end
    
end