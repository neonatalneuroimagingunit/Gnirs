function obj = pagnosblackmagic(idAnalysis, GHandle)

DBAnalysis = GHandle.DataBase.findid(idAnalysis);
DBMeasure = GHandle.DataBase.findid(DBAnalysis.measureId);

Data = DBAnalysis.loaddata;
Probe = GHandle.DataBase.findid(DBMeasure.probeId).load;
ForwardSymulation = GHandle.DataBase.Probe(end).loadforward;
Atlas = GHandle.DataBase.findid(Probe.atlasId).load;

Track.Channel = Probe.channel.label;
allLabel = Data.Time.Properties.VariableNames;

for iChannel = 1:length(Track.Channel)
    temp = Probe.channel.pairs(strcmp(Probe.channel.label, Track.Channel(iChannel)),:);
    tobesearched = num2str(temp,'s%.3d_d%.3d');
    mask = contains(allLabel, tobesearched);
    Track.Value(:,:,iChannel) = Data.Time{:,mask};
end

 Track.List = erase(allLabel(mask),tobesearched);

obj = Viewer3D([],Atlas,Probe,ForwardSymulation,Track);
end

