function  viewerprobe(viewerC, GHandle, vIdx)
markerSize = 15;
flag3D = 1;

% Bigmagia
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
egg = 101;
spam = zeros(egg,egg);
bacon = sub2ind(size(spam),viewerC.Probe.source.position2D(:,1),viewerC.Probe.source.position2D(:,2));
spam(bacon) = 1;
bacon = sub2ind(size(spam),viewerC.Probe.detector.position2D(:,1),viewerC.Probe.detector.position2D(:,2));
spam(bacon) = 2;
spam(~any(spam,2),:) = [];
spam(:,~any(spam,1)) = [];
[posSrc(:,1), posSrc(:,2)] = find(spam==1);
[posDet(:,1), posDet(:,2)] = find(spam==2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

idxSrc = viewerC.Probe.channel.pairs(:,1);
idxDet = viewerC.Probe.channel.pairs(:,2);
if flag3D
    xCh = [posSrc(idxSrc,1)'; posDet(idxDet,1)'];
    yCh = [posSrc(idxSrc,2)'; posDet(idxDet,2)'];
    zCh = zeros(size(xCh));
else
    xCh = [viewerC.Probe.source.position(idxSrc,1)'; viewerC.Probe.detector.position(idxDet,1)'];
    yCh = [viewerC.Probe.source.position(idxSrc,2)'; viewerC.Probe.detector.position(idxDet,2)'];
    zCh = [viewerC.Probe.source.position(idxSrc,3)'; viewerC.Probe.detector.position(idxDet,3)'];
end
GHandle.Viewer(vIdx).ProbePanel.Channel = plot3(yCh,-xCh,zCh,...
    'LineStyle', '-',...
    'LineWidth',0.5,...
    'buttonDownFcn', {@probe_callback , GHandle, vIdx, viewerC},...
    'Color', viewerC.channelColor,...
    'Parent', GHandle.Viewer(vIdx).ProbePanel.ProbeAxes);
set(GHandle.Viewer(vIdx).ProbePanel.Channel, {'Tag'}, viewerC.Probe.channel.label);

if flag3D
    x = repmat(posSrc(:,1)',[2,1]);
    y = repmat(posSrc(:,2)',[2,1]);
    z = zeros(size(x));
else
    x = repmat(viewerC.Probe.source.position(:,1)',[2,1]); 
    y = repmat(viewerC.Probe.source.position(:,2)',[2,1]);
    z = repmat(viewerC.Probe.source.position(:,3)',[2,1]);
end
GHandle.Viewer(vIdx).ProbePanel.Source = plot3(y,-x,z,...
    'LineStyle', 'none',...
    'Marker', '.',...
    'MarkerSize', markerSize, ...
    'buttonDownFcn', {@probe_callback , GHandle, vIdx, viewerC},...
    'Color', viewerC.sourceColor,...
    'Parent', GHandle.Viewer(vIdx).ProbePanel.ProbeAxes);

if 1
    x = repmat(posDet(:,1)',[2,1]);
    y = repmat(posDet(:,2)',[2,1]);
    z = zeros(size(x));
else
    x = repmat(viewerC.Probe.detector.position(:,1)',[2,1]);
    y = repmat(viewerC.Probe.detector.position(:,2)',[2,1]);
    z = repmat(viewerC.Probe.detector.position(:,3)',[2,1]);
end
GHandle.Viewer(vIdx).ProbePanel.Detector = plot3(y,-x,z,...
    'LineStyle', 'none',...
    'Marker', '.',...
    'MarkerSize', markerSize, ...
    'buttonDownFcn', {@probe_callback , GHandle, vIdx,viewerC},...
    'Color', viewerC.detectorColor,...
    'Parent', GHandle.Viewer(vIdx).ProbePanel.ProbeAxes);

nSrc = length(viewerC.Probe.source.label);
nDet = length(viewerC.Probe.detector.label);
srcName = cellstr(num2str((1:nSrc)','s%.3d'));
detName = cellstr(num2str((1:nDet)','d%.3d'));
set(GHandle.Viewer(vIdx).ProbePanel.Source, {'Tag'}, srcName);
set(GHandle.Viewer(vIdx).ProbePanel.Detector, {'Tag'}, detName);
set(GHandle.Viewer(vIdx).ProbePanel.ProbeAxes, 'XLim', [min(yCh, [], 'all')-1, max(yCh, [], 'all')+1] ,'YLim',[min(-xCh, [], 'all')-1, max(-xCh, [], 'all')+1]);
end

function probe_callback(hOptode, ~, GHandle, vIdx,viewerC)
tobesearched = hOptode.Tag;
if contains(tobesearched,'Ch')
    temp = viewerC.Probe.channel.pairs(strcmp(viewerC.Probe.channel.label, tobesearched),:);
    tobesearched = num2str(temp,'s%.3d_d%.3d');
end
GHandle.Viewer(vIdx).WatchList.edvLine = contains({GHandle.Viewer(vIdx).PlotPanel.Time.Lines.Tag}, tobesearched);
end
