function tempplotfunc(~,~,GHandle)

landmarkColor = GHandle.Preference.Theme.landmarkColor;

sourceColor = [1 0 0];
detectorColor = [0 0 1];
lineShrinkFactor = 2;
Atlas =  GHandle.TempWindow.SelectedAtlas;

if GHandle.TempWindow.MirrorProbe.Value
    GHandle.TempWindow.Mask.Source = GHandle.TempWindow.Mask.Source(:,end:-1:1) |  GHandle.TempWindow.Mask.Source(:,:);
    GHandle.TempWindow.Mask.Detector = GHandle.TempWindow.Mask.Detector(:,end:-1:1) |  GHandle.TempWindow.Mask.Detector(:,:);
end


idxLM = GHandle.TempWindow.Mask.LandMark(:);
idxSrc = GHandle.TempWindow.Mask.Source(:);
idxDet = GHandle.TempWindow.Mask.Detector(:);
xLandMark = reshape(Atlas.LandMarks.coord(:,:,1), [],1);
yLandMark = reshape(Atlas.LandMarks.coord(:,:,2), [],1);
zLandMark = reshape(Atlas.LandMarks.coord(:,:,3), [],1);

scalpMask = GHandle.TempWindow.NewProbeAxes.Children == GHandle.TempWindow.Scalp;

delete(GHandle.TempWindow.NewProbeAxes.Children(~scalpMask))

sourceTag = GHandle.TempWindow.SelectedAtlas.LandMarks.names(GHandle.TempWindow.Mask.Source);
sourcePos = reshape(GHandle.TempWindow.SelectedAtlas.LandMarks.coord(repmat(GHandle.TempWindow.Mask.Source,1,1,3)),[],3);
GHandle.TempWindow.SourceList.String = sourceTag;

detectorTag = GHandle.TempWindow.SelectedAtlas.LandMarks.names(GHandle.TempWindow.Mask.Detector);
detectorPos = reshape(GHandle.TempWindow.SelectedAtlas.LandMarks.coord(repmat(GHandle.TempWindow.Mask.Detector,1,1,3)),[],3);
GHandle.TempWindow.DetectorList.String = detectorTag;

GHandle.TempWindow.ChannelList.Data = {};

nSource = size(sourceTag,1);
nDetector = size(detectorTag,1);

channelPairsIdx = combvec(1:nSource, 1:nDetector)';
nChannel = size(channelPairsIdx,1);

thresholdDistance = str2double(GHandle.TempWindow.ThresholdDistance.String);

GHandle.TempWindow.DetectorListTitle.String = ['Detectors (' num2str(nDetector) ')'];
GHandle.TempWindow.SourceListTitle.String = ['Sources (' num2str(nSource) ')'];

for iChannel = 1:1:nChannel
    tempCoordSource = sourcePos(channelPairsIdx(iChannel,1),:);
    tempCoordDetector = detectorPos(channelPairsIdx(iChannel,2),:);
    tempChannelDistance = norm(tempCoordSource-tempCoordDetector);
    
    GHandle.TempWindow.ChannelList.Data{iChannel,1} = ['Ch' num2str(iChannel)];
    GHandle.TempWindow.ChannelList.Data{iChannel,2} = sourceTag{channelPairsIdx(iChannel,1)};
    GHandle.TempWindow.ChannelList.Data{iChannel,3} = detectorTag{channelPairsIdx(iChannel,2)};
    GHandle.TempWindow.ChannelList.Data{iChannel,4} = tempChannelDistance;
    GHandle.TempWindow.ChannelList.Data{iChannel,5} = tempChannelDistance <= thresholdDistance;
end

if nChannel == 0
    nChannelActive = 0;
else
    nChannelActive = sum([GHandle.TempWindow.ChannelList.Data{:,5}]);
end
GHandle.TempWindow.ChannelListTitle.String = ['Channels (' num2str(nChannel) ' total, ' num2str(nChannelActive) ' active)'];

if  GHandle.TempWindow.LandmarkLabels.Value
    GHandle.TempWindow.Source = text(sourcePos(:,1),...
        sourcePos(:,2),...
        sourcePos(:,3),...
        sourceTag, ...
        'FontWeight', 'bold', ...
        'FontSize', 10, ...
        'HitTest', 'off', ...
        'Color', sourceColor);
    GHandle.TempWindow.Detector = text(detectorPos(:,1),...
        detectorPos(:,2),...
        detectorPos(:,3),...
        detectorTag, ...
        'FontWeight', 'bold', ...
        'FontSize', 10, ...
        'HitTest', 'off', ...
        'Color', detectorColor);
    if nChannel
        coordChannel = (sourcePos(channelPairsIdx(:,1),:) + detectorPos(channelPairsIdx(:,2),:))/2;
        GHandle.TempWindow.ChannelText = text(coordChannel(:,1), coordChannel(:,2), coordChannel(:,3), ...
            GHandle.TempWindow.ChannelList.Data(:,1), ...
            'FontWeight', 'bold', ...
            'FontSize', 10, ...
            'HitTest', 'off', ...
            'Color', 'k');
    end
end

if nChannel
    tempVector = sourcePos(channelPairsIdx(:,1),:)-detectorPos(channelPairsIdx(:,2),:);
    tempVersor = tempVector./vecnorm(tempVector,2,2);
    
    tempCoordSourceShrink = sourcePos(channelPairsIdx(:,1),:) - tempVersor.*lineShrinkFactor;
    tempCoordDetectorShrink = detectorPos(channelPairsIdx(:,2),:) + tempVersor.*lineShrinkFactor;
    xChannel = [tempCoordSourceShrink(:,1) tempCoordDetectorShrink(:,1)]';
    yChannel = [tempCoordSourceShrink(:,2) tempCoordDetectorShrink(:,2)]';
    zChannel = [tempCoordSourceShrink(:,3) tempCoordDetectorShrink(:,3)]';
    shortIdx = find([GHandle.TempWindow.ChannelList.Data{:,5}]);
    longIdx = setdiff(1:nChannel , shortIdx);
    
    if GHandle.TempWindow.ShowInactive.Value
        longLineStyle = ':';
    else
        longLineStyle = 'none';
    end
    
    GHandle.TempWindow.Channel(shortIdx) = plot3(...
        xChannel(:,shortIdx), ...
        yChannel(:,shortIdx), ...
        zChannel(:,shortIdx), ...
        'LineWidth', 2, ...
        'Color', [0 0 0],...
        'HitTest', 'off'...
        );
    GHandle.TempWindow.Channel(longIdx) = plot3(...
        xChannel(:,longIdx), ...
        yChannel(:,longIdx), ...
        zChannel(:,longIdx), ...
        'LineWidth', 2, ...
        'Color', [0 0 0],...
        'LineStyle', longLineStyle,...
        'HitTest', 'off'...
        );
    
end


GHandle.TempWindow.LandMark = plot3(...
    xLandMark(idxLM), yLandMark(idxLM), zLandMark(idxLM), ...
    'MarkerSize',20, ...
    'ButtonDownFcn',{@(Handle,Evnt)landmarkcallback(Handle,Evnt,GHandle)}, ...
    'LineStyle', 'none', ...
    'Visible', 'on', ...
    'Marker','.', ...
    'Color',landmarkColor, ...
    'Parent', GHandle.TempWindow.NewProbeAxes);


GHandle.TempWindow.Source = plot3(...
    xLandMark(idxSrc), yLandMark(idxSrc), zLandMark(idxSrc), ...
    'MarkerSize',20, ...
    'ButtonDownFcn',{@(Handle,Evnt)landmarkcallback(Handle,Evnt,GHandle)}, ...
    'LineStyle', 'none', ...
    'Visible', 'on', ...
    'Marker','.', ...
    'Color',sourceColor, ...
    'Parent', GHandle.TempWindow.NewProbeAxes);

GHandle.TempWindow.Detector = plot3(...
    xLandMark(idxDet), yLandMark(idxDet), zLandMark(idxDet), ...
    'MarkerSize',20, ...
    'ButtonDownFcn',{@(Handle,Evnt)landmarkcallback(Handle,Evnt,GHandle)}, ...
    'LineStyle', 'none', ...
    'Visible', 'on', ...
    'Marker','.', ...
    'Color',detectorColor, ...
    'Parent', GHandle.TempWindow.NewProbeAxes);
end



