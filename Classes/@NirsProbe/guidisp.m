function  Handle = guidisp(Probe, GHandle , modify)
dxsxEdge = 0.05;
overunderEdge = 0.009;
textBoxWidth = 0.3;
textBoxHeight = 0.12;
gmColor = [0.65 0.65 0.65];
wmColor =  [1 1 1];
scalpColor = [255 229 204]./255;
sourceColor = [1 0 0];
detectorColor = [0 0 1];

idx = GHandle.Temp.idx;
fontName = 'Arial'; %'Lobster Two';


textFontSize = GHandle.Preference.Font.sizeM;

idx = GHandle.Temp.idx;

% create the figure and the editable field if is not specify
if ~exist('editableField','var')
    editableField = '';
end
editableField = lower(editableField);

if ~exist('GHandle','var') || isempty(GHandle)
    Handle.MainFigure = figure;
    GHandle.Main.SubPanel.Panel = uipanel('Parent',Handle.MainFigure);
end

% assign the title
GHandle.Main.Display.SubPanel(idx).Panel.Title = 'Probe';




end

