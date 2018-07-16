function [Hmain] = tree(Hmain,DataBase)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
databaseIdLength = 7;

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
		
			if ~isempty(DataBase.Study(iStudy).tag)
				tag = DataBase.Study(iStudy).tag;
			else
				tag = GBDStudy.id2postfix(DataBase.Study(iStudy).id);
			end
			
			Hmain.Tree.Study(iStudy).MainNode = uiw.widget.TreeNode(...
				'Name', tag,...
				'Parent', Hmain.Tree.Main.Root,...
				'Value', DataBase.Study(iStudy).id...
				); %create a node for each study
			
			setIcon(Hmain.Tree.Study(iStudy).MainNode,studyIcon);  %set his icon
			
			Hmain.Tree.Study(iStudy).ContextMenu = uicontextmenu('Parent',Hmain.mainFigure); % add the new measure right click
			uimenu(Hmain.Tree.Study(iStudy).ContextMenu,'Label','AddMeasure','callback',{@NewNIRSMeasure ,Hmain,DataBase});
			set(Hmain.Tree.Study(iStudy).MainNode,'UIContextMenu',Hmain.Tree.Study(iStudy).ContextMenu);
	end		
	for iMeasure = 1:DataBase.nMeasure %for each measure in the study create a new branch
			[~, idxStudy] = DataBase.findid(DataBase.Measure(iMeasure).studyId);
			
			if ~isempty(DataBase.Measure(iMeasure).tag)
				tag = DataBase.Measure(iMeasure).tag;
			else
				tag = GDBMeasure.id2postfix(DataBase.Measure(iMeasure).id);
			end
			
			Hmain.Tree.Measure(iMeasure).MainNode = uiw.widget.TreeNode(... 
			'Name',tag ,...
			'Value', DataBase.Measure(iMeasure).id,...
			'Parent',Hmain.Tree.Study(idxStudy).MainNode...
			);
			
 			setIcon(Hmain.Tree.Measure(iMeasure).MainNode, measureIcon);%add the measure icon
	end				
	
	for iAnalysis = 1:(DataBase.nAnalysis) %for each analysis plus the row one in the measure create a new branch
		[~, idxMeasure] = DataBase.findid(DataBase.Analysis(iAnalysis).measureId);			

		if ~isempty(DataBase.Analysis(iAnalysis).tag)
			tag = DataBase.Analysis(iAnalysis).tag;
		else
			tag = GDBAnalysis.id2postfix(DataBase.Analysis(iAnalysis).id);
		end
		
		Hmain.Tree.Analysis(iAnalysis).MainNode = uiw.widget.TreeNode(... 
					'Name',tag ,...
					'Value',DataBase.Analysis(iAnalysis).id ,...
					'Parent',Hmain.Tree.Measure(idxMeasure).MainNode);
				
		setIcon(Hmain.Tree.Analysis(iAnalysis).MainNode, measureIcon);%add the measure icon	
			
	end
	
		for iAtlas = 1:DataBase.nAtlas
		
			if ~isempty(DataBase.Atlas(iStudy).tag)
				tag = DataBase.Atlas(iStudy).tag;
			else
				tag = GBDStudy.id2postfix(DataBase.Atlas(iStudy).id);
			end
			
			Hmain.Tree.Atlas(iAtlas).MainNode = uiw.widget.TreeNode(...
				'Name', tag,...
				'Parent', Hmain.Tree.Main.Root,...
				'Value', DataBase.Atlas(iAtlas).id...
				); %create a node for each Atlas
			
			setIcon(Hmain.Tree.Atlas(iAtlas).MainNode,studyIcon);  %set his icon
			
			Hmain.Tree.Atlas(iAtlas).ContextMenu = uicontextmenu('Parent',Hmain.mainFigure); % add the new measure right click
			uimenu(Hmain.Tree.Atlas(iAtlas).ContextMenu,'Label','AddMeasure','callback',{@NewNIRSMeasure ,Hmain,DataBase});
			set(Hmain.Tree.Atlas(iAtlas).MainNode,'UIContextMenu',Hmain.Tree.Atlas(iAtlas).ContextMenu);
	end	

	for iProbe = 1:DataBase.nProbe

		if ~isempty(DataBase.Probe(iProbe).tag)
			tag = DataBase.Probe(iProbe).tag;
		else
			tag = GBDProbe.id2postfix(DataBase.Probe(iProbe).id);
		end

		Hmain.Tree.Probe(iProbe).MainNode = uiw.widget.TreeNode(...
			'Name', tag,...
			'Parent', Hmain.Tree.Main.Root,...
			'Value', DataBase.Probe(iProbe).id...
			); %create a node for each study

		setIcon(Hmain.Tree.Probe(iProbe).MainNode,studyIcon);  %set his icon

		Hmain.Tree.Probe(iProbe).ContextMenu = uicontextmenu('Parent',Hmain.mainFigure); % add the new measure right click
		uimenu(Hmain.Tree.Probe(iProbe).ContextMenu,'Label','AddMeasure','callback',{@NewNIRSMeasure ,Hmain,DataBase});
		set(Hmain.Tree.Probe(iProbe).MainNode,'UIContextMenu',Hmain.Tree.Probe(iProbe).ContextMenu);
	end	
% %% clk sx for new study 	
% 	% For the whole tree
% 	
% 	
% 	Hmain.Tree.ContextMenu = uicontextmenu('Parent',Hmain.mainFigure); 
% 	uimenu(Hmain.Tree.ContextMenu,'Label','AddStudy','callback',{@NewNIRSStudy ,Hmain,DataBase});
% 	set(Hmain.Tree.Main,'UIContextMenu',Hmain.Tree.ContextMenu)
% 	
% 
% 	Hmain.Tree.Main.MouseClickedCallback = {@clickcallback,Hmain,DataBase};
% 
 end
% 
% 
% 
% function clickcallback(Handle, Event, MainHandle ,NirsDataBase)
% 	if ~isempty(Event.Nodes) % click on a node
% 		switch Event.Nodes.Value(databaseIdLength + 1) %position of the identifier of the IDtype
% 			case 'S'%study
% 				switch Event.SelectionType
% 					case 'normal'
% 						studyId = Event.Nodes.Value;
% 						Study = findstudy(studyId, NirsDataBase);
% 						displaystudy(Study, MainHandle.DisplayPannel);
% 					case 'open'
% 						%'doublestudy
% 					case 'alt'
% 						%'dxstudy
% 				end
% 			case 'M' %measure
% 				switch Event.SelectionType
% 					case 'normal'
% 						measureId = Event.Nodes.Value;
% 						Measure = findmeasure(measureId, NirsDataBase);
% 						displaymeasure(Measure, MainHandle.DisplayPannel);
% 					case 'open'
% 						%sprintf('doublemeasure')
% 					case 'alt'
% 						%sprintf('dxmeasure')
% 				end
% 			case 'A'%Analysis
% 				switch Event.SelectionType
% 					case 'normal'
% 						analysisId = Event.Nodes.Value;
% 						measureId = analysisId(1:end-4);
% 						Analysis = findanalysis(analysisId, NirsDataBase);
% 						Measure = findmeasure(measureId, NirsDataBase);
% 						displayanalysis(Measure, Analysis, MainHandle.DisplayPannel);
% 					case 'open'
% 						openanalysiswiewer(Event.Nodes.Value, MainHandle.dataBasePath);
% 					case 'alt'
% 						%sprintf('dxAnalysis')
% 				end
% 			case 'P' %probe
% 				switch Event.SelectionType
% 					case 'normal'
% 						displayprobe(MainHandle.DisplayPannel,NirsDataBase)
% 					case 'open'
% 						openanprobewiewer()
% 					case 'alt'
% 						%sprintf('dxmprobe')
% 				end
% 			case 'G' %group
% 				switch Event.SelectionType
% 					case 'normal'
% 						displaygoup(MainHandle.DisplayPannel,NirsDataBase)
% 					case 'open'
% 						%sprintf('doublegroup')
% 					case 'alt'
% 						%sprintf('dxgroup')
% 				end
% 			case 'Z' %anatomy
% 				switch Event.SelectionType
% 					case 'normal'
% 						displayanatomy(MainHandle.DisplayPannel,NirsDataBase)
% 					case 'open'
% 						%sprintf('doubleanatomy')
% 					case 'alt'
% 						%sprintf('dxanatomy')
% 				end
% 			otherwise
% 				% check
% 			
% 				
% 		end
% 	end
% end
% 
% 