function evaluatemethod(obj, ~,~)
methodflow = obj.createflow;
dataIn = obj.TempAnalysis.Data.Time;
methodflow(cellfun('isempty',methodflow)) = [];
for iMethodFlow = 1:1:length(methodflow) % per ogni flow applico tutti tutti i metodi
    MethodFlow = methodflow{iMethodFlow};
    for iMethod = 1:1:length(MethodFlow)
        CurrentMethod = MethodFlow(iMethod);
        dataOut = CurrentMethod.methodFunction(dataIn, CurrentMethod.Parameters);
        dataIn = dataOut;
    end
    
    NewAnalysis =  obj.TempAnalysis.Analysis; %% modify analysis data
    NewAnalysis.date = datetime;
    NewAnalysis.id = [];
    NewAnalysis.MethodList = [NewAnalysis.MethodList ; MethodFlow];
    % create symple data
    dataType2Save = 'DC';
    columns2Save = contains(dataOut.Properties.VariableNames',dataType2Save);
    columns2Save(1) = true;
    if (size(dataOut.Time,1)>500)
        idx = round(linspace(1,size(dataOut.Time,1), 500));
        SimplyData = dataOut(idx,columns2Save);
    else
        SimplyData = dataOut(:,columns2Save);
    end
    NewAnalysis.SimplyData = SimplyData;
    DataBase = obj.GHandle.DataBase.add(NewAnalysis); % add to database
    obj.GHandle.DataBase = DataBase;
    
    % add data to database
    Data.Time = dataOut;
    updateRate = obj.TempAnalysis.Measure.InstrumentType.UpdateRate;  %Load update rate
    [power, freq] = pspectrum(Data.Time{:,2:end}, updateRate);      % Calculate The spectrum
    freqTable = array2table([freq, power], ...
        'VariableNames', [{'Frequency'}, Data.Time.Properties.VariableNames(2:end)]);
    Data.Frequency = freqTable;
    path = DataBase.Analysis(end).path;%add to the database
    if ~isempty(Data)
        save(path,'Data','-append')
    end   
end

tree(obj.GHandle);
close(obj.MainFigure);
end

