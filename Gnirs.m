% function Gnirs()

%% only for test

close all
clear all %#ok<CLALL>
clc


opengl hardware
%% Start default settings
largeScreenRatio = 0.75;
mediumScreenRatio = 0.5;
smallScreenRatio = 0.25;

%% Font Ratio settings
smallFont = 2;
mediumFont = 1.75;
largeFont = 1.5;

%% set Path
currentPath = fileparts(which(mfilename));
addpath(genpath(currentPath));

%% create the main handle
GHandle = GnirsHandle;

%% Load database 
GHandle.Preference.Path.currentPath = currentPath;
preferenceTxt = fullfile(currentPath,'Path.txt');
GHandle.Preference.Path.preferenceTxt = preferenceTxt;

% create db if not exist
if ~exist(preferenceTxt, 'file')
	
 	handleNewDatabase = newdatabasewindow(currentPath);
	waitfor(handleNewDatabase.MainFigure);
end

% check if something go wrong
if exist(GHandle.Preference.Path.preferenceTxt, 'file') 
	
	%% open all the preference
    loadpreferences(GHandle);
    databasePath = fullfile(GHandle.Preference.Path.databasePath);
	GHandle.DataBase = GDataBase.load(databasePath);

	%%  load and set Settings color theme
	
	GHandle.Preference.Font.name = 'Helvetica';
	set(0,'units','centimeters')
	GHandle.Preference.Screen.sizeCm = get(0,'ScreenSize');
	fontSizeS = floor(GHandle.Preference.Screen.sizeCm(4)/smallFont);
	fontSizeM = floor(GHandle.Preference.Screen.sizeCm(4)/mediumFont);
	fontSizeL = floor(GHandle.Preference.Screen.sizeCm(4)/largeFont);
	
	GHandle.Preference.Font.sizeS = fontSizeS;
	GHandle.Preference.Font.sizeM = fontSizeS;
	GHandle.Preference.Font.sizeL = fontSizeL;
	
	set(0,'units','pixels')
	GHandle.Preference.Path.dataBase = GHandle.DataBase.path;
	GHandle.Preference.Screen.size = get(0,'ScreenSize');
	
	% Size Fullscreen windows
	GHandle.Preference.Figure.sizeFull = GHandle.Preference.Screen.size;
	
	% Size large windows
	edge = GHandle.Preference.Screen.size(3:4) .* (1 - largeScreenRatio)./2;
	size =  GHandle.Preference.Screen.size(3:4) .* largeScreenRatio;
	figureSize = [edge, size];
	GHandle.Preference.Figure.sizeLarge = figureSize;

	% Size medium windows
	edge = GHandle.Preference.Screen.size(3:4) .* (1 - mediumScreenRatio)./2;
	size =  GHandle.Preference.Screen.size(3:4) .* mediumScreenRatio;
	figureSize = [edge, size];
	GHandle.Preference.Figure.sizeMedium = figureSize;
	
	% Size small windows
	edge = GHandle.Preference.Screen.size(3:4) .* (1 - smallScreenRatio)./2;
	size =  GHandle.Preference.Screen.size(3:4) .* smallScreenRatio;
	figureSize = [edge, size];
	GHandle.Preference.Figure.sizeSmall = figureSize;
    
	%% aggiungerlo come listener
% 	switch GHandle.Preference.Figure.Theme
% 		case 'classic'
% 			GHandle.Preference.Figure.backgroundColor = get(0,'DefaultUicontrolBackgroundcolor');
% 			GHandle.Preference.Figure.foregroundColor = 'k';
% 			GHandle.Preference.Figure.panelColor = [211 211 211]/255;
% 			GHandle.Preference.Figure.highlightColor = [211 211 211]/255;
% 		case 'dark'
% 			GHandle.Preference.Figure.backgroundColor = [68 68 68]/255;
% 			GHandle.Preference.Figure.foregroundColor = 'w';
% 			GHandle.Preference.Figure.panelColor = [92 92 92]/255;
% 			GHandle.Preference.Figure.highlightColor = [211 211 211]/255;
% 	end
	%% create a loading figure
	
	loadigfigure(GHandle);
	
	%% create main gui 	
	maingui(GHandle);
	
	close(GHandle.TempWindow.LoadingFigure);
	
else
	error('Database not found')
end

% Take care of garbage 
GHandle.TempWindow = [];
GHandle.Temp = [];
clearvars('-except','GHandle');

