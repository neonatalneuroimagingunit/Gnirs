function  Handle = guidisp(Measure, GHandle , modify)
dxsxEdge = 0.05;
overunderEdge = 0.019;
textBoxWidth = 0.3;
textBoxHeight = 0.12;

textFontSize = GHandle.Preference.Font.sizeM;

idx = GHandle.Temp.idx;

% create the figure and the editable field if is not specify
if (nargin < 3)
    modify = false;
end


if ~exist('GHandle','var') || isempty(GHandle)
    Handle.MainFigure = figure;
    GHandle.Main.SubPanel.Panel = uipanel('Parent',Handle.MainFigure);
end

% assign the title
GHandle.Main.Display.SubPanel(idx).Panel.Title = 'Measure';

% id
lowerPos = (0.3 +overunderEdge) + 3 *( 0.7 - overunderEdge)/4;
GHandle.Main.Display.SubPanel(idx).IdTextBox = gtextbox(...
    'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
    'TextString',Measure.id,...
    'TitleString','ID:',...
    'FontSize',textFontSize,...
    'Units','normalized',...
    'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);

% date
lowerPos = (0.3 +overunderEdge) + 2 *( 0.7 - overunderEdge)/4;
if modify
    GHandle.Main.Display.SubPanel(idx).BirthdateEditableTextBox = geditabletext(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',datestr(Measure.date, 'dd/mm/yyyy'),...
        'TitleString','Name',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
else
    GHandle.Main.Display.SubPanel(idx).BirthdateTextBox = gtextbox(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',datestr(Measure.date, 'dd/mm/yyyy'),...
        'TitleString','Date:',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
end

%duration
lowerPos = (0.3 +overunderEdge) + 1 *( 0.7 - overunderEdge)/4;
GHandle.Main.Display.SubPanel(idx).BirthdateTextBox = gtextbox(...
    'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
    'TextString',num2str(Measure.timeLength),...
    'TitleString','Time Length:',...
    'FontSize',textFontSize,...
    'Units','normalized',...
    'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);



%update rate
lowerPos = (0.3 +overunderEdge);
GHandle.Main.Display.SubPanel(idx).BirthdateTextBox = gtextbox(...
    'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
    'TextString',num2str(Measure.InstrumentType.UpdateRate),...
    'TitleString','Update Rate:',...
    'FontSize',textFontSize,...
    'Units','normalized',...
    'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);


% note
if modify
    GHandle.Main.Display.SubPanel(idx).NoteEditableTextBox = geditabletext(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',Measure.note,...
        'TitleString','Note',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge overunderEdge textBoxWidth 0.3-overunderEdge]);
else
    GHandle.Main.Display.SubPanel(idx).NoteTextBox = gtextbox(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',Measure.note,...
        'TitleString','Note:',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge overunderEdge textBoxWidth 0.3-overunderEdge]);
end

% plot the info list
infoList = fieldnames(Measure.Info);
nInfo = length(infoList);
for iInfo = 1 : nInfo
    field = infoList{iInfo};
    
    if ~isstruct(Measure.Info.(field))
        fieldTextString = num2str(Measure.Info.(field));
    else
        fieldTextString = 'structvalue';
    end
    
    
    ypos = (1 - overunderEdge - textBoxHeight ) -  (iInfo-1)/nInfo;
    xpos = 0.5;
    
    tag = [field ,'EditableTextBox'];
    if modify
        GHandle.Main.Display.SubPanel(idx).(tag) = geditabletext(...
            'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
            'TextString',fieldTextString,...
            'TitleString',[field,':'],...
            'FontSize',textFontSize,...
            'Units','normalized',...
            'Position',[xpos ypos textBoxWidth, textBoxHeight]);
    else
        GHandle.Main.Display.SubPanel(idx).(tag) = gtextbox(...
            'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
            'TextString',fieldTextString,...
            'TitleString',[field,':'],...
            'FontSize',textFontSize,...
            'Units','normalized',...
            'Position',[xpos ypos textBoxWidth, textBoxHeight]);
    end
end

end

