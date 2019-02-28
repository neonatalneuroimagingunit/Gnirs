function populateinfo(obj)


obj.MainInfo.TabGroup = uitabgroup(...
    'Parent',obj.MainInfo.Panel,...
    'Units', 'normalized',...
    'Position',[0 0 1 1]);

if ~isempty(obj.Atlas)
    obj.MainInfo.TabAtlas = uitab(...
        'Parent',obj.MainInfo.TabGroup,...
        'Title','Atlas');
    obj.popatlasinfo;
end

if ~isempty(obj.Probe)
    obj.MainInfo.TabProbe = uitab(...
        'Parent',obj.MainInfo.TabGroup,...
        'Title','Probe');
    obj.popprobeinfo;
end

if ~isempty(obj.Forward)
    obj.MainInfo.TabForward = uitab(...
        'Parent',obj.MainInfo.TabGroup,...
        'Title','Forward');
    obj.popforwardinfo;
end

if ~isempty(obj.Track)
    obj.MainInfo.TabTrack = uitab(...
        'Parent',obj.MainInfo.TabGroup,...
        'Title','Track');
    obj.poptrackinfo;
end

end

