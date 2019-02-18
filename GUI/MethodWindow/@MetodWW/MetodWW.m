classdef MetodWW < handle & matlab.mixin.SetGet
    
    properties (Transient)
        Position
        nMethodBox
    end
    
    properties
        MethodList
        GHandle
        AnalysisData
        
        
        MainFigure
        MethodBoxList(:,1) MethodBox
        Tree
        TreePanel
        InfoSetPanel
        InfoSetPanelUp
        InfoSetPanelDown
        InfoSetAxes
        MethodPanel
        ResizeButton1
        ResizeButton2
        
        EvaluateMethodButton
        AddOutputButton
        
        Position_
    end
    
    methods
        flow = createflow(obj);
        sortmethod(obj);
        evaluatemethod(obj,h,e);
        finddata(obj, analysisId);
        generatewindow(obj);
        [dataIn, Parameters] = checkandsetparameters(obj, CurrentMethod, dataOut);
        updateanalysis(obj, dataOut, MethodFlow);
        
        
        function Value = get.Position(obj)
            Value = obj.Position_;
        end
        function set.Position(obj,Pos)
            obj.Position_ = Pos;
        end
        %% Constructor
        function  obj = MetodWW(MethodList , GHandle, analysisId)

            obj.GHandle = GHandle;
            obj.MethodList = MethodList; 
            
            obj.finddata(analysisId);
            
            obj.generatewindow;
            

        end
        
    end
    
end
