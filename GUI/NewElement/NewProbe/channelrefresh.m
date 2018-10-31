function channelrefresh(h,e,GHandle)

lineShrinkFactor = 0.85; % between 0.5 (no line) and 1 (point to point)

sourceColor = [1 0 0];
detectorColor = [0 0 1];

sourceTag = GHandle.TempWindow.SourceList.String;
detectorTag = GHandle.TempWindow.DetectorList.String;
nSource = size(sourceTag,1);
nDetector = size(detectorTag,1);
channelPairs = int32(combvec(GHandle.TempWindow.SourceList.UserData', GHandle.TempWindow.DetectorList.UserData')');
channelPairsIdx = combvec(1:nSource, 1:nDetector)';
nChannel = size(channelPairs,1);

if GHandle.TempWindow.LandmarkLabels.Value == 1
    labelVisibility = 'on';
else
    labelVisibility = 'off';
end

GHandle.TempWindow.ChannelList.Data = {};
if isfield(GHandle.TempWindow,'Channel')
    delete(GHandle.TempWindow.Channel);
    GHandle.TempWindow.Channel(nChannel+1:end) = [];
end
if isfield(GHandle.TempWindow,'Source')
    delete(GHandle.TempWindow.Source);
    GHandle.TempWindow.Source(nSource+1:end) = [];
end
if isfield(GHandle.TempWindow,'Detector')
    delete(GHandle.TempWindow.Detector);
    GHandle.TempWindow.Detector(nDetector+1:end) = [];
end
if isfield(GHandle.TempWindow,'ChannelText')
    delete(GHandle.TempWindow.ChannelText);
    GHandle.TempWindow.ChannelText(nChannel+1:end) = [];
end

if nChannel
    GHandle.TempWindow.Source = text([GHandle.TempWindow.LandMark(channelPairs(:,1)).XData],...
        [GHandle.TempWindow.LandMark(channelPairs(:,1)).YData],...
        [GHandle.TempWindow.LandMark(channelPairs(:,1)).ZData],...
        GHandle.TempWindow.SourceList.String(channelPairsIdx(:,1)), ...
        'FontWeight', 'bold', ...
        'FontSize', 10, ...
        'Visible', labelVisibility, ...
        'HitTest', 'off', ...
        'Color', sourceColor);
    GHandle.TempWindow.Detector = text([GHandle.TempWindow.LandMark(channelPairs(:,2)).XData],...
        [GHandle.TempWindow.LandMark(channelPairs(:,2)).YData],...
        [GHandle.TempWindow.LandMark(channelPairs(:,2)).ZData],...
        GHandle.TempWindow.DetectorList.String(channelPairsIdx(:,2)), ...
        'FontWeight', 'bold', ...
        'FontSize', 10, ...
        'Visible', labelVisibility, ...
        'HitTest', 'off', ...
        'Color', detectorColor);
    
    
    coordSource = [GHandle.TempWindow.LandMark(channelPairs(:,1)).XData; GHandle.TempWindow.LandMark(channelPairs(:,1)).YData; GHandle.TempWindow.LandMark(channelPairs(:,1)).ZData]';
    coordDetector =  [GHandle.TempWindow.LandMark(channelPairs(:,2)).XData; GHandle.TempWindow.LandMark(channelPairs(:,2)).YData; GHandle.TempWindow.LandMark(channelPairs(:,2)).ZData]';
    coordChannel = ( coordSource +  coordDetector)/2;
    thresholdDistance = str2double(GHandle.TempWindow.ThresholdDistance.String);
    
    for iChannel = 1:1:nChannel
        tempCoordSource = coordSource(iChannel,:);
        tempCoordDetector = coordDetector(iChannel,:);
        tempChannelDistance = norm(tempCoordSource-tempCoordDetector);
        
        GHandle.TempWindow.ChannelList.Data{iChannel,1} = ['Ch' num2str(iChannel)];
        GHandle.TempWindow.ChannelList.Data{iChannel,2} = GHandle.TempWindow.SourceList.String{channelPairsIdx(iChannel,1)};
        GHandle.TempWindow.ChannelList.Data{iChannel,3} = GHandle.TempWindow.DetectorList.String{channelPairsIdx(iChannel,2)};
        GHandle.TempWindow.ChannelList.Data{iChannel,4} = tempChannelDistance;
        GHandle.TempWindow.ChannelList.Data{iChannel,5} = tempChannelDistance <= thresholdDistance;
        if GHandle.TempWindow.ChannelList.Data{iChannel,5}
            linestyleChannel = '-';
        else
            if GHandle.TempWindow.ShowInactive.Value
                linestyleChannel = ':';
            else
                linestyleChannel = 'none';
            end
        end
 
        tempCoordSourceShrink = tempCoordSource - (tempCoordSource-tempCoordDetector)*lineShrinkFactor;
        tempCoordDetectorShrink = tempCoordDetector + (tempCoordSource-tempCoordDetector)*lineShrinkFactor;
        GHandle.TempWindow.Channel(iChannel) = plot3([tempCoordSourceShrink(1) tempCoordDetectorShrink(1)],...
            [tempCoordSourceShrink(2) tempCoordDetectorShrink(2)],...
            [tempCoordSourceShrink(3) tempCoordDetectorShrink(3)], ...
            'LineWidth', 2, ...
            'LineStyle',linestyleChannel,...
            'HitTest', 'off', ...
            'Color', 'k');
        
    end
    
    GHandle.TempWindow.ChannelText = text(coordChannel(:,1), coordChannel(:,2), coordChannel(:,3), ...
        GHandle.TempWindow.ChannelList.Data(:,1), ...
        'FontWeight', 'bold', ...
        'FontSize', 10, ...
        'Visible', labelVisibility, ...
        'HitTest', 'off', ...
        'Color', 'k');
end
end

