function atlaswidgetcallback(Handle, Event, GHandle)

scalpColor = GHandle.Preference.Theme.scalpColor;
scalpColor = [0.85 0.85 0.85]; % fix this in the future
scalpAlpha = 0.8;

%selectedAtlas = Event.NewSelectedIndex;
selectedAtlas = Event.Source.Value;
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
    
    if (selectedAtlas == 1)
        atlasScaleFactor = 1;
    else
        atlasScaleFactor = 0.98;
    end
    %Atlas = GHandle.UserData{selectedAtlas}.load;
    Atlas = GHandle.DataBase.Atlas(selectedAtlas).load;
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
        'HitTest', 'on',...
        'Parent', GHandle.TempWindow.NewProbeAxes,...
        'EdgeColor', 'none',...
        'FaceColor', scalpColor, ...
        'FaceAlpha', scalpAlpha, ...
        'SpecularStrength', 0.2, ...
        'FaceLighting', 'gouraud');
    
    GHandle.TempWindow.light(1) = light(GHandle.TempWindow.NewProbeAxes,...
        'Position',[100 0 50]);
    GHandle.TempWindow.light(2) = light(GHandle.TempWindow.NewProbeAxes,...
        'Position',[-100 0 50]);
    
    stepIdx = linspace(1,size(Atlas.LandMarks.coord,1),21);
    GHandle.TempWindow.Mask.LandMark(stepIdx,stepIdx) = true;
    
    tempplotfunc([],[],GHandle)
    
else
    idx = contains(Handle.UserData.tag, Event.NewString);
    Handle.Items = Handle.UserData.tag(idx);
end

end