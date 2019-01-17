function landmarkcallback(~,Evnt,GHandle)

pt = Evnt.IntersectionPoint;

matDimension = size(GHandle.TempWindow.SelectedAtlas.LandMarks.coord,1);
stepDim = (matDimension-21)/20;

XData = GHandle.TempWindow.SelectedAtlas.LandMarks.coord(:,:,1);
YData = GHandle.TempWindow.SelectedAtlas.LandMarks.coord(:,:,2);
ZData = GHandle.TempWindow.SelectedAtlas.LandMarks.coord(:,:,3);

dist = vecnorm(cat(3,XData-pt(1) ,YData-(pt(2)),ZData-(pt(3))),2,3);
[~, idxPoint] = min(dist(:));
[iPoint, jPoint] = ind2sub(size(dist),idxPoint);

%if GHandle.TempWindow.NewProbeZoomButton.Value
if GHandle.TempWindow.Zoom
    GHandle.TempWindow.Temp.CameraTarget = GHandle.TempWindow.NewProbeAxes.CameraTarget;
    GHandle.TempWindow.Temp.CameraPosition = GHandle.TempWindow.NewProbeAxes.CameraPosition;
    GHandle.TempWindow.Temp.CameraViewAngle = GHandle.TempWindow.NewProbeAxes.CameraViewAngle;
    GHandle.TempWindow.NewProbeAxes.CameraUpVectorMode = 'manual';
    
    GHandle.TempWindow.NewProbeAxes.CameraViewAngle = 1;
    GHandle.TempWindow.NewProbeAxes.CameraTarget = Evnt.IntersectionPoint;
    if GHandle.TempWindow.AtlasWidget.SelectedIndex == 1
        % toglierlo appena abbiamo il 2d  
    else
        iPointMin = max(iPoint-stepDim,1);
        iPointMax = min(iPoint+stepDim,matDimension);
        jPointMin = max(jPoint-stepDim,1);
        jPointMax = min(jPoint+stepDim,matDimension);
        
        GHandle.TempWindow.Mask.LandMark(iPointMin:iPointMax,jPointMin:jPointMax) = true;
    end
    GHandle.TempWindow.Zoom = false;
else
    GHandle.TempWindow.SourceList.Value = [];
    GHandle.TempWindow.DetectorList.Value = [];
    
    if GHandle.TempWindow.Mask.Source(idxPoint)
        GHandle.TempWindow.Mask.Source(idxPoint) = false;
        GHandle.TempWindow.Mask.Detector(idxPoint) = true;
        if GHandle.TempWindow.MirrorProbe.Value
            GHandle.TempWindow.Mask.Source(iPoint,end-jPoint+1) = false;
            GHandle.TempWindow.Mask.Detector(iPoint,end-jPoint+1) = true;
        end
    elseif GHandle.TempWindow.Mask.Detector(idxPoint)
        GHandle.TempWindow.Mask.Detector(idxPoint) = false;
        GHandle.TempWindow.Mask.LandMark(idxPoint) = true;
        if GHandle.TempWindow.MirrorProbe.Value
            GHandle.TempWindow.Mask.Detector(iPoint,end-jPoint+1) = false;
            GHandle.TempWindow.Mask.LandMark(iPoint,end-jPoint+1) = true;
        end
    elseif GHandle.TempWindow.Mask.LandMark(idxPoint)
        GHandle.TempWindow.Mask.LandMark(idxPoint) = false;
        GHandle.TempWindow.Mask.Source(idxPoint) = true;
        if GHandle.TempWindow.MirrorProbe.Value
            GHandle.TempWindow.Mask.LandMark(iPoint,end-jPoint+1) = false;
            GHandle.TempWindow.Mask.Source(iPoint,end-jPoint+1) = true;
        end  
    end 
end
tempplotfunc([],[],GHandle)
end