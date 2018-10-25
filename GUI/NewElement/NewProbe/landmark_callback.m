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
		pointTag = Handle.Tag;
		[iPoint, jPoint] = find(strcmp(GHandle.TempWindow.SelectedAtlas.LandMarks.names ,pointTag));
		iPointMin = max(iPoint-10,1);
		iPointMax = min(iPoint+10,101);
		jPointMin = max(jPoint-10,1);
		jPointMax = min(jPoint+10,101);
		
		pointGrid = combvec(iPointMin:iPointMax,jPointMin:jPointMax)';
		
		nearPoint = GHandle.TempWindow.SelectedAtlas.LandMarks.coord(pointGrid(:,1),pointGrid(:,2),:);
		GHandle.TempWindow.NewProbeAxes.CameraPosition = 33.*Evnt.IntersectionPoint;
		
		
		
		for iNearPoins = 1 : (size(nearPoins,1)
			GHandle.TempWindow.LandMark(iNearPoins) = plot3(...
				nearPoins(iNearPoins,1), nearPoins(iNearPoins,2), nearPoins(iNearPoins,3), ...
				'tag',['Near', pointTag, num2str(iNearPoins)], ...
				'MarkerSize',10, ...
				'ButtonDownFcn',{@(Handle,Evnt)landmark_callback(Handle,Evnt,GHandle)}, ...
				'LineStyle', 'none', ...
				'Visible', 'on', ...
				'Marker','.', ...
				'Color','g', ...
				'Parent', GHandle.TempWindow.NewProbeAxes);
		end
		
	end
	
	
	GHandle.TempWindow.Zoom = false;
else
	if all(Handle.Color == markColor)
		Handle.Color = 'r';
		GHandle.TempWindow.SourceList.String = [GHandle.TempWindow.SourceList.String; {Handle.Tag}];
		GHandle.TempWindow.SourceList.UserData = [GHandle.TempWindow.SourceList.UserData; find(Handle == GHandle.TempWindow.LandMark)];
	elseif all(Handle.Color == sourceColor)
		Handle.Color = 'b';
		GHandle.TempWindow.SourceList.String(strcmp(GHandle.TempWindow.SourceList.String, {Handle.Tag})) = [];
		idxLine = find(GHandle.TempWindow.LandMark == Handle);
		GHandle.TempWindow.SourceList.UserData(GHandle.TempWindow.SourceList.UserData == idxLine) = [];
		GHandle.TempWindow.DetectorList.String = [GHandle.TempWindow.DetectorList.String; {Handle.Tag}];
		GHandle.TempWindow.DetectorList.UserData = [GHandle.TempWindow.DetectorList.UserData ;idxLine];
	elseif all(Handle.Color == detectorColor)
		Handle.Color = 'g';
		idxLine = find(GHandle.TempWindow.LandMark == Handle);
		GHandle.TempWindow.DetectorList.String(strcmp(GHandle.TempWindow.DetectorList.String, {Handle.Tag})) = [];
		GHandle.TempWindow.DetectorList.UserData(GHandle.TempWindow.DetectorList.UserData == idxLine) = [];
	else
		error('404 color not found')
	end
	
end
end