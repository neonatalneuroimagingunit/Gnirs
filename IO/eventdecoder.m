function Event = eventdecoder(timeFlag, samplingFrequency)

timeFlag = diff(timeFlag);
timeFlag(timeFlag<0) = 0;
timeFlag = [0 ;timeFlag];

eventType = unique(timeFlag);
eventType(eventType == 0) = [];


startSample = (find(ismember(timeFlag,eventType)));
durationSamples = [startSample(2:end) - startSample(1:end-1); length(timeFlag) - startSample(end) ];

type = timeFlag(startSample);

for iType = 1 : 1 : length(eventType)
    type(type == eventType(iType)) = iType;
end


Dictionary(:,1) =  num2cell(eventType);
Dictionary(:,2) =  cellstr(num2str(eventType,'%.2d'));

Event = NirsEvent('samplingFrequency',samplingFrequency,...
    'startSample',startSample,...
    'Dictionary',Dictionary,...
    'durationSamples',durationSamples,...
    'type',type);

end