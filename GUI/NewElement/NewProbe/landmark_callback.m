function landmark_callback(Handle,Evnt,GHandle)
markColor = [0 1 0];
sourceColor = [1 0 0];
detectorColor = [0 0 1];

%colortextintable = @(colorintable,textintable) ['<html><font color=',colorintable,'>',textintable,'</font></html>'];

%if GHandle.TempWindow.NewProbeZoomButton.Value
if GHandle.TempWindow.Zoom
    GHandle.TempWindow.Temp.CameraTarget = GHandle.TempWindow.NewProbeAxes.CameraTarget;
    GHandle.TempWindow.Temp.CameraPosition = GHandle.TempWindow.NewProbeAxes.CameraPosition;
    GHandle.TempWindow.Temp.CameraViewAngle = GHandle.TempWindow.NewProbeAxes.CameraViewAngle;
    GHandle.TempWindow.NewProbeAxes.CameraUpVectorMode = 'manual';
    
    GHandle.TempWindow.NewProbeAxes.CameraViewAngle = 1;
    GHandle.TempWindow.NewProbeAxes.CameraTarget = Evnt.IntersectionPoint;
    if GHandle.TempWindow.AtlasWidget.SelectedIndex == 1
        GHandle.TempWindow.NewProbeAxes.CameraPosition = [Evnt.IntersectionPoint(1) Evnt.IntersectionPoint(2) 1420.*Evnt.IntersectionPoint(3)];
        %GHandle.TempWindow.NewProbeAxes.CameraUpVector = [0 1 0];
    else
        GHandle.TempWindow.NewProbeAxes.CameraPosition = 33.*Evnt.IntersectionPoint;
    end

    
    GHandle.TempWindow.Zoom = false;
else
    if all(Handle.Color == markColor)
        Handle.Color = 'r';
        GHandle.TempWindow.SourceList.String = [GHandle.TempWindow.SourceList.String; {Handle.Tag}];
    elseif all(Handle.Color == sourceColor)
        Handle.Color = 'b';
        GHandle.TempWindow.SourceList.String(strcmp(GHandle.TempWindow.SourceList.String, {Handle.Tag})) = [];
        GHandle.TempWindow.DetectorList.String = [GHandle.TempWindow.DetectorList.String; {Handle.Tag}];
    elseif all(Handle.Color == detectorColor)
        Handle.Color = 'g';
        GHandle.TempWindow.DetectorList.String(strcmp(GHandle.TempWindow.DetectorList.String, {Handle.Tag})) = [];
    else
        error('404 color not found')
    end
    nSrc = size(GHandle.TempWindow.SourceList.String,1);
    nDet = size(GHandle.TempWindow.DetectorList.String,1);
    cc = 1;
    GHandle.TempWindow.ChannelList.Data = {};
	if isfield(GHandle.TempWindow,'Channels')
		delete(GHandle.TempWindow.Channels);
        GHandle.TempWindow.Channels(2:end) = [];
	end
    if isfield(GHandle.TempWindow,'Sources')
        delete(GHandle.TempWindow.Sources);
        GHandle.TempWindow.Sources(2:end) = [];
    end
    if isfield(GHandle.TempWindow,'Detectors')
        delete(GHandle.TempWindow.Detectors);
        GHandle.TempWindow.Detectors(2:end) = [];
    end
    if isfield(GHandle.TempWindow,'Chs')
        delete(GHandle.TempWindow.Chs);
        GHandle.TempWindow.Chs(2:end) = [];
    end 
    activeMask = [];
    for ss = 1:1:nSrc
        for dd = 1:1:nDet
            spam = strcmp(GHandle.TempWindow.SourceList.String(ss), {GHandle.TempWindow.LandMark.Tag});
            tempSrc = [GHandle.TempWindow.LandMark(spam).XData GHandle.TempWindow.LandMark(spam).YData GHandle.TempWindow.LandMark(spam).ZData];
            
            spam = strcmp(GHandle.TempWindow.DetectorList.String(dd), {GHandle.TempWindow.LandMark.Tag});
            tempDet = [GHandle.TempWindow.LandMark(spam).XData GHandle.TempWindow.LandMark(spam).YData GHandle.TempWindow.LandMark(spam).ZData];
            
            tempCh = (tempSrc+tempDet)/2;
            tempchanneldistance = norm(tempSrc-tempDet);
            roundFactor = 1;
            tempchanneldistance = round(tempchanneldistance*roundFactor)/roundFactor;
            
            GHandle.TempWindow.ChannelList.Data{cc,1} = ss;
            GHandle.TempWindow.ChannelList.Data{cc,2} = dd;
            if tempchanneldistance > str2double(GHandle.TempWindow.SDthreshold.String)
                GHandle.TempWindow.ChannelList.Data{cc,3} = tempchanneldistance;
                %GHandle.TempWindow.ChannelList.Data{cc,3} = colortextintable('"#FF0000"', num2str(tempchanneldistance));
                GHandle.TempWindow.ChannelList.Data{cc,4} = false;
            else
                GHandle.TempWindow.ChannelList.Data{cc,3} = tempchanneldistance;
                GHandle.TempWindow.ChannelList.Data{cc,4} = true;
            end
            
            shrinkFactor = 0.85; % between 0.5 (no line) and 1 (point to point)
            tempSrc2 = tempSrc - (tempSrc-tempDet)*shrinkFactor;
            tempDet2 = tempDet + (tempSrc-tempDet)*shrinkFactor;
            GHandle.TempWindow.Channels(cc) = plot3([tempSrc2(1) tempDet2(1)], [tempSrc2(2) tempDet2(2)], [tempSrc2(3) tempDet2(3)], ...
                'LineWidth', 2, ...
                'HitTest', 'off', ...
                'Color', 'k');
%             GHandle.TempWindow.Sources(cc) = text(tempSrc(1), tempSrc(2), tempSrc(3), ['  ' num2str(ss)], ...
%                 'FontWeight', 'bold', ...
%                 'FontSize', 10, ...
%                 'HitTest', 'off', ...
%                 'Color', sourceColor);
%             GHandle.TempWindow.Detectors(cc) = text(tempDet(1), tempDet(2), tempDet(3), ['  ' num2str(dd)], ...
%                 'FontWeight', 'bold', ...
%                 'FontSize', 10, ...
%                 'HitTest', 'off', ...
%                 'Color', detectorColor);
%             GHandle.TempWindow.Chs(cc) = text(tempCh(1), tempCh(2), tempCh(3), ['  ' num2str(cc)], ...
%                 'FontWeight', 'bold', ...
%                 'FontSize', 10, ...
%                 'HitTest', 'off', ...
%                 'Color', 'k');
            cc = cc + 1;
        end
    end
    %uistack(GHandle.TempWindow.Sources,'bottom');
    %uistack(GHandle.TempWindow.Detectors,'bottom');
    %uistack(GHandle.TempWindow.Chs,'bottom');
    if isfield(GHandle.TempWindow, 'Channels')
        if any(isvalid(GHandle.TempWindow.Channels))
            uistack(GHandle.TempWindow.Channels,'bottom');
        end
    end
    GHandle.TempWindow.Channels(~isvalid(GHandle.TempWindow.Channels)) = [];
    if cc > 1
        activeMask = ~logical(cell2mat(GHandle.TempWindow.ChannelList.Data(:,4)));
        C = cell(sum(activeMask),1);
        C(:) = {':'};
        set(GHandle.TempWindow.Channels(activeMask),{'LineStyle'}, C);
    end
end
end