function populateinfo(obj)


obj.MainInfo.TabGroup = uitabgroup(...
    'Parent',obj.MainInfo.Panel,...
    'SelectionChangedFcn', @(h,e)change_tab(h,e,obj),...
    'Units', 'normalized',...
    'Position',[0 0 1 1]);

if ~isempty(obj.Atlas)
    obj.MainInfo.TabAtlas = uitab(...
        'Parent', obj.MainInfo.TabGroup,...
        'Tag', 'Atlas', ...
        'Title', 'Atlas');
    obj.populateatlasinfo;
end

if ~isempty(obj.Probe)
    obj.MainInfo.TabProbe = uitab(...
        'Parent', obj.MainInfo.TabGroup,...
        'Tag', 'Probe', ...
        'Title', 'Probe');
    obj.populateprobeinfo;
end

if ~isempty(obj.Forward)
    obj.MainInfo.TabForward = uitab(...
        'Parent', obj.MainInfo.TabGroup,...
        'Tag', 'Forward', ...
        'Title', 'Forward');
    obj.populateforwardinfo;
end

if ~isempty(obj.Track)
    obj.MainInfo.TabTrack = uitab(...
        'Parent', obj.MainInfo.TabGroup,...
        'Tag', 'Track', ...
        'Title', 'Track');
    obj.populatetrackinfo;
end

end

function change_tab(~,e,obj)
    switch e.NewValue.Tag
        case 'Atlas'
            obj.populateatlassetting;
        case 'Probe'
            obj.populateprobesetting;
        case 'Forward'
            obj.populateforwardsetting;
        case 'Track'
            obj.populatetracksetting;
        otherwise
            disp('miao');
    end
end