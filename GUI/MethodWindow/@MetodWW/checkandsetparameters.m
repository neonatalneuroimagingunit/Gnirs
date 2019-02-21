function [dataIn, Parameters] = checkandsetparameters(obj, CurrentMethod, dataOut)

if ~isempty(dataOut)   %% cambiarlo deve dipendere dall metodo
    dataIn = dataOut;
else
    dataIn = obj.AnalysisData.Data.Time;
end
ParameterList = fieldnames(CurrentMethod.Parameters);
for paramName = ParameterList'
    switch lower(paramName{1})
        case 'event'
            TempParam.(paramName{1}) = obj.AnalysisData.Measure.Event;
        otherwise
            TempParam.(paramName{1}) = CurrentMethod.Parameters.(paramName{1});
    end
end
Parameters = TempParam;
end

