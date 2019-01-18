function  populateprobe(obj)
lineShrinkFactor = 0.15;
if ~isempty(obj.Dataset.Probe)
    markerSize = 15;
    
    % Bigmagia
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    egg = max(obj.Dataset.Probe.source.position2D(:));
    spam = zeros(egg,egg);
    bacon = sub2ind(size(spam),obj.Dataset.Probe.source.position2D(:,1),obj.Dataset.Probe.source.position2D(:,2));
    spam(bacon) = 1;
    bacon = sub2ind(size(spam),obj.Dataset.Probe.detector.position2D(:,1),obj.Dataset.Probe.detector.position2D(:,2));
    spam(bacon) = 2;
    spam(~any(spam,2),:) = [];
    spam(:,~any(spam,1)) = [];
    [posSrc(:,1), posSrc(:,2)] = find(spam==1);
    [posDet(:,1), posDet(:,2)] = find(spam==2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    idxSrc = obj.Dataset.Probe.channel.pairs(:,1);
    idxDet = obj.Dataset.Probe.channel.pairs(:,2);
    
    xCh = [posSrc(idxSrc,1)'; posDet(idxDet,1)'];
    yCh = [posSrc(idxSrc,2)'; posDet(idxDet,2)'];
    zCh = zeros(size(xCh));
    %
    tempVector = posSrc(idxSrc,:)-posDet(idxDet,:);
    tempVersor = tempVector./vecnorm(tempVector,2,2);
    tempCoordSourceShrink = posSrc(idxSrc,:) - tempVersor.*lineShrinkFactor;
    tempCoordDetectorShrink = posDet(idxDet,:) + tempVersor.*lineShrinkFactor;
    xCh = [tempCoordSourceShrink(:,1) tempCoordDetectorShrink(:,1)]';
    yCh = [tempCoordSourceShrink(:,2) tempCoordDetectorShrink(:,2)]';
    zCh = zeros(size(xCh));...[tempCoordSourceShrink(:,3) tempCoordDetectorShrink(:,3)]';
    %
    

    obj.Panel.Probe.Channel = plot3(yCh,-xCh,zCh,...
        'LineStyle', '-',...
        'LineWidth',0.5,...
        'buttonDownFcn', {@probe_callback , obj},...
        'Color', obj.Preference.channelColor,...
        'Parent',  obj.Panel.Probe.Axes);
    set( obj.Panel.Probe.Channel, {'Tag'}, obj.Dataset.Probe.channel.label);
    
    x = repmat(posSrc(:,1)',[2,1]);
    y = repmat(posSrc(:,2)',[2,1]);
    z = zeros(size(x));
    
    obj.Panel.Probe.Source = plot3(y,-x,z,...
        'LineStyle', 'none',...
        'Marker', '.',...
        'MarkerSize', markerSize, ...
        'buttonDownFcn', {@probe_callback , obj},...
        'Color', obj.Preference.sourceColor,...
        'Parent',  obj.Panel.Probe.Axes);
    
    x = repmat(posDet(:,1)',[2,1]);
    y = repmat(posDet(:,2)',[2,1]);
    z = zeros(size(x));
    obj.Panel.Probe.Detector = plot3(y,-x,z,...
        'LineStyle', 'none',...
        'Marker', '.',...
        'MarkerSize', markerSize, ...
        'buttonDownFcn', {@probe_callback , obj},...
        'Color', obj.Preference.detectorColor,...
        'Parent', obj.Panel.Probe.Axes);
    
    nSrc = length(obj.Dataset.Probe.source.label);
    nDet = length(obj.Dataset.Probe.detector.label);
    srcName = cellstr(num2str((1:nSrc)','s%.3d'));
    detName = cellstr(num2str((1:nDet)','d%.3d'));
    set( obj.Panel.Probe.Source, {'Tag'}, srcName);
    set( obj.Panel.Probe.Detector, {'Tag'}, detName);
    set( obj.Panel.Probe.Axes, 'XLim', [min(yCh, [], 'all')-1, max(yCh, [], 'all')+1] ,'YLim',[min(-xCh, [], 'all')-1, max(-xCh, [], 'all')+1]);
end
end
function probe_callback(hOptode, ~, obj)
tobesearched = hOptode.Tag;
if contains(tobesearched,'Ch')
    temp = obj.Dataset.Probe.channel.pairs(strcmp(obj.Dataset.Probe.channel.label, tobesearched),:);
    tobesearched = num2str(temp,'s%.3d_d%.3d');
end
obj.WatchList.edvLine = contains({obj.Panel.Plot.Time.Lines.Tag}, tobesearched);
end
