function exportimage(GHandle, fig)

fontSize = GHandle.Preference.Font.sizeL;
foregroundColor = GHandle.Preference.Theme.foregroundColor;
backgroundColor = GHandle.Preference.Theme.backgroundColor;
figurePosition = GHandle.Preference.Figure.sizeMedium;
GHandle.TempWindow.filePath = cd;
GHandle.TempWindow.figtosave = fig;

fileTypeLabel = {'PNG 24-bit'; 'JPEG 24-bit'; 'BMP 24-bit'};
fileTypeCode = {'-dpng'; '-djpeg'; '-dbmp'};

dpiLabel = {'150 DPI'; '300 DPI'; '600 DPI'};
dpiCode = {'-r150'; '-r300'; '-r600'};

GHandle.TempWindow.mainFigure = figure('Position', figurePosition, ...
    'Visible', 'on', ...
    'Resize', 'off',...
    'Name', 'Export image...', ...
    'Numbertitle', 'off', ...
    'Tag', 'export_image', ...
    'Color', backgroundColor, ...
    'Toolbar', 'none', ...
    'Menubar', 'none', ...
    'CloseRequestFcn', @(handle, evnt)close_request(handle, evnt, GHandle),...
    'DoubleBuffer', 'on', ...
    'DockControls', 'off', ...
    'Renderer', 'OpenGL');

GHandle.TempWindow.FileTypeSelectorlabel = uicontrol('Parent', GHandle.TempWindow.mainFigure, ...
    'Style', 'text', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.55 0.5 0.35 0.05], ...
    'FontWeight', 'bold', ...
    'FontSize', fontSize, ...
    'FontAngle', 'italic', ...
    'HorizontalAlignment', 'left', ...
    'String', 'File type');

GHandle.TempWindow.FileTypeSelectorPopup = uicontrol('Parent', GHandle.TempWindow.mainFigure, ...
    'Style', 'popup',...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.55 0.45 0.35 0.05], ...
    'FontWeight', 'bold', ...
    'FontSize', fontSize, ...
    'Value', 1, ...
    'String', fileTypeLabel);

GHandle.TempWindow.FileNameEdit = uicontrol('Parent', GHandle.TempWindow.mainFigure, ...
    'Style', 'edit', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.1 0.1 0.5 0.1], ...
    'FontWeight', 'bold', ...
    'FontSize', fontSize, ...
    'FontAngle', 'italic', ...
    'HorizontalAlignment', 'left', ...
    'String', 'Insert name');

GHandle.TempWindow.FilePathEdit = uicontrol('Parent', GHandle.TempWindow.mainFigure, ...
    'Style', 'edit', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.1 0.8 0.5 0.1], ...
    'FontWeight', 'bold', ...
    'FontSize', fontSize, ...
    'FontAngle', 'italic', ...
    'HorizontalAlignment', 'left', ...
    'String', GHandle.TempWindow.filePath);

GHandle.TempWindow.BrowseButton = uicontrol('Parent', GHandle.TempWindow.mainFigure, ...
    'Style', 'pushbutton',...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.7 0.8 0.2 0.1], ...
    'FontWeight', 'bold', ...
    'FontSize', fontSize, ...
    'Callback', {@browse_tree, GHandle}, ...
    'String', 'Browse');

GHandle.TempWindow.DpiSelectorlabel = uicontrol('Parent', GHandle.TempWindow.mainFigure, ...
    'Style', 'text', ...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.1 0.5 0.35 0.05], ...
    'FontWeight', 'bold', ...
    'FontSize', fontSize, ...
    'FontAngle', 'italic', ...
    'HorizontalAlignment', 'left', ...
    'String', 'DPI');

GHandle.TempWindow.DpiSelectorPopup = uicontrol('Parent', GHandle.TempWindow.mainFigure, ...
    'Style', 'popup',...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.1 0.45 0.35 0.05], ...
    'FontWeight', 'bold', ...
    'FontSize', fontSize, ...
    'Value', 2, ...
    'String', dpiLabel);

GHandle.TempWindow.SaveButton = uicontrol('Parent', GHandle.TempWindow.mainFigure, ...
    'Style', 'pushbutton',...
    'BackgroundColor', backgroundColor, ...
    'ForegroundColor', foregroundColor, ...
    'Units', 'normalized', ...
    'Position', [0.7 0.1 0.2 0.1], ...
    'FontWeight', 'bold', ...
    'FontSize', fontSize, ...
    'Callback', {@save_to_img, GHandle}, ...
    'String', 'Save');

GHandle.TempWindow.fileName = GHandle.TempWindow.FileNameEdit.String;
GHandle.TempWindow.filePath = GHandle.TempWindow.FilePathEdit;
GHandle.TempWindow.fileType = fileTypeCode{GHandle.TempWindow.FileTypeSelectorPopup.Value};
GHandle.TempWindow.dpi = dpiCode{GHandle.TempWindow.DpiSelectorPopup.Value};

end

function save_to_img(~, ~, GHandle)
print(GHandle.TempWindow.figtosave, ...
    [GHandle.TempWindow.FilePathEdit.String filesep GHandle.TempWindow.fileName], ...
    GHandle.TempWindow.fileType, GHandle.TempWindow.dpi);
end

function browse_tree(~, ~, GHandle)
GHandle.TempWindow.filePath = uigetdir(GHandle.TempWindow.filePath.String);
end

function close_request(Handle, ~, GHandle)
delete(Handle);
GHandle.TempWindow = [];
end

%% Also consider this alternative
% ax(1) = GHandle.Viewer(1).timeplot.bigaxes1;
% ax(2) = GHandle.Viewer(1).timeplot.bigaxes2;
% hfig = ancestor(ax(1), 'figure');
% 
% rect = hgconvertunits(hfig, get(ax, 'OuterPosition'), ...
%     get(ax, 'Units'), 'pixels', get(ax, 'Parent'));
% 
% fr = getframe(hfig, rect);
% imwrite(fr.cdata, 'image.png');
% 
% f_new = figure('Visible','off','Position',hfig.Position);
% ax_new = copyobj(ax,f_new);
% set(ax_new,'Position','default');
% print(f_new,'AxesOnly','-dpng','-r300')