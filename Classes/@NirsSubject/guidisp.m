function  Handle = guidisp(Subject, GHandle , modify)
dxsxEdge = 0.05;
overunderEdge = 0.009;
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
GHandle.Main.Display.SubPanel(idx).Panel.Title = 'Subject';

% id
lowerPos = (0.3 +overunderEdge) + 3 *( 0.7 - overunderEdge)/4;
GHandle.Main.Display.SubPanel(idx).IdTextBox = gtextbox(...
    'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
    'TextString',Subject.id,...
    'TitleString','ID:',...
    'Units','normalized',...
    'FontSize',textFontSize,...
    'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);


lowerPos = (0.3 +overunderEdge) + 2 *( 0.7 - overunderEdge)/4;
% name
if modify
    GHandle.Main.Display.SubPanel(idx).NameEditableTextBox = geditabletext(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',Subject.name,...
        'TitleString','Name',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
else
    GHandle.Main.Display.SubPanel(idx).NameTextBox = gtextbox(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',Subject.name,...
        'TitleString','Name:',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
end


% Surname
lowerPos = (0.3 +overunderEdge) + 1 *( 0.7 - overunderEdge)/4;
if modify
    GHandle.Main.Display.SubPanel(idx).SurnameEditableTextBox = geditabletext(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',Subject.surName,...
        'TitleString','Surname',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
else
    GHandle.Main.Display.SubPanel(idx).SurnameTextBox = gtextbox(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',Subject.surName,...
        'TitleString','Surname:',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
end

% Birthdate
lowerPos = (0.3 +overunderEdge);
if modify
    GHandle.Main.Display.SubPanel(idx).BirthdateEditableTextBox = geditabletext(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',datestr(Subject.birthDay, 'dd/mm/yyyy'),...
        'TitleString','Name',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
else
    GHandle.Main.Display.SubPanel(idx).BirthdateTextBox = gtextbox(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',datestr(Subject.birthDay, 'dd/mm/yyyy'),...
        'TitleString','Birthday:',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
end

% note
if modify
    GHandle.Main.Display.SubPanel(idx).NoteEditableTextBox = geditabletext(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',Subject.note,...
        'TitleString','Note',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge overunderEdge textBoxWidth 0.3-overunderEdge]);
else
    GHandle.Main.Display.SubPanel(idx).NoteTextBox = gtextbox(...
        'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
        'TextString',Subject.note,...
        'TitleString','Note:',...
        'FontSize',textFontSize,...
        'Units','normalized',...
        'Position',[dxsxEdge overunderEdge textBoxWidth 0.3-overunderEdge]);
end
% plot the info list
infoList = fieldnames(Subject.Info);
nInfo = length(infoList);
for iInfo = 1 : nInfo
    field = infoList{iInfo};
    fieldTextString = num2str(Subject.Info.(field));
    
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

