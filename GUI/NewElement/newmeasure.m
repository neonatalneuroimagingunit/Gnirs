function newmeasure(~, ~, GHandle)
%NEWMEASURE Summary of this function goes here
%   Detailed explanation goes here\
	

	studyId = GHandle.Main.Tree.StudyTree.SelectedNodes.Value;
	DBStudy = GHandle.DataBase.findid(studyId);
	GHandle.CurrentDataSet.Study = DBStudy.load;

	sxPos = [0.05 0.35 0.65 0.05 0.35 0.65];
	bottomPos = [0.15 0.15 0.15 0.85 0.85 0.85];
	width = [0.27 0.27 0.27 0.27 0.27 0.27];
	height = [0.7 0.7 0.7 0.05 0.05 0.05];
	
	ProbeList.tag = {GHandle.DataBase.Probe(:).tag};
	ProbeList.id = {GHandle.DataBase.Probe(:).id};
	SubjectList.tag = {'New Subject', GHandle.DataBase.Subject(:).tag};
	SubjectList.id = {'000', GHandle.DataBase.Subject(:).id};
	


%close all temp figure

%closetempfigure(GHandle);

%create gui
	GHandle.TempWindow.NewMeasureFigure = figure(...
		'position', GHandle.Preference.Figure.sizeLarge,...
		'Resize', 'on',...
		'Name', 'New NIRS Measure', ...
		'Numbertitle', 'off', ...
		'Toolbar', 'none', ...
		'Menubar', 'none', ...
		'DoubleBuffer', 'on', ...
		'DockControls', 'off', ...
		'Renderer', 'OpenGL',...
		'Visible', 'off' ...
	);			



	GHandle.TempWindow.MeasurePannel = uipanel (...
				'Parent',GHandle.TempWindow.NewMeasureFigure,...
				'Title', 'Measure',...
				'Units', 'normalized',...
				'Position',[sxPos(1) bottomPos(1) width(1) height(1)]);
			
	GHandle.TempWindow.SubjectPannel = uipanel (...
				'Parent',GHandle.TempWindow.NewMeasureFigure,...
				'Title', 'Subject',...
				'Units', 'normalized',...
				'Position',[sxPos(2) bottomPos(2) width(2) height(2)]);
			
	GHandle.TempWindow.ProbePannel = uipanel (...
				'Parent',GHandle.TempWindow.NewMeasureFigure,...
				'Title', 'Probe',...
				'Units', 'normalized',...
				'Position',[sxPos(3) bottomPos(3) width(3) height(3)]);

			
	  GHandle.TempWindow.MeasureWidget = uiw.widget.FileSelector(...
			'Value', 'C:\matlab.mat', ...
			'Pattern', {'*.mat','MATLAB MAT files (*.mat)';'*.txt','Text files (*.txt)'; '*.csv','CSV files (*.csv)'}, ...
			'Parent',GHandle.TempWindow.NewMeasureFigure,...
			'Units','normalized',...
			'Callback',@(Handle,Event)preload(Handle,Event,GHandle),...
			'Position',[sxPos(4) bottomPos(4) width(4) height(4)]);    

	 GHandle.TempWindow.SubjectWidget = uiw.widget.EditablePopup(...
			'Parent',GHandle.TempWindow.NewMeasureFigure,...
			'Items', SubjectList.tag,...
			'UserData', SubjectList,...
			'Callback',@(Handle,Event)subjectwidgetcallback(Handle,Event,GHandle),...
			'Units','normalized',...
			'Position',[sxPos(5) bottomPos(5) width(5) height(5)]);  
	
	 GHandle.TempWindow.ProbeWidget = uiw.widget.EditablePopup(...
			'Parent',GHandle.TempWindow.NewMeasureFigure,...
			'Items', ProbeList.tag ,...
			'UserData', ProbeList,...
			'Callback',@(Handle,Event)probewidgetcallback(Handle,Event,GHandle),...
			'Units','normalized',...
			'Position',[sxPos(6) bottomPos(6) width(6) height(6)]); 
		
		
	GHandle.TempWindow.NewStudyLoadButton = uicontrol('Style', 'pushbutton',...	
		'Parent', GHandle.TempWindow.NewMeasureFigure, ...
		'String', 'Load',...
		'Units', 'normalize', ...
		'Position', [0.8 0.05 0.1 0.05],...
		'Callback', {@loadmeasure ,GHandle}...
	); 

GHandle.TempWindow.NewMeasureFigure.Visible = 'on';
end


%% function 
function preload(~, Event, GHandle)
	GHandle.Temp.fast = true;
	GHandle.Temp.location = Event.NewValue;
	boxyparser(GHandle);
	newmeasdispmeasure(GHandle);
end


function probewidgetcallback(Handle, Event, GHandle)
	
	if isempty(Event.NewSelectedIndex)
		filterlist(Handle, Event);
		
	else
		DBProbe = GHandle.DataBase.Probe(Handle.SelectedIndex);
		Probe = DBProbe.load;
		newmeasdispprobe(Probe, GHandle);
	end

end

function subjectwidgetcallback(Handle, Event, GHandle)
	
	if isempty(Event.NewSelectedIndex)
			filterlist(Handle, Event);

	elseif(strcmp(Event.NewValue, 'New Subject'))
		if ~isempty(GHandle.CurrentDataSet.Study.SubjectTemplate)
			Subject = GHandle.CurrentDataSet.Study.SubjectTemplate;
		else 
			Subject = NirsSubject;	
		end
		GHandle.CurrentDataSet.Subject = Subject;
		newmeasmodsubject(GHandle);
		
	else	
		DBSubject = GHandle.DataBase.Subject(Handle.SelectedIndex-1);
		Subject = DBSubject.load;
		GHandle.CurrentDataSet.Subject = Subject;
		newmeasdispsubject(GHandle);
	
	end
end

function filterlist( Handle, Event)
	idx = contains(Handle.UserData.tag, Event.NewString);
	
	Handle.Items = {Handle.UserData.tag{idx}};

end


function loadmeasure( ~, ~,GHandle)

%save the temp data
	GHandle.Temp.location = GHandle.TempWindow.MeasureWidget.Value;
	measureNote = GHandle.TempWindow.MeasureNoteEditableTextBox.Text.String;
	
	
%check if the subject exist if not ad it
	if (strcmp(GHandle.TempWindow.SubjectWidget.Value, 'New Subject'))
		subjectName = GHandle.TempWindow.NameEditableTextBox.Text.String;
		subjectSurname = GHandle.TempWindow.SurnameEditableTextBox.Text.String;
		subjectBirthdate = datetime(GHandle.TempWindow.BirthdateEditableTextBox.Text.String,...
							'InputFormat','dd/MM/yyyy');
	%	subjectInfo
		SubjectNote = GHandle.TempWindow.NoteEditableTextBox.Text.String;
		NewSubject = NirsSubject('name', subjectName,...
							'surname',subjectSurname,...
							'birthday' ,subjectBirthdate,...
							'note', SubjectNote);
		
		
		DataBase = GHandle.DataBase.add(NewSubject);
		GHandle.DataBase = DataBase;
		
		%modify this part
		GHandle.CurrentDataSet.Subject.id = GHandle.DataBase.Subject(end).id; 
	end

%close the figure
	close(GHandle.TempWindow.NewMeasureFigure)
	GHandle.TempWindow = [];
	
%open pharser
	GHandle.Temp.fast = false;
	
	boxyparser(GHandle);
	
%create the new variable

	NewMeasure = NirsMeasure(GHandle.CurrentDataSet.Measure,...
						'studyid',GHandle.CurrentDataSet.Study.id,...
						'subjectid',GHandle.CurrentDataSet.Subject.id,...
						'note', measureNote);
					
	DataBase = GHandle.DataBase.add(NewMeasure);
	GHandle.DataBase = DataBase;
	
	
	NewAnalysis = NirsAnalysis(GHandle.CurrentDataSet.Analysis,...
							'measureid',GHandle.DataBase.Measure(end).id,...%modify this part
							'date',GHandle.CurrentDataSet.Measure.date);
						
	DataBase = GHandle.DataBase.add(NewAnalysis);
	GHandle.DataBase = DataBase;
	
	Data = GHandle.CurrentDataSet.Data;
	path = GHandle.DataBase.Analysis(end).path;
	save(path,'Data','-append')
%add to the database


	

	
	tree(GHandle);
%clear temp vars
	GHandle.Temp = [];
end



























