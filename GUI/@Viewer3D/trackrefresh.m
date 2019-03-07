function trackrefresh(~, ~, obj)

if obj.TrackInfo.TrackCheckbox.Value == true
    obj.TrackPlot.TrackSource.delete;
    
    sourceColormap = feval(obj.TrackSetting.Colormap.String{obj.TrackSetting.Colormap.Value}, 128); % take information from the gui
    sourceThreshold = max(str2double(obj.TrackSetting.Threshold.String), -Inf);
    maxMarkerSize = max(str2double(obj.TrackSetting.MaxMarkerSize.String), 0);
    downsamplingFactor = round(max(str2double(obj.TrackSetting.DownSampling.String), 1));
    
    nChannel = size(obj.TrackInfo.Channel.Value,2);
    flaggona = nChannel == 1;
    
    frame = max(round(obj.TrackSetting.TimeSliderLabel.Value .* size(obj.Track.Value,1)), 1);
    
    %%% sistemare con CUBBO (hypercubbo)
    sourceValueOrig = zeros(size(obj.Forward.srcFlux(:,1)));
    for iChannel = 1:1:nChannel
        channelIdx =  obj.TrackInfo.Channel.Value(iChannel);
        src = obj.Probe.channel.pairs(channelIdx ,1);
        det = obj.Probe.channel.pairs(channelIdx ,2);
        photonDensity = abs(obj.Forward.srcFlux(:,src).*obj.Forward.detFlux(:,det));
        photonDensity = (photonDensity - min(photonDensity))./(max(photonDensity) - min(photonDensity));
        
        sourceValueOrig = sourceValueOrig + photonDensity.*(mean(obj.Track.Value(frame,obj.TrackInfo.TrackList.Value,channelIdx))./nChannel);
    end
    %%%
    
    minSourceValue = min(min(obj.Track.Value, [], 'all'),0);
    maxSourceValue = max(obj.Track.Value,[],'all');
    
    switch obj.TrackSetting.Scale.String{obj.TrackSetting.Scale.Value}
        case 'linear'
            sourceValue = sourceValueOrig;
        case 'log10'
            sourceValue = log10(sourceValueOrig - minSourceValue);
            maxSourceValue = log10((maxSourceValue - minSourceValue));
        case 'log'
            sourceValue = log(sourceValueOrig - minSourceValue);
            maxSourceValue = log((maxSourceValue - minSourceValue));
        case 'exp'
            sourceValue = exp(sourceValueOrig);
            maxSourceValue = exp(maxSourceValue);
        case 'sqrt'
            sourceValue = (sourceValueOrig - minSourceValue).^(1/2);
            maxSourceValue = (maxSourceValue - minSourceValue).^(1/2);
        case 'cube root'
            sourceValue = (sourceValueOrig - minSourceValue).^(1/3);
            maxSourceValue = (maxSourceValue - minSourceValue).^(1/3);
    end
    
    sourceMask = sourceValue > sourceThreshold;
    angleMask = true(size(sourceMask));
    % get the half sensitivity to see the section in plot
    if flaggona
        
        p1 = obj.Forward.src(src,:);
        p2 = obj.Forward.det(det,:);
        p3 = centerofmass(obj.Forward.node(:,1:3), sourceValueOrig);
        
        coffp3 = points2plane(p1, p2, p3);
        angle1 = deg2rad(str2double(obj.TrackSetting.Angle1.String));
        p31 = (p3-p1)*rotate3dax(angle1,p2-p1) + p1;
        coff = points2plane(p1, p2, p31);
        mask1 = dot(obj.Forward.node(:,1:3), repmat(coff(1:3),[size(obj.Forward.node,1) 1]),2) + coff(4) > 0;
        mask1 = and(mask1, dot(obj.Forward.node(:,1:3), repmat(coffp3(1:3),[size(obj.Forward.node,1) 1]),2) + coffp3(4) > 0);
        angle2 = deg2rad(str2double(obj.TrackSetting.Angle2.String));
        p32 = (p3-p1)*rotate3dax(-angle2,p2-p1) + p1;
        coff = points2plane(p1, p2, p32);
        mask2 = dot(obj.Forward.node(:,1:3), repmat(coff(1:3),[size(obj.Forward.node,1) 1]),2) + coff(4) < 0;
        mask2 = and(mask2, dot(obj.Forward.node(:,1:3), repmat(coffp3(1:3),[size(obj.Forward.node,1) 1]),2) + coffp3(4) < 0);
        angleMask = or(mask1, mask2);
    end
    
    downSampleMask = false(size(sourceMask));
    downSampleMask(1:downsamplingFactor:end) = sourceMask(1:downsamplingFactor:end);
    plotMask = and(downSampleMask, angleMask);
    source2Plot = sourceValue(plotMask);
    
    sourceNormalized = (source2Plot - sourceThreshold)./(maxSourceValue - sourceThreshold); % questa cosa fa pasticcio
    colorIdx = floor(sourceNormalized*127) + 1;
    
    scatterSize = max(maxMarkerSize.*sourceNormalized , 0.01);
    scatterColor = sourceColormap(colorIdx,:);
    
    obj.TrackPlot.TrackSource = scatter3(obj.MainPlot.Axes, ...
        obj.Forward.node(plotMask,1), ...
        obj.Forward.node(plotMask,2), ...
        obj.Forward.node(plotMask,3),...
        scatterSize,...
        scatterColor,...
        'filled'...
        );
else
    obj.TrackPlot.TrackSource.delete;
end
end