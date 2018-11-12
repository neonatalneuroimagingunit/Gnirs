function atlaswidgetcallback(Handle, Event, GHandle)
atlasScaleFactor = 0.98;
scalpColor = GHandle.Preference.Theme.scalpColor;


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
%% aggiungere un atlas 2d

    else
        Atlas = Handle.UserData{selectedAtlas}.load;
        GHandle.TempWindow.SelectedAtlas = Atlas;
        GHandle.TempWindow.Mask.LandMark = false(size(Atlas.LandMarks.names));
        GHandle.TempWindow.Mask.Source = false(size(Atlas.LandMarks.names));
        GHandle.TempWindow.Mask.Detector = false(size(Atlas.LandMarks.names));
        
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

        
        idxM = reshape(bsxfun(@plus,(1:5:101),(0:505:10100)'),1,[]);
        idxM(cellfun(@isempty, Atlas.LandMarks.names(idxM))) = [];
       
        GHandle.TempWindow.Mask.LandMark(idxM) = true;
       
        tempplotfunc(GHandle)

     end
else
    idx = contains(Handle.UserData.tag, Event.NewString);
    Handle.Items = Handle.UserData.tag(idx);
end

end