function trackrefresh(~, ~, obj)

if obj.TrackInfo.TrackCheckbox.Value == true
    obj.TrackPlot.TrackSource.delete;
    
    %sourceColormap = feval(obj.TrackSetting.Colormap.String{obj.TrackSetting.Colormap.Value}, 128); % take information from the gui
    %sourceThreshold = max(str2double(obj.TrackSetting.Threshold.String), -Inf);
    maxMarkerSize = max(str2double(obj.TrackSetting.MaxMarkerSize.String), 0);
    downsamplingFactor = round(max(str2double(obj.TrackSetting.DownSampling.String), 1));
    
    sourceColormapN = flipud(winter(128)); % take information from the gui
    sourceColormapP = flipud(autumn(128)); % take information from the gui
    
    minN = str2double(obj.TrackSetting.HistogramMin1.String);
    maxN = str2double(obj.TrackSetting.HistogramMax1.String);
    minP = str2double(obj.TrackSetting.HistogramMin2.String);
    maxP = str2double(obj.TrackSetting.HistogramMax2.String);
    
    nChannel = size(obj.TrackInfo.Channel.Value,2);
    flaggona = nChannel == 1;
    
    frame = max(round(obj.TrackSetting.TimeSlider.Value .* size(obj.Track.Value,1)), 1);
    
    %%% sistemare con CUBBO (hypercubbo)
    %sourceValueOrig = zeros(size(obj.Forward.srcFlux(:,1)));
    %     for iChannel = 1:1:nChannel
    %         channelIdx =  obj.TrackInfo.Channel.Value(iChannel);
    %         photonDensity = obj.Forward.jFluxNorm(:, channelIdx);
    %         sourceValueOrig = sourceValueOrig + photonDensity.*(mean(obj.Track.Value(frame,obj.TrackInfo.TrackList.Value,channelIdx))./nChannel);
    %     end
    
    channelIdx =  obj.TrackInfo.Channel.Value;
    channelMask = false(1,size(obj.Forward.jFluxNorm,2));
    channelMask(channelIdx) = true;
    photonDensity = obj.Forward.jFluxNorm(:, channelMask);
    sourceValueOrig = mean(photonDensity.*(reshape(mean(obj.Track.Value(frame,obj.TrackInfo.TrackList.Value,channelMask),2),1,[])),2);
    
    sourceMaskP = sourceValueOrig>minP & sourceValueOrig<maxP;
    sourceMaskN = sourceValueOrig>minN & sourceValueOrig<maxN;
    sourceValueOrig(sourceMaskN) = -sourceValueOrig(sourceMaskN);
    
    switch obj.TrackSetting.Scale.String{obj.TrackSetting.Scale.Value}
        case 'linear'
            sourceValue = sourceValueOrig;
            minN = -minN;
            maxN = -maxN;
        case 'log10'
            sourceValue = log10(sourceValueOrig);
            minN = log10(-minN);
            maxN = log10(-maxN);
            minP = log10(minP);
            maxP = log10(maxP);
        case 'log'
            sourceValue = log(sourceValueOrig);
            minN = log(-minN);
            maxN = log(-maxN);
            minP = log(minP);
            maxP = log(maxP);
        case 'exp'
            sourceValue = exp(sourceValueOrig);
            minN = exp(-minN);
            maxN = exp(-maxN);
            minP = exp(minP);
            maxP = exp(maxP);
        case 'sqrt'
            sourceValue = (sourceValueOrig).^(1/2);
            minN = sqrt(-minN);
            maxN = sqrt(-maxN);
            minP = sqrt(minP);
            maxP = sqrt(maxP);
        case 'cube root'
            sourceValue = (sourceValueOrig).^(1/3);
            minN = (-minN).^(1/3);
            maxN = (-maxN).^(1/3);
            minP = (minP).^(1/3);
            maxP = (maxP).^(1/3);
    end
    
    %sourceMask = sourceValue > sourceThreshold;
    angleMask = true(size(sourceValue));
    % get the half sensitivity to see the section in plot
    if flaggona
        
        src = obj.Forward.channel(channelIdx ,1);
        det = obj.Forward.channel(channelIdx ,2);
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
    
    downSampleMask = false(size(angleMask));
    downSampleMask(1:downsamplingFactor:end) = true;
    plotMask = and(downSampleMask, angleMask);
    
    %maxS = max(sourceValue);
    %minS = min(sourceValue);
    
    source2PlotP = sourceValue(plotMask & sourceMaskP);
    source2PlotN = sourceValue(plotMask & sourceMaskN);
    
    sourceNormalizedP = (source2PlotP - minP)./(maxP - minP); % questa cosa fa pasticcio
    sourceNormalizedN = (source2PlotN - minN)./(maxN - minN);
    
    colorIdxN = floor(sourceNormalizedN*127) + 1;
    colorIdxP = floor(sourceNormalizedP*127) + 1;
    
    scatterSizeN = max(maxMarkerSize.*sourceNormalizedN , 0.01);
    scatterSizeP = max(maxMarkerSize.*sourceNormalizedP , 0.01);
    scatterColorN = sourceColormapN(colorIdxN,:);
    scatterColorP = sourceColormapP(colorIdxP,:);
    
    obj.TrackPlot.TrackSource = scatter3(obj.MainPlot.Axes, ...
        [obj.Forward.node(plotMask & sourceMaskN,1); obj.Forward.node(plotMask & sourceMaskP,1)], ...
        [obj.Forward.node(plotMask & sourceMaskN,2); obj.Forward.node(plotMask & sourceMaskP,2)], ...
        [obj.Forward.node(plotMask & sourceMaskN,3); obj.Forward.node(plotMask & sourceMaskP,3)],...
        [scatterSizeN; scatterSizeP],...
        ...,10, ...
        [scatterColorN; scatterColorP],...
        'filled'...
        );
else
    obj.TrackPlot.TrackSource.delete;
end
end