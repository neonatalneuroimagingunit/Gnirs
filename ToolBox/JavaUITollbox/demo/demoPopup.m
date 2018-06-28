%% Popup
%   Copyright 2017-2018 The MathWorks, Inc.

%% Create the widget

f = figure(...
    'Toolbar','none',...
    'MenuBar','none',...
    'NumberTitle','off',...
    'Units','pixels',...
    'Position',[100 100 320 45]);
movegui(f,[100 -100])

w = uiw.widget.Popup(...
    'Parent', f, ...
    'Items',{'Alpha','Bravo','Charlie','Delta','Echo','Foxtrot'},...
    'Label','Names:', ...
    'LabelLocation','left',...
    'LabelWidth',90,...
    'Callback',@(h,e)disp(e.Interaction),...
    'Units', 'pixels', ...
    'Position', [10 10 300 25]);

%    'Items',{'Alpha','Bravo','Charlie','Delta','Echo','Foxtrot'},...


%% Set by index

w.SelectedIndex = 3;


%% Get the selected items 

% This is a read-only property
% selection = w.SelectedItems