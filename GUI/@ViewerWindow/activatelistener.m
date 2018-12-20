function activatelistener(obj)


obj.Listener.TimePlot = addlistener(obj.WatchList, 'time2Plot', ...
    'PostSet', @(src,evnt)obj.populatetime(src, evnt));
obj.Listener.SpectrumPlot = addlistener(obj.WatchList, 'spectrum2Plot', ...
    'PostSet', @(src,evnt)obj.populatefrequency(src, evnt));
obj.Listener.TimeFreqPlot = addlistener(obj.WatchList, 'timefreq2Plot', ...
    'PostSet', @(src,evnt)obj.populatetimefrequency(src, evnt));

obj.Listener.TimeWindow = addlistener(obj.WatchList, 'timeLim', ...
    'PostSet', @(src,evnt)obj.setlimtime(src,evnt));
obj.Listener.FreqWindow = addlistener(obj.WatchList, 'freqLim', ...
    'PostSet', @(src,evnt)obj.setlimfrequency(src, evnt));

%% Assign the data to plot and activate the listener
dataIdx = contains(obj.Dataset.Data.Time.Properties.VariableNames ,[obj.Dataset.dataType(1) 'Time']);
obj.WatchList.time2Plot = obj.Dataset.Data.Time(:,dataIdx);
obj.WatchList.spectrum2Plot = obj.Dataset.Data.Frequency(:,dataIdx);

obj.Listener.SelectedLine = addlistener(obj.WatchList, 'edvLine', ...
    'PostSet', @(src,evnt)obj.setselectedtrack(src, evnt));
end

