function MainHandle = loadigfigure(MainHandle)
% create a figure that is not visible yet, and has minimal titlebar properties

MainHandle.LoadingFigure.MainFigure = figure('Visible','off',...
						'MenuBar','none',...
						'NumberTitle','off',...
						'Position',[0,0,MainHandle.screenSize(3:4)]./8);

% put an axes in it

MainHandle.LoadingFigure.Axes = axes('Parent',MainHandle.LoadingFigure.MainFigure,...
									'Visible','off');

MainHandle.LoadingFigure.Imagine = imshow('loading.jpg',...
						'parent',MainHandle.LoadingFigure.Axes);

% set the figure size to be just big enough for the image, and centered at
% the center of the screen
set(MainHandle.LoadingFigure.Axes,...
	'Unit','Normalized','Position',[0,0,1,1]);

figPos = [0, 0, MainHandle.LoadingFigure.Imagine.XData(2),...
			MainHandle.LoadingFigure.Imagine.YData(2)];
		
set(MainHandle.LoadingFigure.MainFigure,'Position',figPos);
movegui(MainHandle.LoadingFigure.MainFigure,'center')

% make the figure visible

set(MainHandle.LoadingFigure.MainFigure,'Visible','on');


end

