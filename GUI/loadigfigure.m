function loadigfigure(GHandle)
% create a figure that is not visible yet, and has minimal titlebar properties

GHandle.Loading.Figure = figure('Visible','off',...
						'MenuBar','none',...
						'NumberTitle','off',...
						'Position',[0,0,GHandle.Preference.Screen.size(3:4)]./8);

% put an axes in it

GHandle.Loading.Axes = axes('Parent',GHandle.Loading.Figure,...
									'Visible','off');

GHandle.Loading.Imagine = imshow('loading.jpg',...
						'parent',GHandle.Loading.Axes);

% set the figure size to be just big enough for the image, and centered at
% the center of the screen
set(GHandle.Loading.Axes,...
	'Unit','Normalized','Position',[0,0,1,1]);

figPos = [0, 0, GHandle.Loading.Imagine.XData(2),...
			GHandle.Loading.Imagine.YData(2)];
		
set(GHandle.Loading.Figure,'Position',figPos);
movegui(GHandle.Loading.Figure,'center')

% make the figure visible

set(GHandle.Loading.Figure,'Visible','on');


end

