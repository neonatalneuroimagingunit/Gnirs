classdef BrokenArrow < handle & matlab.mixin.SetGet
    
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
        
        BoxInput
        BoxOutput
    end
    
    methods
        %         function uistack(obj,varargin)
        %             uistack(obj.HLine1,varargin);
        %             uistack(obj.HLine2,varargin);
        %             uistack(obj.VLine1,varargin);
        %             uistack(obj.VLine2,varargin);
        %             uistack(obj.Arrow1,varargin);
        %         end
        
        function Value = get.Position(obj)
            Value = obj.Position_;
        end
        
        function obj = delete(obj)
            delete(obj.HLine1);
            delete(obj.HLine2);
            delete(obj.VLine1);
            delete(obj.VLine2);
            delete(obj.Arrow1);
            if ~isempty(obj.BoxOutput)
                if length(obj.BoxOutput.ArrowOutput) == 1
                    obj.BoxOutput.ArrowOutput = BrokenArrow.empty;
                elseif length(obj.BoxOutput.ArrowOutput) > 1
                    obj.BoxOutput.ArrowOutput(obj.BoxOutput.ArrowOutput == obj) = [];
                end
            end
            if ~isempty(obj.BoxInput)
                 obj.BoxInput.ArrowInput = BrokenArrow.empty;
            end

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
        function  obj = BrokenArrow(Par,Pos)
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