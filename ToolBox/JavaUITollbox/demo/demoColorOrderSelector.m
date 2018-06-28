%% Color Order Selector
%   Copyright 2017-2018 The MathWorks, Inc.

%% Create the widget

f = figure(...
    'Toolbar','none',...
    'MenuBar','none',...
    'NumberTitle','off',...
    'Units','pixels',...
    'Position',[100 100 320 320]);
movegui(f,[100 -100])

w = uiw.widget.ColorOrderSelector(...
    'Parent',f,...
    'ColorOrder',[0 1 1; 1 0 0; 0 1 0],...
    'Callback',@(h,e)disp(e),...
    'Label','Select a color order:',...
    'LabelLocation','top',...
    'LabelHeight',18,...
    'Units','pixels',...
    'Position', [10 10 300 300]);
