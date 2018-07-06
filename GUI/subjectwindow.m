function [SubjectFigure] = subjectwindow(Subject, editableField, MainHandle, MainFigure)
%SUBJECTWINDOW Summary of this function goes here
%   Detailed explanation goes here





% editable field is case unsensitive
editableField = lower(editableField);

	if isempty(MainFigure)
		SubjectFigure.MainFigure = figure(...
		'position', MainHandle.screenSize.*(3/4),...
		'Resize', 'on',...
		'Numbertitle', 'off', ...
		'Toolbar', 'none', ...
		'Menubar', 'none', ...
		'DoubleBuffer', 'on', ...
		'DockControls', 'off', ...
		'Renderer', 'OpenGL',...
		'Visible', 'on' ...
		);
	else
		SubjectFigure.MainFigure = MainFigure;
	end
	
	
%% id
	SubjectFigure.NameTextBox = uiw.widget.FixedText(...      
		'Parent',SubjectFigure.MainFigure,...
		'Value',Subject.id,...
		'Label','ID:',...
		'LabelLocation','top',...
		'LabelWidth',90,...
		'Units','normalized',...
		'Position',[0.05 0.9 0.3, 0.09]);


%% name	
	if any(contains(editableField,'name'))
		SubjectFigure.NameEditableTextBox = uiw.widget.EditableText(...      
		'Parent',SubjectFigure.MainFigure,...
		'Value',Subject.name,...
		'Label','Name',...
		'LabelLocation','top',...
		'LabelWidth',90,...
		'Units','normalized',...
		'Position',[0.05 0.75 0.3, 0.09]);
	else
		SubjectFigure.NameTextBox = uiw.widget.FixedText(...      
		'Parent',SubjectFigure.MainFigure,...
		'Value',Subject.name,...
		'Label','Name:',...
		'LabelLocation','top',...
		'LabelWidth',90,...
		'Units','normalized',...
		'Position',[0.05 0.75 0.3, 0.09]);
	end
	
%% surname	
	if any(contains(editableField,'surname'))
		SubjectFigure.NameEditableTextBox = uiw.widget.EditableText(...      
		'Parent',SubjectFigure.MainFigure,...
		'Value',Subject.surName,...
		'Label','Surname',...
		'LabelLocation','top',...
		'LabelWidth',90,...
		'Units','normalized',...
		'Position',[0.05 0.60 0.3, 0.09]);
	else
		SubjectFigure.NameTextBox = uiw.widget.FixedText(...      
		'Parent',SubjectFigure.MainFigure,...
		'Value',Subject.surName,...
		'Label','Surname:',...
		'LabelLocation','top',...
		'LabelWidth',90,...
		'Units','normalized',...
		'Position',[0.05 0.60 0.3, 0.09]);
	end


%% birthdate
	if any(contains(editableField,'birthdate'))
		SubjectFigure.NameEditableTextBox = uiw.widget.EditableText(...      
		'Parent',SubjectFigure.MainFigure,...
		'Value',datestr(Subject.birthDay, 'dd/mm/yyyy'),...
		'Label','Name',...
		'LabelLocation','top',...
		'LabelWidth',90,...
		'Units','normalized',...
		'Position',[0.05 0.45 0.3, 0.09]);
	else
		SubjectFigure.NameTextBox = uiw.widget.FixedText(...      
		'Parent',SubjectFigure.MainFigure,...
		'Value',datestr(Subject.birthDay, 'dd/mm/yyyy'),...
		'Label','Birthday:',...
		'LabelLocation','top',...
		'LabelWidth',90,...
		'Units','normalized',...
		'Position',[0.05 0.45 0.3, 0.09]);
	end
	

%% note
	if any(contains(editableField,'note'))
		SubjectFigure.NameEditableTextBox = uiw.widget.EditableText(...      
		'Parent',SubjectFigure.MainFigure,...
		'Value',Subject.note,...
		'Label','Note',...
		'LabelLocation','top',...
		'IsMultiLine', true,...
		'LabelWidth',90,...
		'Units','normalized',...
		'Position',[0.05 0.05 0.3, 0.35]);
	else
		SubjectFigure.NameTextBox = uiw.widget.FixedText(...      
		'Parent',SubjectFigure.MainFigure,...
		'Value',Subject.note,...
		'Label','Note:',...
		'LabelLocation','top',...
		'LabelWidth',90,...
		'Units','normalized',...
		'Position',[0.05 0.05 0.3, 0.35]);
	end

%% other info	
	
	infoList = fieldnames(Subject.Info);
	nInfo = length(infoList);
	for iInfo = 1 : nInfo
		field = infoList{iInfo};
		ypos = 0.9*(1-(iInfo-1)/nInfo);
		xpos = 0.5;
			
		
		if any(contains(editableField,field))
			SubjectFigure.NameEditableTextBox = uiw.widget.EditableText(...      
			'Parent',SubjectFigure.MainFigure,...
			'Value',Subject.Info.(field),...
			'Label',field,...
			'LabelLocation','top',...
			'IsMultiLine', true,...
			'LabelWidth',90,...
			'Units','normalized',...
			'Position',[xpos ypos 0.3, 0.09]);
		else
			SubjectFigure.NameTextBox = uiw.widget.FixedText(...      
			'Parent',SubjectFigure.MainFigure,...
			'Value',Subject.Info.(field),...
			'Label',field,...
			'LabelLocation','top',...
			'LabelWidth',90,...
			'Units','normalized',...
			'Position',[xpos ypos 0.3, 0.09]);
		end
	end
end
