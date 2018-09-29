function  newmeasdispmeasure(GHandle)
	dxsxEdge = 0.05;
	overunderEdge = 0.019;
	textBoxWidth = 0.3;
	textBoxHeight = 0.12;
	
	textFontSize = GHandle.Preference.Font.sizeM;
	
	
	Measure = GHandle.CurrentDataSet.Measure;
	% id
	lowerPos = (0.3 +overunderEdge) + 3 *( 0.7 - overunderEdge)/4;
	GHandle.TempWindow.MeasureIdTextBox = gtextbox(...      
		'Parent',GHandle.TempWindow.MeasurePannel,...
		'TextString',Measure.id,...
		'TitleString','ID:',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);

	% date
	lowerPos = (0.3 +overunderEdge) + 2 *( 0.7 - overunderEdge)/4;
		GHandle.TempWindow.MeasureDate = gtextbox(...      
		'Parent',GHandle.TempWindow.MeasurePannel,...
		'TextString',datestr(Measure.date, 'dd/mm/yyyy'),...
		'TitleString','Date:',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);

	
	%duration
	lowerPos = (0.3 +overunderEdge) + 1 *( 0.7 - overunderEdge)/4;
	GHandle.TempWindow.MeasureTimeLength = gtextbox(...      
		'Parent',GHandle.TempWindow.MeasurePannel,...
		'TextString',num2str(Measure.timeLength),...
		'TitleString','Time Length:',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);

	
	
	%update rate
	lowerPos = (0.3 +overunderEdge);
	GHandle.TempWindow.MeasureUpdateRate = gtextbox(...      
		'Parent',GHandle.TempWindow.MeasurePannel,...
		'TextString',num2str(Measure.updateRate),...
		'TitleString','Update Rate:',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge lowerPos textBoxWidth textBoxHeight]);

	
	% note
		GHandle.TempWindow.MeasureNoteEditableTextBox = geditabletext(...      
		'Parent',GHandle.TempWindow.MeasurePannel,...
		'TextString',Measure.note,...
		'TitleString','Note',...
		'FontSize',textFontSize,...
		'Units','normalized',...
		'Position',[dxsxEdge overunderEdge textBoxWidth 0.3-overunderEdge]);
	
	% plot the info list
% 	infoList = fieldnames(Measure.Info);
% 	nInfo = length(infoList);
% 	for iInfo = 1 : nInfo
% 		field = infoList{iInfo};
% 		fieldTextString = num2str(Measure.Info.(field));
% 		
% 		ypos = (1 - overunderEdge - textBoxHeight ) -  (iInfo-1)/nInfo;
% 		xpos = 0.5;
% 			
% 		tag = [field ,'EditableTextBox'];
% 			GHandle.Main.Display.SubPanel(idx).(tag) = gtextbox(...      
% 			'Parent',GHandle.Main.Display.SubPanel(idx).Panel,...
% 			'TextString',fieldTextString,...
% 			'TitleString',[field,':'],...
% 			'FontSize',textFontSize,...
% 			'Units','normalized',...
% 			'Position',[xpos ypos textBoxWidth, textBoxHeight]);
% 	end
end

