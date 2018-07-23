function [Hmain] = tree(Hmain,DataBase)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here



position = [0 0 0.2 0.90];
studyIcon = fullfile(matlabroot,'toolbox','matlab','icons','pagesicon.gif');
measureIcon = fullfile(matlabroot,'toolbox','matlab','icons','pageicon.gif');
analysisIcon = fullfile(matlabroot,'toolbox','matlab','icons','pageicon.gif');
probeIcon = fullfile(matlabroot,'toolbox','matlab','icons','pageicon.gif');
atlasIcon = fullfile(matlabroot,'toolbox','matlab','icons','pageicon.gif');

% create the tab
	Hmain.Tree.TabGroup = uitabgroup(Hmain.mainFigure,'Position',position);
	Hmain.Tree.StudyTab = uitab(Hmain.Tree.TabGroup,'Title','Study');
	Hmain.Tree.ProbeTab = uitab(Hmain.Tree.TabGroup,'Title','Probe');
	Hmain.Tree.AtlasTab = uitab(Hmain.Tree.TabGroup,'Title','Atlas');

% create the tree
	Hmain.Tree.StudyTree = uiw.widget.Tree(...
		'Parent',Hmain.Tree.StudyTab,...
		'Label','Database:', ...
		'LabelLocation','top',...
		'LabelHeight',18,...
		'Units', 'normalized', ...
		'Position', [0 0 1 1],...
		'RootVisible', 'false'...
		);
	
	Hmain.Tree.ProbeTree = uiw.widget.Tree(...
		'Parent',Hmain.Tree.ProbeTab,...
		'Label','Database:', ...
		'LabelLocation','top',...
		'LabelHeight',18,...
		'Units', 'normalized', ...
		'Position', [0 0 1 1],...
		'RootVisible', 'false'...
		);

	Hmain.Tree.AtlasTree = uiw.widget.Tree(...
		'Parent',Hmain.Tree.AtlasTab,...
		'Label','Database:', ...
		'LabelLocation','top',...
		'LabelHeight',18,...
		'Units', 'normalized', ...
		'Position', [0 0 1 1],...
		'RootVisible', 'false'...
		);

	Hmain.Tree.StudyTree.MouseClickedCallback = {@clickcallback,Hmain,DataBase}; 
	Hmain.Tree.ProbeTree.MouseClickedCallback = {@clickcallback,Hmain,DataBase}; 
	Hmain.Tree.AtlasTree.MouseClickedCallback = {@clickcallback,Hmain,DataBase}; 
	
	% add the new study right click
	Hmain.Tree.ContextMenu = uicontextmenu('Parent',Hmain.mainFigure); 
	uimenu(Hmain.Tree.ContextMenu,'Label','AddStudy','callback',{@NewStudy, Hmain, DataBase});
	set(Hmain.Tree.StudyTree,'UIContextMenu',Hmain.Tree.ContextMenu);
	
	

	%create a node for each study
	for iStudy = 1:DataBase.nStudy
		
			% check if htere is a tag 
			if ~isempty(DataBase.Study(iStudy).tag)
				tag = DataBase.Study(iStudy).tag;
			else
				tag = GBDStudy.id2postfix(DataBase.Study(iStudy).id);
			end
			
			Hmain.Tree.Study(iStudy).MainNode = uiw.widget.TreeNode(...
				'Name', tag,...
				'Parent', Hmain.Tree.StudyTree.Root,...
				'Value', DataBase.Study(iStudy).id...
				); 
			
			%set his icon
			setIcon(Hmain.Tree.Study(iStudy).MainNode,studyIcon); 
			
			% add right click callback
			Hmain.Tree.Study(iStudy).ContextMenu = uicontextmenu('Parent',Hmain.mainFigure); 
			
			uimenu(Hmain.Tree.Study(iStudy).ContextMenu,'Label','Add Measure','callback',{@NewMeasure ,Hmain,DataBase});
			uimenu(Hmain.Tree.Study(iStudy).ContextMenu,'Label','Modify','callback',{@ModifyStudy ,Hmain,DataBase});
			uimenu(Hmain.Tree.Study(iStudy).ContextMenu,'Label','Delete','callback',{@DeleteStudy ,Hmain,DataBase});
			
			set(Hmain.Tree.Study(iStudy).MainNode,'UIContextMenu',Hmain.Tree.Study(iStudy).ContextMenu);
	end		
	
	
	%create a node for each measure
	for iMeasure = 1:DataBase.nMeasure %for each measure in the study create a new branch
			[~, idxStudy] = DataBase.findid(DataBase.Measure(iMeasure).studyId);
			
			% check if htere is a tag 
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
		
			%set his icon
 			setIcon(Hmain.Tree.Measure(iMeasure).MainNode, measureIcon);%add the measure icon
			
			% add right click callback
			Hmain.Tree.Measure(iMeasure).ContextMenu = uicontextmenu('Parent',Hmain.mainFigure); % add the new measure right click
			
			uimenu(Hmain.Tree.Measure(iMeasure).ContextMenu,'Label','Add Analysis','callback',{@Newalysis ,Hmain,DataBase});
			uimenu(Hmain.Tree.Measure(iMeasure).ContextMenu,'Label','Modify','callback',{@ModifyMeasure ,Hmain,DataBase});
			uimenu(Hmain.Tree.Measure(iMeasure).ContextMenu,'Label','Delete','callback',{@DeleteMeasure ,Hmain,DataBase});
			
			set(Hmain.Tree.Measure(iMeasure).MainNode,'UIContextMenu',Hmain.Tree.Measure(iMeasure).ContextMenu);
			
	end	
	
	%create a node for each analysis
	for iAnalysis = 1:(DataBase.nAnalysis) %for each analysis plus the row one in the measure create a new branch
		[~, idxMeasure] = DataBase.findid(DataBase.Analysis(iAnalysis).measureId);			

		% check if htere is a tag 
		if ~isempty(DataBase.Analysis(iAnalysis).tag)
			tag = DataBase.Analysis(iAnalysis).tag;
		else
			tag = GDBAnalysis.id2postfix(DataBase.Analysis(iAnalysis).id);
		end
		
		
		Hmain.Tree.Analysis(iAnalysis).MainNode = uiw.widget.TreeNode(... 
					'Name',tag ,...
					'Value',DataBase.Analysis(iAnalysis).id ,...
					'Parent',Hmain.Tree.Measure(idxMeasure).MainNode);
		
		%set his icon		
		setIcon(Hmain.Tree.Analysis(iAnalysis).MainNode, analysisIcon);%add the anlysis icon	
		
		% add right click callback
		Hmain.Tree.Analysis(iAnalysis).ContextMenu = uicontextmenu('Parent',Hmain.mainFigure); 

		uimenu(Hmain.Tree.Analysis(iAnalysis).ContextMenu,'Label','Modify','callback',{@modifyanalysis ,Hmain,DataBase});
		uimenu(Hmain.Tree.Analysis(iAnalysis).ContextMenu,'Label','Delete','callback',{@deleteanalysis ,Hmain,DataBase});
		uimenu(Hmain.Tree.Analysis(iAnalysis).ContextMenu,'Label','Develop','callback',{@developanalysis ,Hmain,DataBase});
		
		set(Hmain.Tree.Analysis(iAnalysis).MainNode,'UIContextMenu',Hmain.Tree.Analysis(iAnalysis).ContextMenu);
			
	end
	
	%create a node for each Atlas
	for iAtlas = 1:DataBase.nAtlas
		
		% check if there is a tag 
		if ~isempty(DataBase.Atlas(iAtlas).tag)
			tag = DataBase.Atlas(iAtlas).tag;
		else
			tag = GBDStudy.id2postfix(DataBase.Atlas(iAtlas).id);
		end

		Hmain.Tree.Atlas(iAtlas).MainNode = uiw.widget.TreeNode(...
			'Name', tag,...
			'Parent', Hmain.Tree.AtlasTree.Root,...
			'Value', DataBase.Atlas(iAtlas).id...
			); %create a node for each Atlas
		
		%set his icon
		setIcon(Hmain.Tree.Atlas(iAtlas).MainNode,atlasIcon);  

		% add right click callback
		Hmain.Tree.Atlas(iAtlas).ContextMenu = uicontextmenu('Parent',Hmain.mainFigure); % add the new measure right click
		uimenu(Hmain.Tree.Atlas(iAtlas).ContextMenu,'Label','AddAtlas','callback',{@NewNIRSMeasure ,Hmain,DataBase});
		set(Hmain.Tree.Atlas(iAtlas).MainNode,'UIContextMenu',Hmain.Tree.Atlas(iAtlas).ContextMenu);
	end	

	%create a node for each Atlas
	for iProbe = 1:DataBase.nProbe

		% check if there is a tag 
		if ~isempty(DataBase.Probe(iProbe).tag)
			tag = DataBase.Probe(iProbe).tag;
		else
			tag = GBDProbe.id2postfix(DataBase.Probe(iProbe).id);
		end

		
		Hmain.Tree.Probe(iProbe).MainNode = uiw.widget.TreeNode(...
			'Name', tag,...
			'Parent', Hmain.Tree.ProbeTree.Root,...
			'Value', DataBase.Probe(iProbe).id...
			); %create a node for each study

		%set his icon
		setIcon(Hmain.Tree.Probe(iProbe).MainNode,probeIcon);  %set his icon

		% add right click callback
		Hmain.Tree.Probe(iProbe).ContextMenu = uicontextmenu('Parent',Hmain.mainFigure); % add the new measure right click
		uimenu(Hmain.Tree.Probe(iProbe).ContextMenu,'Label','AddMeasure','callback',{@NewNIRSMeasure ,Hmain,DataBase});
		set(Hmain.Tree.Probe(iProbe).MainNode,'UIContextMenu',Hmain.Tree.Probe(iProbe).ContextMenu);
		
		
		
	end	
end
	
function clickcallback(~, Event, MainHandle ,DataBase) 
		if ~isempty(Event.Nodes) % click on a node 
			switch Event.SelectionType 
				case 'normal' 
					populatedisplay(Event.Nodes.Value, DataBase, MainHandle);
				case 'open' 
					%'doublestudy 
				case 'alt' 
					%'dxstudy	
			end 
		end

end
 



