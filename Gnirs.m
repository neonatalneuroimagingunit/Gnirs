%% only for test
close all
clear all %#ok<CLALL>
clc





%% Load database 
currentPath = fileparts(which(mfilename));
addpath(genpath(currentPath));
dataBaseTxtPath = fullfile(currentPath,'Path.txt');

%% create db if not exist
if ~exist(dataBaseTxtPath, 'file')
	
 	handleNewDatabase = newdatabasewindow(currentPath);
	waitfor(handleNewDatabase.MainFigure);	
end


%% check if something go wrong
if ~exist(dataBaseTxtPath, 'file') 
	fid = fopen(dataBaseTxtPath);
	databasePath = fgetl(fid);
	fclose(fid);

	DataBase = GDataBase.load(databasePath);


	%%  load Setings color theme
	Hmain.dataBasePath = DataBase.path;
	Hmain.screenSize = get(0,'ScreenSize');
	Hmain.figureSize = [Hmain.screenSize(3:4).*0.125 , Hmain.screenSize(3:4).*0.75 ];

	Hmain.theme = 'dark';
	switch Hmain.theme
		case 'classic'
			backgroundColor = get(0,'DefaultUicontrolBackgroundcolor');
			foregroundColor = 'k';
			panelColor = [211 211 211]/255;
		case 'dark'
			backgroundColor = [68 68 68]/255;
			foregroundColor = 'w';
			panelColor = [92 92 92]/255;
	end
	%% create a loading figure
	%%Hmain.LoadingFigure = imshow('loading.jpg','InitialMagnification','fit');

	%% create the mean figure
	Hmain.mainFigure = figure('Visible', 'off', ...
		'position', Hmain.figureSize,...
		'Resize', 'on',...
		'Name', 'GNirs', ...
		'Numbertitle', 'off', ...
		'Color', backgroundColor, ...
		'Toolbar', 'none', ...
		'Menubar', 'none', ...
		'DoubleBuffer', 'on', ...
		'DockControls', 'off', ...
		'Renderer', 'OpenGL');

	% Hmain = NIRSToolbar(Hmain);
	% 
	% Hmain = NIRSDisplay(Hmain);
	% 
	% Hmain = NIRSTree(Hmain,dbNIRS);

	%% display the figure and close the loading figure
	Hmain.mainFigure.Visible = 'on';

	close(Hmain.LoadingFigure);
else
	error('Database ')
end
