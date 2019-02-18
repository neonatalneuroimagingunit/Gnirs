function [dataIn, Parameters] = checkandsetparameters(obj, CurrentMethod, dataOut)

if ~isempty(dataOut)   %% cambiarlo deve dipendere dall metodo
    dataIn = dataOut;
else
    dataIn = obj.AnalysisData.Data.Time;
end
    
Parameters = CurrentMethod.Parameters; %quelli che ci sono gia restano altimenti metto quelli ricavati dai metadati
end

