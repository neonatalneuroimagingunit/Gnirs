function loadigfigure(GHandle)
% create a figure that is not visible yet, and has minimal titlebar properties

GHandle.TempWindow.LoadingFigure = figure('Visible','off',...
						'MenuBar','none',...
						'NumberTitle','off',...
						'Position',[0,0,GHandle.Preference.Screen.size(3:4)]./8);

% put an axes in it

GHandle.TempWindow.LoadingAxes = axes('Parent',GHandle.TempWindow.LoadingFigure,...
									'Visible','off');

GHandle.TempWindow.LoadingImagine = imshow('loading.jpg',...
						'parent',GHandle.TempWindow.LoadingAxes);

% set the figure size to be just big enough for the image, and centered at
% the center of the screen
set(GHandle.TempWindow.LoadingAxes,...
	'Unit','Normalized','Position',[0,0,1,1]);

figPos = [0, 0, GHandle.TempWindow.LoadingImagine.XData(2),...
			GHandle.TempWindow.LoadingImagine.YData(2)];
		
set(GHandle.TempWindow.LoadingFigure,'Position',figPos);
movegui(GHandle.TempWindow.LoadingFigure,'center')

% make the figure visible

set(GHandle.TempWindow.LoadingFigure,'Visible','on');


end

