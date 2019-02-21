function dataOut = blockaverage(dataIn, Parameters)
Event = Parameters.Event;
sampleStart = round(Event.samplingFrequency * Parameters.start);
sampleStop = round(Event.samplingFrequency * Parameters.stop);

nCond = length(Parameters.condition);
nOldCol = (size(dataIn,2)-1);
nCol = nCond.*nOldCol+1;
nRow = sampleStop - sampleStart + 1;
dataOut = zeros(nRow,nCol);
dataOut(:,1) = nRow./Event.samplingFrequency.*linspace(0,1,nRow);
for iCond = 1:1:nCond
    % [t1,t0] -> baseline
    % [t0,t2] -> task
    % [t2-(t0-t1),t2] -> end for detrending
    t0 = Event.startSample(Parameters.condition(iCond) == Event.type);
    t1 = t0 + sampleStart;
    t2 = t0 + sampleStop;
    
    nTrial = size(t0,1);
    tempData = zeros((t2(1)-t1(1)+1),1);
    for iTrial = 1:1:nTrial
        tempData = dataIn{t1(iTrial):t2(iTrial),2:end} + tempData;
    end
    tempData = tempData./nTrial;
    
    if sampleStart < 0
        if Parameters.detrend
            avg1 = mean(tempData(1:-sampleStart,:));
            avg2 = mean(tempData((sampleStop:sampleStop-sampleStart),:));
            trend = linspace(0,1,sampleStop-sampleStart+1)'*(avg2-avg1) + avg1;
            tempData = tempData - trend;
            
        else
            avg = mean(tempData(1:-sampleStart,:),1);
            tempData = tempData - avg;
        end
    end
    dataOut(:,nOldCol*(iCond-1)+2:nOldCol*iCond+1) = tempData;
end
ColumnName = [dataIn.Properties.VariableNames(1), repmat(dataIn.Properties.VariableNames(2:end),1,nCond)];
ColumnName(2:end) =  strcat(ColumnName(2:end) ,'_c', reshape(repmat(cellstr(num2str((1:nCond)'))',[nOldCol,1]),1,[]));
dataOut = array2table(dataOut,'VariableNames',ColumnName);
end