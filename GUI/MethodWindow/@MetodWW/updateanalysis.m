function updateanalysis(obj, dataOut, MethodFlow)
dataType2Save = 'DC';

%% modify analysis data and add the method list
NewAnalysis =  obj.AnalysisData.Analysis; 
NewAnalysis.date = datetime;
NewAnalysis.id = [];
NewAnalysis.MethodList = [NewAnalysis.MethodList ; MethodFlow];

%% create symple data 
columns2Save = contains(dataOut.Properties.VariableNames',dataType2Save);
columns2Save(1) = true;
if (size(dataOut.Time,1)>500)
    idx = round(linspace(1,size(dataOut.Time,1), 500));
    SimplyData = dataOut(idx,columns2Save);
else
    SimplyData = dataOut(:,columns2Save);
end
NewAnalysis.SimplyData = SimplyData;

%% add to database
DataBase = obj.GHandle.DataBase.add(NewAnalysis); 

% calculate the pspectrum
Data.Time = dataOut;
updateRate = obj.AnalysisData.Measure.InstrumentType.UpdateRate;  %Load update rate
[power, freq] = pspectrum(Data.Time{:,2:end}, updateRate);      
freqTable = array2table([freq, power], ...
    'VariableNames', [{'Frequency'}, Data.Time.Properties.VariableNames(2:end)]);
Data.Frequency = freqTable;

path = DataBase.Analysis(end).path; %save
save(path,'Data','-append')

obj.GHandle.DataBase = DataBase;% refresh tree
tree(obj.GHandle);
end

