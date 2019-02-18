function evaluatemethod(obj, ~,~)
methodflow = obj.createflow;
methodflow(cellfun('isempty',methodflow)) = [];
dataOut = [];

for iMethodFlow = 1:1:length(methodflow) % per ogni flow applico tutti tutti i metodi
    MethodFlow = methodflow{iMethodFlow};
    
    for iMethod = 1:1:length(MethodFlow)
        CurrentMethod = MethodFlow(iMethod);
        [dataIn, Parameters] = obj.checkandsetparameters(CurrentMethod, dataOut);
        
        dataOut = CurrentMethod.methodFunction(dataIn, Parameters);
    end
    
    obj.updateanalysis(dataOut, MethodFlow);
 
end

close(obj.MainFigure);
end

