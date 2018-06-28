%% File Selector
%   Copyright 2017-2018 The MathWorks, Inc.

%% Create the widget

f = figure(...
    'Toolbar','none',...
    'MenuBar','none',...
    'NumberTitle','off',...
    'Units','pixels',...
    'Position',[100 100 520 45]);
movegui(f,[100 -100])

w = uiw.widget.FileSelector(...
    'Parent', f, ...
    'Value', 'C:\matlab.mat', ...
    'Pattern', {'*.mat','MATLAB MAT files (*.mat)'; '*.csv','CSV files (*.csv)'}, ...
    'Callback',@(h,e)disp(e),...
    'Label','Choose a data file:', ...
    'LabelLocation','left',...
    'LabelWidth',110,...
    'Units', 'pixels', ...
    'Position', [10 10 500 25]);

%% Set a different value to a path that does not exist

% The color should toggle
w.Value = 'C:\InvalidFileName\SetsInvalidColor.mat';


%% Now, set a valid value

% The color should toggle back
w.Value = fullfile(matlabroot,'VersionInfo.xml');