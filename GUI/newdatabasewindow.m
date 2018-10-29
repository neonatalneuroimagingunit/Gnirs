function  handleNewDatabase = newdatabasewindow(gNirsPath)
%NEWDATABASEWINDOW Summary of this function goes here

% add other settings features
handleNewDatabase.gNirsPath = gNirsPath;
handleNewDatabase.screenSize = get(0,'ScreenSize');
handleNewDatabase.figureSize = [(1/4).*handleNewDatabase.screenSize(3:4),...
    (1/2).*handleNewDatabase.screenSize(3:4)];

handleNewDatabase.MainFigure = figure('Visible', 'off', ...
    'position', handleNewDatabase.figureSize,...
    'Resize', 'on',...
    'Name', 'New Database', ...
    'Numbertitle', 'off', ...
    'Toolbar', 'none', ...
    'Menubar', 'none', ...
    'DoubleBuffer', 'on', ...
    'DockControls', 'off', ...
    'Renderer', 'OpenGL');

standardPath = fullfile(gNirsPath, 'DataBase');

handleNewDatabase.FolderSelector = uiw.widget.FolderSelector(...
    'Parent', handleNewDatabase.MainFigure, ...
    'Value', standardPath, ...
    'Label','Select a folder:',...
    'LabelLocation','top',...
    'LabelWidth',90,...
    'Units', 'normalized', ...
    'Position', [0.05 0.05 0.7 0.125]);

handleNewDatabase.CreateButton = uicontrol('Style', 'pushbutton',...
    'String', 'Create',...
    'Units', 'normalized', ...
    'Position', [0.85 0.05 0.1 0.1],...
    'Callback', {@initialize, handleNewDatabase});

set(handleNewDatabase.MainFigure, 'Visible', 'on');
end

function initialize(~, ~, GHandle)

dataBasePath = GHandle.FolderSelector.Value;

GDataBase.create(dataBasePath);
GHandle.DataBase.Path = dataBasePath;
create_preferences(GHandle);

close(GHandle.MainFigure);
end

function create_preferences(GHandle)
txtPath = fullfile(GHandle.gNirsPath, 'Path.txt');
fid = fopen(txtPath, 'wt');

fontName = get(groot,'defaultuiControlFontName');

classicBackgroundColor = get(groot,'defaultFigureColor');
classicForegroundColor = get(groot,'defaultuiControlForegroundColor');
classicHighlightColor =  get(groot,'defaultuiPanelHighlightColor');
classicPanelColor = get(groot,'defaultuiPanelBackgroundColor');
classicAxesBackgroundColor = get(groot,'defaultAxesColor');
classicWhiteMatterColor = [1 1 1];
classicGreyMatterColor = [0.65 0.65 0.65];
classicScalpColor = [225 229 204]/255;
classicLandmarkColor = [0 1 0]; % if you mess up with themes you deserve this eye-crushing green color for landmarks, you fool
classicLandmarkTextColor = [0 1 0];

darkBackgroundColor = [68 68 68]/255;
darkForegroundColor = [1 1 1];
darkHighlightColor =  [211 211 211]/255;
darkPanelColor = [92 92 92]/255;
darkAxesBackgroundColor = [68 68 68]/255;
darkWhiteMatterColor = [1 1 1];
darkGreyMatterColor = [0.65 0.65 0.65];
darkScalpColor = [225 229 204]/255;
darkLandmarkColor = [0 1 0]; % if you mess up with themes you deserve this eye-crushing green color for landmarks, you fool
darkLandmarkTextColor = [0 1 0];

fprintf(fid, '%s', ['#DATABASEPATH' newline fullfile(GHandle.DataBase.Path,'GDataBase') newline newline]);
fprintf(fid, '%s', ['#DEFAULTFONTNAME' newline fontName newline newline]);
fprintf(fid, '%s', ['#THEME' newline 'classic' newline newline]);
fprintf(fid, '%s', ['#CLASSICTHEME_BACKGROUNDCOLOR' newline num2str(classicBackgroundColor) newline newline]);
fprintf(fid, '%s', ['#CLASSICTHEME_FOREGROUNDCOLOR' newline num2str(classicForegroundColor) newline newline]);
fprintf(fid, '%s', ['#CLASSICTHEME_HIGHLIGHTCOLOR' newline num2str(classicHighlightColor) newline newline]);
fprintf(fid, '%s', ['#CLASSICTHEME_PANELCOLOR' newline num2str(classicPanelColor) newline newline]);
fprintf(fid, '%s', ['#CLASSICTHEME_AXESBACKGROUNDCOLOR' newline num2str(classicAxesBackgroundColor) newline newline]);
fprintf(fid, '%s', ['#CLASSICTHEME_WHITEMATTERCOLOR' newline num2str(classicWhiteMatterColor) newline newline]);
fprintf(fid, '%s', ['#CLASSICTHEME_GREYMATTERCOLOR' newline num2str(classicGreyMatterColor) newline newline]);
fprintf(fid, '%s', ['#CLASSICTHEME_SCALPCOLOR' newline num2str(classicScalpColor) newline newline]);
fprintf(fid, '%s', ['#CLASSICTHEME_LANDMARKCOLOR' newline num2str(classicLandmarkColor) newline newline]);
fprintf(fid, '%s', ['#CLASSICTHEME_LANDMARKTEXTCOLOR' newline num2str(classicLandmarkTextColor) newline newline]);

fprintf(fid, '%s', ['#DARKTHEME_BACKGROUNDCOLOR' newline num2str(darkBackgroundColor) newline newline]);
fprintf(fid, '%s', ['#DARKTHEME_FOREGROUNDCOLOR' newline num2str(darkForegroundColor) newline newline]);
fprintf(fid, '%s', ['#DARKTHEME_HIGHLIGHTCOLOR' newline num2str(darkHighlightColor) newline newline]);
fprintf(fid, '%s', ['#DARKTHEME_PANELCOLOR' newline num2str(darkPanelColor) newline newline]);
fprintf(fid, '%s', ['#DARKTHEME_AXESBACKGROUNDCOLOR' newline num2str(darkAxesBackgroundColor) newline newline]);
fprintf(fid, '%s', ['#DARKTHEME_WHITEMATTERCOLOR' newline num2str(darkWhiteMatterColor) newline newline]);
fprintf(fid, '%s', ['#DARKTHEME_GREYMATTERCOLOR' newline num2str(darkGreyMatterColor) newline newline]);
fprintf(fid, '%s', ['#DARKTHEME_SCALPCOLOR' newline num2str(darkScalpColor) newline newline]);
fprintf(fid, '%s', ['#DARKTHEME_LANDMARKCOLOR' newline num2str(darkLandmarkColor) newline newline]);
fprintf(fid, '%s', ['#DARKTHEME_LANDMARKTEXTCOLOR' newline num2str(darkLandmarkTextColor) newline newline]);

fclose(fid);
end