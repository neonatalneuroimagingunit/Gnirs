function  newmeasmodsubject(GHandle)
	dxsxEdge = 0.05;
	overunderEdge = 0.009;
	textBoxWidth = 0.3;
	textBoxHeight = 0.12;
	textFontSize = GHandle.Preference.Font.sizeM;

	Subject = GHandle.CurrentDataSet.Subject;
	

	%gray out the pannel
	delete(GHandle.TempWindow.SubjectPannel.Children);
	% id
	lowerPos = (0.3 +overunderEdge) + 3 *( 0.7 - overunderEdge)/4;
	GHandle.TempWindow.IdTextBox = gtextbox(...      
		'Parent',GHandle.TempWindow.SubjectPannel,...
		'TextString',Subject.id,...
		'TitleString','ID:',...
		'Units','normalized',...
		'FontSize',textFontSize,...
		'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);

	
	lowerPos = (0.3 +overunderEdge) + 2 *( 0.7 - overunderEdge)/4;
	% name	
	GHandle.TempWindow.NameEditableTextBox = geditabletext(...      
		'Parent',GHandle.TempWindow.SubjectPannel,...
		'TextString',Subject.name,...
		'TitleString','Name',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);

	
	% Surname	
	lowerPos = (0.3 +overunderEdge) + 1 *( 0.7 - overunderEdge)/4;

	GHandle.TempWindow.SurnameEditableTextBox = geditabletext(...      
		'Parent',GHandle.TempWindow.SubjectPannel,...
		'TextString',Subject.surName,...
		'TitleString','Surname',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);

	% Birthdate
	lowerPos = (0.3 +overunderEdge);
	GHandle.TempWindow.BirthdateEditableTextBox = geditabletext(...      
		'Parent',GHandle.TempWindow.SubjectPannel,...
		'TextString',datestr(Subject.birthDay, 'dd/mm/yyyy'),...
		'TitleString','Birthdate',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);
	
	% note

	GHandle.TempWindow.NoteEditableTextBox = geditabletext(...      
		'Parent',GHandle.TempWindow.SubjectPannel,...
		'TextString',Subject.note,...
		'TitleString','Note',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge overunderEdge textBoxWidth 0.3-overunderEdge]);

	% plot the info list
	infoList = fieldnames(Subject.Info);
	nInfo = length(infoList);
	for iInfo = 1 : nInfo
		field = infoList{iInfo};
		fieldTextString = num2str(Subject.Info.(field));
		
		ypos = (1 - overunderEdge - textBoxHeight ) -  (iInfo-1)/nInfo;
		xpos = 0.5;
			
		tag = [field ,'EditableTextBox'];
			GHandle.TempWindow.EditableInfo.(tag) = geditabletext(...      
			'Parent',GHandle.TempWindow.SubjectPannel,...
			'TextString',fieldTextString,...
			'TitleString',[field,':'],...
			'FontSize',textFontSize,...
			'Units','normalized',...
			'Position',[xpos ypos textBoxWidth, textBoxHeight]);
	end
	
end

