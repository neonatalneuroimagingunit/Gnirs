%% only for test
close all
clear all %#ok<CLALL>
clc


%% create the main handle
GHandle = GnirsHandle;


%% Load database 
GHandle.Preference.Path.currentPath = fileparts(which(mfilename));
addpath(genpath(GHandle.Preference.Path.currentPath));
GHandle.Preference.Path.preferenceTxt = fullfile(GHandle.Preference.Path.currentPath,'Path.txt');

%% create db if not exist
if ~exist(GHandle.Preference.Path.preferenceTxt, 'file')
	
 	handleNewDatabase = newdatabasewindow(GHandle.Preference.Path.currentPath);
	waitfor(handleNewDatabase.MainFigure);	
end


%% check if something go wrong
if exist(GHandle.Preference.Path.preferenceTxt, 'file') 
	
	%% open all the preference
	fid = fopen(GHandle.Preference.Path.preferenceTxt);
	databasePath = fgetl(fid);
	fclose(fid);

	GHandle.DataBase = GDataBase.load(databasePath);


	%%  load and set Setings color theme
	
	GHandle.Preference.Font.name = 'Helvetica';
	set(0,'units','centimeters')
	GHandle.Preference.Screen.sizeCm = get(0,'ScreenSize');
	GHandle.Preference.Font.sizeS = floor(GHandle.Preference.Screen.sizeCm(4)/2.5);
	GHandle.Preference.Font.sizeM = floor(GHandle.Preference.Screen.sizeCm(4)/2);
	GHandle.Preference.Font.sizeL = floor(GHandle.Preference.Screen.sizeCm(4)/1.75);
	
	set(0,'units','pixels')
	GHandle.Preference.Path.dataBase = GHandle.DataBase.path;
	GHandle.Preference.Screen.size = get(0,'ScreenSize');
	GHandle.Preference.Figure.size = [GHandle.Preference.Screen.size(3:4).*0.125 , GHandle.Preference.Screen.size(3:4).*0.75 ];

	GHandle.Preference.Figure.theme = 'dark';
	
	%% aggiungerlo come listener
	switch GHandle.Preference.Figure.theme
		case 'classic'
			GHandle.Preference.Figure.backgroundColor = get(0,'DefaultUicontrolBackgroundcolor');
			GHandle.Preference.Figure.foregroundColor = 'k';
			GHandle.Preference.Figure.panelColor = [211 211 211]/255;
		case 'dark'
			GHandle.Preference.Figure.backgroundColor = [68 68 68]/255;
			GHandle.Preference.Figure.foregroundColor = 'w';
			GHandle.Preference.Figure.panelColor = [92 92 92]/255;
	end
	%% create a loading figure
	
	loadigfigure(GHandle);
	%% create the mean figure
	GHandle.Main.Figure = figure('Visible', 'off', ...
		'position', GHandle.Preference.Figure.size,...
		'Resize', 'on',...
		'Name', 'GNirs', ...
		'SizeChangedFcn',{@resizecheck,GHandle},...
		'Numbertitle', 'off', ...
		'Color', GHandle.Preference.Figure.backgroundColor, ...
		'Toolbar', 'none', ...
		'Menubar', 'none', ...
		'DoubleBuffer', 'on', ...
		'DockControls', 'off', ...
		'Renderer', 'OpenGL');

	toolbar(GHandle);

	GHandle.Main.Display.Pannel = uipanel (...
		'Title', '', ...
		'Parent', GHandle.Main.Figure,...
		'Units', 'normalized',...
		'Visible', 'on',...
		'Position',[0.21 0.01 0.78 0.88]);

	
	tree(GHandle);
	%% display the figure and close the loading figure
	
	
	
	GHandle.Main.Figure.Visible = 'on';
	
	close(GHandle.Loading.Figure);
else
	error('Database not found')
end
