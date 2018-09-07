function newmeasdispprobe(Subject, GHandle)
	dxsxEdge = 0.05;
	overunderEdge = 0.009;
	textBoxWidth = 0.3;
	textBoxHeight = 0.12;
	
	textFontSize = GHandle.Preference.Font.sizeM;

	
	% id
	lowerPos = (0.3 +overunderEdge) + 3 *( 0.7 - overunderEdge)/4;
	GHandle.TempWindow.SubjectIdTextBox = gtextbox(...      
		'Parent',GHandle.TempWindow.ProbePannel,...
		'TextString',Subject.id,...
		'TitleString','ID:',...
		'Units','normalized',...
		'FontSize',textFontSize,...
		'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);

	
	lowerPos = (0.3 +overunderEdge) + 2 *( 0.7 - overunderEdge)/4;
	% name	

		GHandle.TempWindow.SubjectNameTextBox = gtextbox(...      
		'Parent',GHandle.TempWindow.ProbePannel,...
		'TextString',Subject.name,...
		'TitleString','Name:',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);

	
end


