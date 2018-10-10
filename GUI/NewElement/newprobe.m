function newprobe(~, ~, GHandle)

figureSize = GHandle.Preference.Figure.sizeLarge;
AtlasList = GHandle.DataBase.Atlas;
axesBackgroundColor = 'k';

GHandle.TempWindow.NewProbeFigure = figure(...
    'position', figureSize,...
    'Resize', 'on',...
    'Name', 'New NIRS Probe', ...
    'Numbertitle', 'off', ...
    'Toolbar', 'none', ...
    'Menubar', 'none', ...
    'DoubleBuffer', 'on', ...
    'DockControls', 'off', ...
    'Renderer', 'OpenGL',...
    'Visible', 'off' ...
    );

GHandle.TempWindow.NewProbeName = uiw.widget.EditableText(...
    'Parent',GHandle.TempWindow.NewProbeFigure,...=
    'Value','Insert Name',...
    'Label','Probe Name:',...
    'LabelLocation','top',...
    'LabelWidth',90,...
    'Units','normalized',...
    'Position',[0.05 0.90 0.15 0.08]);

GHandle.TempWindow.NewProbeNote = uiw.widget.EditableText(...
    'Parent',GHandle.TempWindow.NewProbeFigure,...
    'Value','Insert Note',...
    'Label','Probe Note:',...
    'IsMultiLine', 1,...
    'LabelLocation','top',...
    'LabelWidth',90,...
    'Units','normalized',...
    'Position',[0.05 0.5 0.20 0.20]);


GHandle.TempWindow.NewProbeLoadButton = uicontrol('Style', 'pushbutton',...
    'Parent', GHandle.TempWindow.NewProbeFigure, ...
    'String', 'Load',...
    'Units', 'normalize', ...
    'Position', [0.85 0.05 0.1 0.05],...
    'Callback', {@load_probe ,GHandle}...
    );

GHandle.TempWindow.NewProbeRotateButton = uicontrol('Style', 'togglebutton',...
    'Parent', GHandle.TempWindow.NewProbeFigure, ...
    'String', 'Rotate',...
    'Visible','off',...
    'Units', 'normalize', ...
    'Position', [0.75 0.05 0.1 0.05],...
    'Callback', {@rotate_Atlas ,GHandle}...
    );

GHandle.TempWindow.NewProbeZoomButton = uicontrol('Style', 'togglebutton',...
    'Parent', GHandle.TempWindow.NewProbeFigure, ...
    'String', 'Zoom',...
    'Visible','off',...
    'Units', 'normalize', ...
    'Position', [0.65 0.05 0.1 0.05],...
    'Callback', {@zoom_Atlas ,GHandle}...
    );

GHandle.TempWindow.AtlasWidget = uiw.widget.EditablePopup(...
    'Parent',GHandle.TempWindow.NewProbeFigure,...
    'Items', ['2D Probe',{AtlasList.tag}],...
    'UserData',[{'NoAtlas'}, {AtlasList}],...  % fix here, cat does not work properly
    'Label','Atlas',...
    'LabelLocation','top',...
    'Callback',@(Handle,Event)atlas_widget_callback(Handle,Event,GHandle),...
    'Units','normalized',...
    'Position',[0.05 0.75 0.2 0.1]);

GHandle.TempWindow.SourceListTitle = uicontrol('Style', 'text',...
    'Parent', GHandle.TempWindow.NewProbeFigure, ...
    'String', 'Sources',...
    'Visible','on',...
    'Units', 'normalize', ...
    'HorizontalAlignment', 'left', ...
    'Position', [0.27 0.9 0.08 0.02]);

GHandle.TempWindow.DetectorListTitle = uicontrol('Style', 'text',...
    'Parent', GHandle.TempWindow.NewProbeFigure, ...
    'String', 'Detectors',...
    'Visible','on',...
    'Units', 'normalize', ...
    'HorizontalAlignment', 'left', ...
    'Position', [0.38 0.9 0.08 0.02]);

GHandle.TempWindow.SourceList = uicontrol(...
    'Parent', GHandle.TempWindow.NewProbeFigure, ...
    'Style','listbox',...
    'Units', 'normalize', ...
    'Max', 2,...
    'Position',  [0.27 0.5 0.08 0.40],...
    'String',[],...
    'Value',[]);

GHandle.TempWindow.DetectorList = uicontrol(...
    'Parent', GHandle.TempWindow.NewProbeFigure, ...
    'Style','listbox',...
    'Units', 'normalize', ...
    'Max', 2,...
    'Position',  [0.36 0.5 0.08 0.40],...
    'String',[],...
    'Value',[]);

GHandle.TempWindow.ChannelListTitle = uicontrol('Style', 'text',...
    'Parent', GHandle.TempWindow.NewProbeFigure, ...
    'String', 'Channels',...
    'Visible','on',...
    'Units', 'normalize', ...
    'HorizontalAlignment', 'left', ...
    'Position', [0.05 0.45 0.39 0.02]);

GHandle.TempWindow.ChannelList = uitable(...
    'Parent', GHandle.TempWindow.NewProbeFigure, ...
    'Units', 'normalize', ...
    'Data', {}, ...
    'ColumnName', {'S', 'D', 'SD distance (mm)', 'Active'}, ...
    'ColumnEditable',[false false false true], ...
    'ColumnWidth', {50 50 150 50}, ...
    'ColumnFormat', {'numeric', 'numeric', 'numeric', 'logical'}, ...
    'Position',  [0.05 0.05 0.39 0.40]);

GHandle.TempWindow.SgaPuffoPanel = uipanel(...
    'Parent',GHandle.TempWindow.NewProbeFigure,...
    'BackgroundColor', axesBackgroundColor, ...
    'Units', 'normalize', ...
    'Position',[0.5 0.2 0.45 0.75],...
    'BorderType', 'none');

GHandle.TempWindow.NewProbeAxes = axes(...
    'Parent',GHandle.TempWindow.SgaPuffoPanel,...
    'Units', 'normalize', ...
    'Position',[0 0 1 1],...
    'NextPlot','add',...
    'Visible', 'off');

GHandle.TempWindow.light(1) = light(GHandle.TempWindow.NewProbeAxes,...
    'Position',[100 0 0]);
GHandle.TempWindow.light(2) = light(GHandle.TempWindow.NewProbeAxes,...
    'Position',[-100 0 0]);

GHandle.TempWindow.NewProbeFigure.Visible = 'on';

end


function load_probe(~, ~, GHandle )
probeName = GHandle.TempWindow.NewProbeName.Value;
note = GHandle.TempWindow.NewProbeNote.Value;

NewProbe = NirsProbe('name', probeName, 'note', note);

DataBase = GHandle.DataBase.add(NewProbe);

GHandle.DataBase = DataBase;

tree(GHandle);

GHandle.Main.Tree.TabGroup.SelectedTab = GHandle.Main.Tree.ProbeTab;
end

function atlas_widget_callback(Handle, Event, GHandle)
atlasScaleFactor = 0.98;
%scalpColor = [255 229 204]./255;
scalpColor = [200 200 200]./255;
selectedAtlas = Event.NewSelectedIndex;
if any(selectedAtlas)
	GHandle.TempWindow.SourceList.String = [];
	GHandle.TempWindow.ChannelList.Data = {};
	GHandle.TempWindow.DetectorList.String = [];
    if (selectedAtlas == 1)
        GHandle.TempWindow.NewProbeRotateButton.Visible = 'off';
        cla(GHandle.TempWindow.NewProbeAxes);
        GHandle.TempWindow.NewProbeAxes.View = [0 90];
    else
        %Atlas = Handle.UserData{selectedAtlas}.load;
        Atlas = Handle.UserData{2}(selectedAtlas-1).load; % temporary fix (see line 69, this file)
        
        GHandle.TempWindow.NewProbeRotateButton.Visible = 'on';
        GHandle.TempWindow.NewProbeZoomButton.Visible = 'on';
        
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
        
        for iLandMark = 1 : size(Atlas.LandMarks.coordinates,1)
            GHandle.TempWindow.LandMark(iLandMark) = plot3(...
                Atlas.LandMarks.coordinates(iLandMark,1),...
                Atlas.LandMarks.coordinates(iLandMark,2),...
                Atlas.LandMarks.coordinates(iLandMark,3),...
                'tag', Atlas.LandMarks.names{iLandMark},...
                'MarkerSize',20,...
                'ButtonDownFcn',{@(Handle,Evnt)landmark_callback(Handle,Evnt,GHandle)},...
                'LineStyle', 'none',...
                'Visible', 'on',...
                'Marker','.',...
                'Color','g',...
                'Parent', GHandle.TempWindow.NewProbeAxes);
        end
        
        %
        % 		GHandle.TempWindow.LandMarkText = text(...
        % 				Atlas.LandMarks.coordinates(:,1),...
        % 				Atlas.LandMarks.coordinates(:,2),...
        % 				Atlas.LandMarks.coordinates(:,3),...
        % 				Atlas.LandMarks.names,...
        % 				'HitTest','off');
    end
else %inserire ricerca atlas
end

end

function landmark_callback(Handle,Evnt,GHandle)
markColor = [0 1 0];
sourceColor = [1 0 0];
detectorColor = [0 0 1];
distanceThreshold = 30;

colortextintable = @(colorintable,textintable) ['<html><font color=',colorintable,'>',textintable,'</font></html>'];

if GHandle.TempWindow.NewProbeZoomButton.Value
    
    GHandle.TempWindow.Temp.CameraTarget = GHandle.TempWindow.NewProbeAxes.CameraTarget;
    GHandle.TempWindow.Temp.CameraPosition = GHandle.TempWindow.NewProbeAxes.CameraPosition;
    GHandle.TempWindow.Temp.CameraViewAngle = GHandle.TempWindow.NewProbeAxes.CameraViewAngle;
    
    GHandle.TempWindow.NewProbeAxes.CameraTarget = Evnt.IntersectionPoint;
    GHandle.TempWindow.NewProbeAxes.CameraPosition = 33.*Evnt.IntersectionPoint;
    GHandle.TempWindow.NewProbeAxes.CameraViewAngle = 1;
    
%     n = 9;
%     [xs, index] = sort(x);
%     result      = x(sort(index(1:n)))
    
    
    
    
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
	end
    if isfield(GHandle.TempWindow,'Sources')
        delete(GHandle.TempWindow.Sources);
    end
    if isfield(GHandle.TempWindow,'Detectors')
        delete(GHandle.TempWindow.Detectors);
    end
    if isfield(GHandle.TempWindow,'Chs')
        delete(GHandle.TempWindow.Chs);
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
            
            %tempdatatable{cc,1:3} = {ss dd tempchanneldistance};
            %tempdatatable{cc,4} = true;
            GHandle.TempWindow.ChannelList.Data{cc,1} = ss;
            GHandle.TempWindow.ChannelList.Data{cc,2} = dd;
            if tempchanneldistance > distanceThreshold
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
            GHandle.TempWindow.Sources(cc) = text(tempSrc(1), tempSrc(2), tempSrc(3), ['  ' num2str(ss)], ...
                'FontWeight', 'bold', ...
                'FontSize', 10, ...
                'HitTest', 'off', ...
                'Color', sourceColor);
            GHandle.TempWindow.Detectors(cc) = text(tempDet(1), tempDet(2), tempDet(3), ['  ' num2str(dd)], ...
                'FontWeight', 'bold', ...
                'FontSize', 10, ...
                'HitTest', 'off', ...
                'Color', detectorColor);
            GHandle.TempWindow.Chs(cc) = text(tempCh(1), tempCh(2), tempCh(3), ['  ' num2str(cc)], ...
                'FontWeight', 'bold', ...
                'FontSize', 10, ...
                'HitTest', 'off', ...
                'Color', 'k');
            cc = cc + 1;
        end
    end
%     if cc > 1
%         activeMask = ~logical(cell2mat(GHandle.TempWindow.ChannelList.Data(:,4)));
%         C = cell(sum(activeMask),1);
%         C(:) = {'none'};
%         set(GHandle.TempWindow.Channels(activeMask),{'LineStyle'}, C);
%     end
end
end


function rotate_Atlas(Handle, ~, GHandle)
if Handle.Value
    rotate3d(GHandle.TempWindow.NewProbeAxes, 'on');
else
    rotate3d(GHandle.TempWindow.NewProbeAxes, 'off');
end
end

function zoom_Atlas(Handle, ~, GHandle)
if Handle.Value
    Handle.String = 'Zoom Out';
    GHandle.TempWindow.NewProbeRotateButton.Value = 0;
    rotate3d(GHandle.TempWindow.NewProbeAxes, 'off');
    
else
    Handle.String = 'Zoom In';
    GHandle.TempWindow.NewProbeAxes.CameraTarget = GHandle.TempWindow.Temp.CameraTarget;
    GHandle.TempWindow.NewProbeAxes.CameraPosition = GHandle.TempWindow.Temp.CameraPosition;
    GHandle.TempWindow.NewProbeAxes.CameraViewAngle = GHandle.TempWindow.Temp.CameraViewAngle;
    
end
end


