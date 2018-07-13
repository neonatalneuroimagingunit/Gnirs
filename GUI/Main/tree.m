function [Hmain] = tree(Hmain,DataBase)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


	Hmain.Tree.Main = uiw.widget.Tree(...
		'Parent',Hmain.mainFigure,...
		'Label','Database:', ...
		'LabelLocation','top',...
		'LabelHeight',18,...
		'Units', 'normalized', ...
		'Position', [0 0 0.2 0.90],...
		'RootVisible', 'false'...
		);





	studyIcon = fullfile(matlabroot,'toolbox','matlab','icons','pagesicon.gif');
	measureIcon = fullfile(matlabroot,'toolbox','matlab','icons','pageicon.gif');


	for iStudy = 1:DataBase.nStudy
		
			Hmain.Tree.StudyNode(iStudy).MainNode = uiw.widget.TreeNode(...
				'Name', DataBase.Study(iStudy).tag,...
				'Parent', Hmain.Tree.Main.Root,...
				'Value', DataBase.Study(iStudy).id...
				); %create a node for each study
			
			setIcon(Hmain.Tree.StudyNode(iStudy).MainNode,studyIcon);  %set his icon
			
			Hmain.Tree.StudyNode(iStudy).ContextMenu = uicontextmenu('Parent',Hmain.mainFigure); % add the new measure right click
			uimenu(Hmain.Tree.StudyNode(iStudy).ContextMenu,'Label','AddMeasure','callback',{@NewNIRSMeasure ,Hmain,DataBase});
			set(Hmain.Tree.StudyNode(iStudy).MainNode,'UIContextMenu',Hmain.Tree.StudyNode(iStudy).ContextMenu);
			
			for iMeasure = 1:DataBase.Study(iStudy).nMeasure %for each measure in the study create a new branch
				
				Hmain.Tree.StudyNode(iStudy).Measures(iMeasure).MainNode = uiw.widget.TreeNode(... 
				'Name',DataBase.Study(iStudy).Measure(iMeasure).tag ,...
				'Value', DataBase.Study(iStudy).Measure(iMeasure).ID,...
				'Parent',Hmain.Tree.StudyNode(iStudy).MainNode...
			);
			
 				setIcon(Hmain.Tree.StudyNode(iStudy).Measures(iMeasure).MainNode,measureIcon);%add the measure icon
				
				for iAnalysis = 1:(DataBase.Study(iStudy).Measure(iMeasure).nAnalysis + 1) %for each analysis plus the row one in the measure create a new branch
					Hmain.Tree.StudyNode(iStudy).Measures(iMeasure).Analysis(iAnalysis).MainNode = uiw.widget.TreeNode(... 
					'Name',DataBase.Study(iStudy).Measure(iMeasure).Analysis(iAnalysis).tag ,...
					'Value',DataBase.Study(iStudy).Measure(iMeasure).Analysis(iAnalysis).ID ,...
					'Parent',Hmain.Tree.StudyNode(iStudy).Measures(iMeasure).MainNode);
				end
			
			end
	end
	
%% clk sx for new study 	
	% For the whole tree
	
	
	Hmain.Tree.ContextMenu = uicontextmenu('Parent',Hmain.mainFigure); 
	uimenu(Hmain.Tree.ContextMenu,'Label','AddStudy','callback',{@NewNIRSStudy ,Hmain,DataBase});
	set(Hmain.Tree.Main,'UIContextMenu',Hmain.Tree.ContextMenu)
	

	Hmain.Tree.Main.MouseClickedCallback = {@clickcallback,Hmain,DataBase};

end



function clickcallback(Handle, Event, MainHandle ,NirsDataBase)
	if ~isempty(Event.Nodes) % click on a node
		switch Event.Nodes.Value(end-3) %position of the identifier of the IDtype
			case 'S'%study
				switch Event.SelectionType
					case 'normal'
						studyId = Event.Nodes.Value;
						Study = findstudy(studyId, NirsDataBase);
						displaystudy(Study, MainHandle.DisplayPannel);
					case 'open'
						%'doublestudy
					case 'alt'
						%'dxstudy
				end
			case 'M' %measure
				switch Event.SelectionType
					case 'normal'
						measureId = Event.Nodes.Value;
						Measure = findmeasure(measureId, NirsDataBase);
						displaymeasure(Measure, MainHandle.DisplayPannel);
					case 'open'
						%sprintf('doublemeasure')
					case 'alt'
						%sprintf('dxmeasure')
				end
			case 'A'%Analysis
				switch Event.SelectionType
					case 'normal'
						analysisId = Event.Nodes.Value;
						measureId = analysisId(1:end-4);
						Analysis = findanalysis(analysisId, NirsDataBase);
						Measure = findmeasure(measureId, NirsDataBase);
						displayanalysis(Measure, Analysis, MainHandle.DisplayPannel);
					case 'open'
						openanalysiswiewer(Event.Nodes.Value, MainHandle.dataBasePath);
					case 'alt'
						%sprintf('dxAnalysis')
				end
			case 'P' %probe
				switch Event.SelectionType
					case 'normal'
						displayprobe(MainHandle.DisplayPannel,NirsDataBase)
					case 'open'
						openanprobewiewer()
					case 'alt'
						%sprintf('dxmprobe')
				end
			case 'G' %group
				switch Event.SelectionType
					case 'normal'
						displaygoup(MainHandle.DisplayPannel,NirsDataBase)
					case 'open'
						%sprintf('doublegroup')
					case 'alt'
						%sprintf('dxgroup')
				end
			case 'Z' %anatomy
				switch Event.SelectionType
					case 'normal'
						displayanatomy(MainHandle.DisplayPannel,NirsDataBase)
					case 'open'
						%sprintf('doubleanatomy')
					case 'alt'
						%sprintf('dxanatomy')
				end
			otherwise
				% check
			
				
		end
	end
end


