function photonrefresh(~, ~, obj)
if obj.PhotonCheckbox.Value == true
    obj.Sensitivity.delete;
    
    if obj.DataType.Value == 1
        photonDensityOrig = sum(abs([obj.Forward.srcFlux(:, obj.SrcList.Value) obj.Forward.detFlux(:, obj.DetList.Value)]), 2);
        flaggona = size([obj.SrcList.Value, obj.DetList.Value],2) == 1;
    else
        src = obj.Probe.channel.pairs(obj.ChannelList.Value,1);
        det = obj.Probe.channel.pairs(obj.ChannelList.Value,2);
        photonDensityOrig = sum(abs(obj.Forward.srcFlux(:,src).*obj.Forward.detFlux(:,det)),2);
        flaggona = size(obj.ChannelList.Value,2) == 1;
    end
    
    photonDensity = photonDensityOrig ./ max(photonDensityOrig);
    
    switch obj.Scale.String{obj.Scale.Value}
        case 'linear'
            ...
        case 'log10'
        photonDensity = log10(photonDensity);
        case 'log'
            photonDensity = log(photonDensity);
        case 'exp'
            photonDensity = exp(photonDensity);
        case 'sqrt'
            photonDensity = photonDensity.^(1/2);
        case 'cube root'
            photonDensity = photonDensity.^(1/3);
    end
    
    sensitivityColormap = feval(obj.Colormap.String{obj.Colormap.Value},128);
    sensitivityThreshold = max(str2double(obj.SensitivityThreshold.String), -Inf);
    maxMarkerSize = max(str2double(obj.MaxMarkerSize.String), 0);
    downsamplingFactor = round(max(str2double(obj.DownSampling.String), 1));
    
    sensitivityMask = photonDensity > sensitivityThreshold;
    
    
    angleMask = true(size(sensitivityMask));
    % get the half sensitivity to see the section in plot
    if flaggona
        if obj.DataType.Value == 1
            srcDir = [obj.Forward.srcDir(obj.SrcList.Value,:); obj.Forward.detDir(obj.DetList.Value,:)];
            p1 = [obj.Forward.src(obj.SrcList.Value,:); obj.Forward.det(obj.DetList.Value,:)];
            p2 = p1 + srcDir;
            iVersor = [1 0 0];
            jVersor = [0 1 0]; %#ok vuoi non metterlo?
            kVersor = [0 0 1];
            if norm(cross(srcDir, iVersor)) > 0.1
                p3 = p1 + iVersor;
            else
                p3 = p1 + kVersor;
            end
        else
            p1 = obj.Forward.src(src,:);
            p2 = obj.Forward.det(det,:);
            p3 = centerofmass(obj.Forward.node(:,1:3), photonDensityOrig);
        end
        
        coffp3 = points2plane(p1, p2, p3);
        angle1 = deg2rad(str2double(obj.Angle1.String));
        p31 = (p3-p1)*rotate3dax(angle1,p2-p1) + p1;
        coff = points2plane(p1, p2, p31);
        mask1 = dot(obj.Forward.node(:,1:3), repmat(coff(1:3),[size(obj.Forward.node,1) 1]),2) + coff(4) > 0;
        mask1 = and(mask1, dot(obj.Forward.node(:,1:3), repmat(coffp3(1:3),[size(obj.Forward.node,1) 1]),2) + coffp3(4) > 0);
        angle2 = deg2rad(str2double(obj.Angle2.String));
        p32 = (p3-p1)*rotate3dax(-angle2,p2-p1) + p1;
        coff = points2plane(p1, p2, p32);
        mask2 = dot(obj.Forward.node(:,1:3), repmat(coff(1:3),[size(obj.Forward.node,1) 1]),2) + coff(4) < 0;
        mask2 = and(mask2, dot(obj.Forward.node(:,1:3), repmat(coffp3(1:3),[size(obj.Forward.node,1) 1]),2) + coffp3(4) < 0);
        angleMask = or(mask1, mask2);
    end
    
    downSampleMask = false(size(sensitivityMask));
    downSampleMask(1:downsamplingFactor:end) = sensitivityMask(1:downsamplingFactor:end);
    sensitivityMask = and(downSampleMask, angleMask);
    sensitivity2Plot = photonDensity(sensitivityMask);
    
    minSensitivity = min(sensitivity2Plot);
    maxSensitivity = max(sensitivity2Plot);
    sensitivityNormalized = (sensitivity2Plot - minSensitivity)./(maxSensitivity - minSensitivity);
    
    colorIdx = floor(sensitivityNormalized*127) + 1;
    
    scatterSize = max(maxMarkerSize.*sensitivityNormalized , 0.01);
    scatterColor = sensitivityColormap(colorIdx,:);
    
    obj.Sensitivity = scatter3(obj.ProbeAxes, ...
        obj.Forward.node(sensitivityMask,1), ...
        obj.Forward.node(sensitivityMask,2), ...
        obj.Forward.node(sensitivityMask,3),...
        scatterSize,...
        scatterColor,...
        'filled'...
        );
else
    obj.Sensitivity.delete;
end