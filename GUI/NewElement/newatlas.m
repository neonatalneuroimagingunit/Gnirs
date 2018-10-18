function newatlas(~, ~, GHandle)	

	figureSize = GHandle.Preference.Figure.sizeMedium;


	GHandle.TempWindow.NewAtlasFigure = figure(...
	'position', figureSize,...
    'Resize', 'on',...
    'Name', 'New NIRS Atlas', ...
    'Numbertitle', 'off', ...
    'Toolbar', 'none', ...
    'Menubar', 'none', ...
    'DoubleBuffer', 'on', ...
    'DockControls', 'off', ...
    'Renderer', 'OpenGL',...
	'Visible', 'off' ...
	);

GHandle.TempWindow.NewAtlasWidget = uiw.widget.FolderSelector(...
	'Value', '', ...
	'Parent',GHandle.TempWindow.NewAtlasFigure,...
	'Callback',@(handle,evnt)atlas_widget_callback(handle,evnt,GHandle),...
	'Label','Select the Atlas Directory',...
    'LabelLocation','top',...
	'Units','normalized',...
	'Position',[0.05 0.6 0.65 0.13]);

	
	GHandle.TempWindow.NewAtlasName = uiw.widget.EditableText(...      
    'Parent',GHandle.TempWindow.NewAtlasFigure,...=
    'Value','Insert Name',...
    'Label','Atlas Name:',...
    'LabelLocation','top',...
    'LabelWidth',90,...
    'Units','normalized',...
    'Position',[0.05 0.80 0.35 0.15]);

	GHandle.TempWindow.NewAtlasNote = uiw.widget.EditableText(...      
    'Parent',GHandle.TempWindow.NewAtlasFigure,...
    'Value','Insert Note',...
    'Label','Atlas Note:',...
	'IsMultiLine', 1,...
    'LabelLocation','top',...
    'LabelWidth',90,...
    'Units','normalized',...
    'Position',[0.50 0.05 0.25 0.45]);
sizeRatio = 3;

[~,~,GHandle.TempWindow.GrayMatter ]= gtextedit( GHandle.TempWindow.NewAtlasFigure,...
				'Gray Matter', [0.1 0.30 0.4 0.05],0.1,sizeRatio,'horizontal',1);


[~,~,GHandle.TempWindow.WhiteMatter ]= gtextedit( GHandle.TempWindow.NewAtlasFigure,...
				'White Matter', [0.1 0.25 0.4 0.05],0.1,sizeRatio,'horizontal',1);


[~,~,GHandle.TempWindow.Scalp ]= gtextedit( GHandle.TempWindow.NewAtlasFigure,...
				'Scalp', [0.1 0.2 0.4 0.05],0.1,sizeRatio,'horizontal',1);

[~,~,GHandle.TempWindow.Voxel ]= gtextedit( GHandle.TempWindow.NewAtlasFigure,...
				'Voxel', [0.1 0.15 0.4 0.05],0.1,sizeRatio,'horizontal',1);
			
[~,~,GHandle.TempWindow.HeadVolumeMesh ]= gtextedit( GHandle.TempWindow.NewAtlasFigure,...
				'Head Volume', [0.1 0.1 0.4 0.05],0.1,sizeRatio,'horizontal',1);
			
[~,~,GHandle.TempWindow.LandMarks ]= gtextedit( GHandle.TempWindow.NewAtlasFigure,...
				'Landmarks', [0.1 0.05 0.4 0.05],0.1,sizeRatio,'horizontal',1);
								
				
				
	GHandle.TempWindow.NewAtlasLoadButton = uicontrol('Style', 'pushbutton',...	
    'Parent', GHandle.TempWindow.NewAtlasFigure, ...
	'String', 'Load',...
	'Units', 'normalize', ...
	'Position', [0.8 0.15 0.2 0.1],...
	'Callback', {@load_atlas ,GHandle}...
	); 

	GHandle.TempWindow.NewAtlasFigure.Visible = 'on';

end


function atlas_widget_callback(~,Evnt, GHandle)
fileList = dir(Evnt.NewValue);

fileIdx = contains({fileList.name}, 'GMSurfaceMesh');
if any(fileIdx)
	GHandle.TempWindow.GrayMatter.String = '√';
	GHandle.TempWindow.GrayMatter.ForegroundColor = [0 1 0 ];
else
	GHandle.TempWindow.GrayMatter.String = 'X';
	GHandle.TempWindow.GrayMatter.ForegroundColor = [1 0 0 ];
end

fileIdx = contains({fileList.name}, 'ScalpSurfaceMesh');
if any(fileIdx)
	GHandle.TempWindow.Scalp.String = '√';
	GHandle.TempWindow.Scalp.ForegroundColor = [0 1 0 ];
else
	GHandle.TempWindow.Scalp.String = 'X';
	GHandle.TempWindow.Scalp.ForegroundColor = [1 0 0 ];
end

fileIdx = contains({fileList.name}, 'WMSurfaceMesh');
if any(fileIdx)
	GHandle.TempWindow.WhiteMatter.String = '√';
	GHandle.TempWindow.WhiteMatter.ForegroundColor = [0 1 0 ];
else
	GHandle.TempWindow.WhiteMatter.String = 'X';
	GHandle.TempWindow.WhiteMatter.ForegroundColor = [1 0 0 ];
end


fileIdx = contains({fileList.name}, 'TissueMask');
if any(fileIdx)
	GHandle.TempWindow.Voxel.String = '√';
	GHandle.TempWindow.Voxel.ForegroundColor = [0 1 0 ];
else
	GHandle.TempWindow.Voxel.String = 'X';
	GHandle.TempWindow.Voxel.ForegroundColor = [1 0 0 ];
end

fileIdx = contains({fileList.name}, 'HeadVolumeMesh');
if any(fileIdx)
	GHandle.TempWindow.HeadVolumeMesh.String = '√';
	GHandle.TempWindow.HeadVolumeMesh.ForegroundColor = [0 1 0 ];
else
	GHandle.TempWindow.HeadVolumeMesh.String = 'X';
	GHandle.TempWindow.HeadVolumeMesh.ForegroundColor = [1 0 0 ];
end


fileIdx = contains({fileList.name}, 'LandmarkPoints');
if any(fileIdx)
	GHandle.TempWindow.LandMarks.String = '√';
	GHandle.TempWindow.LandMarks.ForegroundColor = [0 1 0 ];
else
	GHandle.TempWindow.LandMarks.String = 'X';
	GHandle.TempWindow.LandMarks.ForegroundColor = [1 0 0 ];
end



end

function load_atlas(~,~, GHandle)
	%add a tree branch
	GHandle.TempWindow.loadingBar.GrayMatter = LoadingBar;
	GHandle.TempWindow.loadingBar.WhiteMatter = LoadingBar;
	GHandle.TempWindow.loadingBar.Scalp = LoadingBar;
	GHandle.TempWindow.loadingBar.Voxel = LoadingBar;
	GHandle.TempWindow.loadingBar.HeadVolume = LoadingBar;
	GHandle.TempWindow.loadingBar.LandMarks = LoadingBar;
	
	addlistener(GHandle.TempWindow.loadingBar.GrayMatter,'LoadingPerc','PostSet',@(src,evnt)loading_graymatter(src,evnt,GHandle));
	addlistener(GHandle.TempWindow.loadingBar.WhiteMatter,'LoadingPerc','PostSet',@(src,evnt)loading_whitematter(src,evnt,GHandle));
	addlistener(GHandle.TempWindow.loadingBar.Scalp,'LoadingPerc','PostSet',@(src,evnt)loading_scalp(src,evnt,GHandle));
	addlistener(GHandle.TempWindow.loadingBar.Voxel,'LoadingPerc','PostSet',@(src,evnt)loading_voxel(src,evnt,GHandle));
	addlistener(GHandle.TempWindow.loadingBar.HeadVolume,'LoadingPerc','PostSet',@(src,evnt)loading_headvolume(src,evnt,GHandle));
	addlistener(GHandle.TempWindow.loadingBar.LandMarks,'LoadingPerc','PostSet',@(src,evnt)loading_landmarks(src,evnt,GHandle));
	
	GHandle.TempWindow.loadingBar.GrayMatter.LoadingPerc = 0;
	GHandle.TempWindow.loadingBar.WhiteMatter.LoadingPerc = 0;
	GHandle.TempWindow.loadingBar.Scalp.LoadingPerc = 0;
	GHandle.TempWindow.loadingBar.Voxel.LoadingPerc = 0;
	GHandle.TempWindow.loadingBar.HeadVolume.LoadingPerc = 0;
	GHandle.TempWindow.loadingBar.LandMarks.LoadingPerc = 0;
	
	
	name = GHandle.TempWindow.NewAtlasName.Value;
	note = GHandle.TempWindow.NewAtlasNote.Value;
	GHandle.TempWindow.location = GHandle.TempWindow.NewAtlasWidget.Value;
	
	
	loadatlasfrommat(GHandle);
	close(GHandle.TempWindow.NewAtlasFigure);
	
	GHandle.CurrentDataSet.Atlas.name = name;
	GHandle.CurrentDataSet.Atlas.note = note;
	
	DataBase = GHandle.DataBase.add(GHandle.CurrentDataSet.Atlas, name, GHandle.Temp);
	GHandle.DataBase = DataBase;
	tree(GHandle);
	GHandle.TempWindow = [];
	
	GHandle.Main.Tree.TabGroup.SelectedTab = GHandle.Main.Tree.AtlasTab;
end


function loading_graymatter(~,evnt,GHandle)
	if (evnt.AffectedObject.LoadingPerc < 1)
		ii = round(10 * evnt.AffectedObject.LoadingPerc);
	else
		ii = 10;
	end
	GHandle.TempWindow.GrayMatter.String =  [repmat(char(9608),[1 ii]) repmat(char(9618),[1 10-ii])];
	drawnow;
end

function loading_whitematter(~,evnt,GHandle)
	if (evnt.AffectedObject.LoadingPerc < 1)
		ii = round(10 * evnt.AffectedObject.LoadingPerc);
	else
		ii = 10;
	end
	GHandle.TempWindow.WhiteMatter.String =  [repmat(char(9608),[1 ii]) repmat(char(9618),[1 10-ii])];
	drawnow;
end

function loading_scalp(~,evnt,GHandle)
	if (evnt.AffectedObject.LoadingPerc < 1)
		ii = round(10 * evnt.AffectedObject.LoadingPerc);
	else
		ii = 10;
	end
	GHandle.TempWindow.Scalp.String =  [repmat(char(9608),[1 ii]) repmat(char(9618),[1 10-ii])];
	drawnow;
end

function loading_voxel(~,evnt,GHandle)
	if (evnt.AffectedObject.LoadingPerc < 1)
		ii = round(10 * evnt.AffectedObject.LoadingPerc);
	else
		ii = 10;
	end
	GHandle.TempWindow.Voxel.String =  [repmat(char(9608),[1 ii]) repmat(char(9618),[1 10-ii])];
	drawnow;
end

function loading_headvolume(~,evnt,GHandle)
	if (evnt.AffectedObject.LoadingPerc < 1)
		ii = round(10 * evnt.AffectedObject.LoadingPerc);
	else
		ii = 10;
	end
	GHandle.TempWindow.HeadVolumeMesh.String =  [repmat(char(9608),[1 ii]) repmat(char(9618),[1 10-ii])];
	drawnow;
end

function loading_landmarks(~,evnt,GHandle)
	if (evnt.AffectedObject.LoadingPerc < 1)
		ii = round(10 * evnt.AffectedObject.LoadingPerc);
	else
		ii = 10;
	end
	GHandle.TempWindow.LandMarks.String =  [repmat(char(9608),[1 ii]) repmat(char(9618),[1 10-ii])];
	drawnow;
end













