function atlas_widget_callback(Handle, Event, GHandle)
atlasScaleFactor = 0.98;
%scalpColor = [255 229 204]./255;
scalpColor = [200 200 200]./255;
selectedAtlas = Event.NewSelectedIndex;
GHandle.TempWindow.NewProbeAxes.CameraTargetMode = 'auto';
GHandle.TempWindow.NewProbeAxes.CameraPositionMode = 'auto';
GHandle.TempWindow.NewProbeAxes.CameraUpVectorMode = 'auto';
GHandle.TempWindow.NewProbeAxes.CameraViewAngleMode = 'auto';

if any(selectedAtlas)
	GHandle.TempWindow.SourceList.String = [];
    GHandle.TempWindow.DetectorList.String = [];
	GHandle.TempWindow.ChannelList.Data = {};
    GHandle.TempWindow.SourceList.UserData = [];
    GHandle.TempWindow.DetectorList.UserData = [];
    
    if (selectedAtlas == 1) % 2D
        GHandle.TempWindow.NewProbeRotateButton.Enable = 'off';
        GHandle.TempWindow.NewProbeZoomButton.Enable = 'on';
        cla(GHandle.TempWindow.NewProbeAxes);
        GHandle.TempWindow.NewProbeAxes.View = [0 90];
        x = -50:1:50;
        y = -50:1:50;
        [X,Y] = meshgrid(x,y);
        X2 = X(1:10:end,1:10:end);
        Y2 = Y(1:10:end,1:10:end);
        X2 = X2(:);
        Y2 = Y2(:);
		
		nLandMark = size(X2,1);
        if isfield(GHandle.TempWindow, 'LandMark') % empty the unused landmarks
            GHandle.TempWindow.LandMark(nLandMark+1:end) = [];
        end

        for iLandMark = 1:1:nLandMark
            GHandle.TempWindow.LandMark(iLandMark) = plot3(X2(iLandMark),Y2(iLandMark), 1, ...
                'tag', [num2str(X2(iLandMark)) ',' num2str(Y2(iLandMark))],...
                'LineStyle', 'none',...
                'Marker','.',...
                'Color','g',...
                'MarkerSize', 20, ...
                'ButtonDownFcn',{@(Handle,Evnt)landmark_callback(Handle,Evnt,GHandle)}, ...
                'Parent', GHandle.TempWindow.NewProbeAxes, ...
                'Visible', 'on');
        end
    else
        Atlas = Handle.UserData{selectedAtlas}.load;
		GHandle.TempWindow.SelectedAtlas = Atlas;
        
        GHandle.TempWindow.NewProbeRotateButton.Enable = 'on';
        GHandle.TempWindow.NewProbeZoomButton.Enable = 'on';
        
        cla(GHandle.TempWindow.NewProbeAxes);
        axis(GHandle.TempWindow.NewProbeAxes,'vis3d');
        axis(GHandle.TempWindow.NewProbeAxes,'equal');
        
        GHandle.TempWindow.Scalp = trisurf(...
            Atlas.Scalp.face,...
            atlasScaleFactor.*Atlas.Scalp.node(:,1),...
            atlasScaleFactor.*Atlas.Scalp.node(:,2),...
            atlasScaleFactor.*Atlas.Scalp.node(:,3),...
            ones(size(Atlas.Scalp.node(:,3))),...
            'HitTest','on',...
            'Parent', GHandle.TempWindow.NewProbeAxes,...
            'EdgeColor','none',...
            'FaceColor',scalpColor, ...
            'FaceAlpha', 0.8);
        
        x = reshape(Atlas.LandMarks.coord(:,:,1), [],1);
        y = reshape(Atlas.LandMarks.coord(:,:,2), [],1);
        z = reshape(Atlas.LandMarks.coord(:,:,3), [],1);
        landmarkNames = reshape(Atlas.LandMarks.names, [], 1);
        
		nLandMark = size(landmarkNames,1);
        if isfield(GHandle.TempWindow, 'LandMark') % empty the unused landmarks
            GHandle.TempWindow.LandMark(nLandMark+1:end) = [];
        end
		
        for iLandMark = 1 : nLandMark
            if ~isempty(landmarkNames{iLandMark})
                GHandle.TempWindow.LandMark(iLandMark) = plot3(...
                    x(iLandMark), y(iLandMark), z(iLandMark), ...
                    'tag',landmarkNames{iLandMark}, ...
                    'MarkerSize',20, ...
                    'ButtonDownFcn',{@(Handle,Evnt)landmark_callback(Handle,Evnt,GHandle)}, ...
                    'LineStyle', 'none', ...
                    'Visible', 'on', ...
                    'Marker','.', ...
                    'Color','g', ...
                    'Parent', GHandle.TempWindow.NewProbeAxes);
            end
        end
       
    end
else
	idx = contains(Handle.UserData.tag, Event.NewString);
	Handle.Items = {Handle.UserData.tag{idx}};
end

end