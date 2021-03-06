function  guidisp(Atlas, GHandle , modify)
dxsxEdge = 0.05;
%overunderEdge = 0.009;
overunderEdge = 0.05;
textBoxWidth = 0.3;
textBoxHeight = 0.09;
listHeight = 0.2;
checkBoxHeight = 0.05;

gmColor = [0.65 0.65 0.65];
wmColor =  [1 1 1];
scalpColor = [255 229 204]./255;
landMarkColor = [1 0.2 0.2];
landMarkColorSmall = [0.2 1 0.2];
textFontSize = GHandle.Preference.Font.sizeM;

idx = GHandle.Temp.idx;
fontName = 'Arial'; %'Lobster Two';

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
GHandle.Main.Display.SubPanel(idx).Panel.Title = 'Atlas';

% id
lowerPos = (0.6+overunderEdge) + 2*(0.35-overunderEdge)/3;
GHandle.Main.Display.SubPanel(idx).IdTextBox = gtextbox(...
    'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
    'TextString',Atlas.id,...
    'TitleString','ID:',...
    'FontSize',textFontSize,...
    'Units','normalized',...
    'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);


lowerPos = (0.6+overunderEdge) + 1*(0.35-overunderEdge)/3;
% name
if any(contains(editableField,'name'))
    GHandle.Main.Display.SubPanel(idx).NameEditableTextBox = getitabletext(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',Atlas.name,...
        'TitleString','Name:',....
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
else
    GHandle.Main.Display.SubPanel(idx).NameTextBox = gtextbox(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',Atlas.tag,...
        'TitleString','Name:',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
end

% date
lowerPos = (0.6+overunderEdge);
if any(contains(editableField,'date'))
    GHandle.Main.Display.SubPanel(idx).DateEditableTextBox = getitabletext(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',datestr(Atlas.date, 'dd/mm/yyyy'),...
        'TitleString','Date:',...0.40
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
else
    GHandle.Main.Display.SubPanel(idx).DateTextBox = gtextbox(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',datestr(Atlas.date, 'dd/mm/yyyy'),...
        'TitleString','Date:',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
end

% note
lowerPos = (0.4);
if any(contains(editableField,'note'))
    GHandle.Main.Display.SubPanel(idx).NoteEditableTextBox = getitabletext(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',Atlas.note,...
        'TitleString','Note',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight*2]);
else
    GHandle.Main.Display.SubPanel(idx).NoteTextBox = gtextbox(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',Atlas.note,...
        'TitleString','Note:',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight*2]);
end

GHandle.Main.Display.SubPanel(idx).SubPanel = uipanel(...
    'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
    'Units', 'normalize', ...
    'Position',[0.45 0.05 0.50 0.90],...
    'Visible', 'on',...
    'BackgroundColor',[0 0 0]);

GHandle.Main.Display.SubPanel(idx).Axes = axes(...
    'Parent',GHandle.Main.Display.SubPanel(idx).SubPanel,...
    'Units', 'normalize', ...
    'Position',[0 0 1 1],...
    'NextPlot','add',...
    'Visible', 'off');

set(GHandle.Main.Display.SubPanel(idx).Axes,'CameraViewAngle',get(GHandle.Main.Display.SubPanel(idx).Axes,'CameraViewAngle'));
set(GHandle.Main.Display.SubPanel(idx).Axes,'PlotBoxAspectRatio',get(GHandle.Main.Display.SubPanel(idx).Axes,'PlotBoxAspectRatio'));
set(GHandle.Main.Display.SubPanel(idx).Axes,'DataAspectRatio',get(GHandle.Main.Display.SubPanel(idx).Axes,'DataAspectRatio'));
rotate3d(GHandle.Main.Display.SubPanel(idx).Axes, 'on');

lighting(GHandle.Main.Display.SubPanel(idx).Axes,'gouraud');
GHandle.Main.Display.SubPanel(idx).Light(1) = light('Position', [+100 0 50]);
GHandle.Main.Display.SubPanel(idx).Light(2) = light('Position', [-100 0 50]);




GHandle.Main.Display.SubPanel(idx).Scalp = trisurf(...
    Atlas.Scalp.face,...
    Atlas.Scalp.node(:,1),Atlas.Scalp.node(:,2), Atlas.Scalp.node(:,3),...
    ones(size(Atlas.Scalp.node(:,3))),...
    'Parent', GHandle.Main.Display.SubPanel(idx).Axes,...
    'SpecularStrength', 0, ...
    'EdgeColor','none',...
    'FaceColor',scalpColor,...
    'FaceAlpha',0.2);

GHandle.Main.Display.SubPanel(idx).Gray = trisurf(...
    Atlas.GreyMatter.face,...
    Atlas.GreyMatter.node(:,1),Atlas.GreyMatter.node(:,2), Atlas.GreyMatter.node(:,3),...
    2.*ones(size(Atlas.GreyMatter.node(:,3))),...
    'Parent', GHandle.Main.Display.SubPanel(idx).Axes,...
    'SpecularStrength', 0, ...
    'EdgeColor','none',...
    'FaceColor',gmColor,...
    'FaceAlpha',0.3);

GHandle.Main.Display.SubPanel(idx).White = trisurf(...
    Atlas.WhiteMatter.face,...
    Atlas.WhiteMatter.node(:,1),Atlas.WhiteMatter.node(:,2), Atlas.WhiteMatter.node(:,3),...
    3.*ones(size(Atlas.WhiteMatter.node(:,3))),...
    'Parent', GHandle.Main.Display.SubPanel(idx).Axes,...
    'SpecularStrength', 0, ...
    'EdgeColor','none',...
    'FaceColor',wmColor);

x = reshape(Atlas.LandMarks.coord(:,:,1), [],1);
y = reshape(Atlas.LandMarks.coord(:,:,2), [],1);
z = reshape(Atlas.LandMarks.coord(:,:,3), [],1);
landmarkNames = reshape(Atlas.LandMarks.names(:,:), [], 1);
iMask = find(~cellfun('isempty', landmarkNames));
GHandle.Main.Display.SubPanel(idx).LandMarkSmall = plot3(...
    x(iMask), y(iMask), z(iMask),...
    'MarkerSize',5,...
    'LineStyle', 'none',...
    'Visible', 'on',...
    'Marker','none',...
    'Color',landMarkColorSmall,...
    'Parent', GHandle.Main.Display.SubPanel(idx).Axes);

stepIdx = linspace(1,size(Atlas.LandMarks.coord,1),21);
x = reshape(Atlas.LandMarks.coord(stepIdx,stepIdx,1), [],1);
y = reshape(Atlas.LandMarks.coord(stepIdx,stepIdx,2), [],1);
z = reshape(Atlas.LandMarks.coord(stepIdx,stepIdx,3), [],1);
landmarkNames = reshape(Atlas.LandMarks.names(stepIdx,stepIdx), [], 1);
iMask = find(~cellfun('isempty', landmarkNames));

GHandle.Main.Display.SubPanel(idx).LandMark = plot3(...
    x(iMask), y(iMask), z(iMask),...
    'MarkerSize',20,...
    'LineStyle', 'none',...
    'Visible', 'on',...
    'Marker','none',...
    'Color',landMarkColor,...
    'Parent', GHandle.Main.Display.SubPanel(idx).Axes);

GHandle.Main.Display.SubPanel(idx).LandMarkText = text(...
    GHandle.Main.Display.SubPanel(idx).Axes,...
    x(iMask), y(iMask), z(iMask),...
    landmarkNames(iMask),...
    'FontName',fontName,...
    'Color','g',...
    'FontWeight','bold',...
    'Visible', 'off');

GHandle.Main.Display.SubPanel(idx).LandMarkCheckBox = uicontrol(...
    'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
    'Units','normalized',...
    'Callback',{@landmarkcheckbox_callback,GHandle, idx},....
    'Position',[dxsxEdge 2*overunderEdge+listHeight textBoxWidth checkBoxHeight],...
    'String','LandMarks',...
    'Style', 'checkbox'...
    );

GHandle.Main.Display.SubPanel(idx).LandMarkTextCheckBox = uicontrol(...
    'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
    'Units','normalized',...
    'Callback',{@landmarktextcheckbox_callback,GHandle, idx},....
    'Position',[dxsxEdge overunderEdge+listHeight textBoxWidth checkBoxHeight],...
    'String','LandMarks Text',...
    'Style', 'checkbox'...
    );


GHandle.Main.Display.SubPanel(idx).EdvListBox = uicontrol(...
    'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
    'Units','normalized',...
    'Callback',{@edvlistbox_callback,GHandle, idx},....
    'Position',[dxsxEdge overunderEdge textBoxWidth listHeight],...
    'String',{'White Matter','Gray Matter', 'Scalp'},...
    'Value',[1 ,2 ,3 ],...
    'Max', 3,...
    'Style', 'listbox'...
    );
end


function landmarkcheckbox_callback(~, evnt, GHandle , idx)

if (evnt.Source.Value)
    GHandle.Main.Display.SubPanel(idx).LandMark.Marker = '.';
    GHandle.Main.Display.SubPanel(idx).LandMarkSmall.Marker = '.';
else
    GHandle.Main.Display.SubPanel(idx).LandMark.Marker = 'none';
    GHandle.Main.Display.SubPanel(idx).LandMarkSmall.Marker = 'none';
end

end


function landmarktextcheckbox_callback(~, evnt, GHandle , idx)
nText = length (GHandle.Main.Display.SubPanel(idx).LandMarkText);
if (evnt.Source.Value)
    set(GHandle.Main.Display.SubPanel(idx).LandMarkText, {'Visible'},...
        repmat( {'on'},size(GHandle.Main.Display.SubPanel(idx).LandMarkText)));
else
    set(GHandle.Main.Display.SubPanel(idx).LandMarkText, {'Visible'},...
        repmat( {'off'}, size(GHandle.Main.Display.SubPanel(idx).LandMarkText)));
end

end

function edvlistbox_callback(~, evnt, GHandle , idx)
nameList = {'White', 'Gray',  'Scalp'};
nameIdx = evnt.Source.Value;
if (length(nameIdx) == 1)
    idxMiss = setdiff(1:3, nameIdx);
    GHandle.Main.Display.SubPanel(idx).(nameList{idxMiss(1)}).FaceAlpha = 0;
    GHandle.Main.Display.SubPanel(idx).(nameList{idxMiss(2)}).FaceAlpha = 0;
    GHandle.Main.Display.SubPanel(idx).(nameList{nameIdx}).FaceAlpha = 1;
    
elseif	(length(nameIdx) == 2)
    idxMiss = setdiff(1:3, nameIdx);
    GHandle.Main.Display.SubPanel(idx).(nameList{idxMiss}).FaceAlpha = 0;
    GHandle.Main.Display.SubPanel(idx).(nameList{nameIdx(1)}).FaceAlpha = 1;
    GHandle.Main.Display.SubPanel(idx).(nameList{nameIdx(2)}).FaceAlpha = 0.5;
    
else
    GHandle.Main.Display.SubPanel(idx).Gray.FaceAlpha = 0.7;
    GHandle.Main.Display.SubPanel(idx).White.FaceAlpha = 1;
    GHandle.Main.Display.SubPanel(idx).Scalp.FaceAlpha = 0.3;
    
end

end



