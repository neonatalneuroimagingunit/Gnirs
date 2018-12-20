function loaddataset(obj)
%% Load and prepare data for viever
obj.Dataset.Data.Time = obj.GHandle.CurrentDataSet.Data.Time;       % Load Data in Time
obj.Dataset.Data.Frequency = obj.GHandle.CurrentDataSet.Data.Frequency; 
obj.Dataset.Measure = obj.GHandle.CurrentDataSet.Measure;      % Load Measure
obj.Dataset.Analysis = obj.GHandle.CurrentDataSet.Analysis;    % Load Measure
obj.Dataset.Event = obj.GHandle.CurrentDataSet.Measure.Event;  % Load Event
if isempty(obj.GHandle.DataBase.findid(obj.GHandle.CurrentDataSet.Measure.id).probeId)
    obj.Dataset.Probe = [];
else
    obj.Dataset.Probe = obj.GHandle.CurrentDataSet.Probe; % Load Probe
end

obj.Dataset.dataType = obj.GHandle.CurrentDataSet.Measure.InstrumentType.datatype;      %Load Data type
obj.Dataset.updateRate = obj.GHandle.CurrentDataSet.Measure.InstrumentType.UpdateRate;  %Load update rate
% [power, freq] = pspectrum(obj.Dataset.Data.Time{:,2:end}, obj.Dataset.updateRate);      % Calculate The spectrum
% freqTable = array2table([freq, power], ...
%     'VariableNames', [{'Frequency'}, obj.Dataset.Data.Time.Properties.VariableNames(2:end)]);
%  obj.Dataset.Data.Frequency = freqTable;
obj.Dataset.sortingMethod = {'sortnomo', 'wavelength', 'channel'};
obj.WatchList.colorLine = sortingcolors(width(obj.Dataset.Data.Time)-1, obj.Dataset.sortingMethod{1});
end

