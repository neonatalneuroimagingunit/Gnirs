function  viewertimefrequency(viewerC, GHandle, vIdx)

GHandle.Viewer(vIdx).PlotPanel.TimeFrequency.MainAxes = axes('parent', GHandle.Viewer(vIdx).PlotPanel.TimeFrequencyTab,...
    'Position', [0.07 0.22 0.88 0.66], ...
    'Units', 'normalized', ...
    'Color', viewerC.backgroundColor, ...
    'XColor', viewerC.foregroundColor, ...
    'YColor', viewerC.foregroundColor, ...
    'XGrid', 'on', ...
    'XDir','reverse',...
    'YGrid', 'on', ...
    'View',[-240 ,  30],...
    'NextPlot', 'add',...
    'GridColor', viewerC.foregroundColor, ...
    'FontSize',GHandle.Preference.Font.sizeL,...
    'FontWeight', 'bold', ...
    'FontName', viewerC.defaultFontName, ...
    'Visible', 'off', ...
    'Title', 'Main plots');

GHandle.Viewer(vIdx).PlotPanel.TimeFrequency.Text = uicontrol(...
    'Parent', GHandle.Viewer(vIdx).PlotPanel.TimeFrequencyTab, ...
    'Style', 'text', ...
    'BackgroundColor',viewerC.backgroundColor, ...
    'ForegroundColor', viewerC.foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.25 0.25 0.5 0.5], ...
    'FontWeight', 'bold', ...
    'FontSize', 40, ...
    'Visible', 'on',...
    'FontAngle', 'italic', ...
    'HorizontalAlignment', 'center', ...
    'String', 'Select one curve!!!');
end