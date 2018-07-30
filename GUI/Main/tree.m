function tree(GHandle)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here



position = [0 0 0.2 0.90];
studyIcon = fullfile(matlabroot,'toolbox','matlab','icons','pagesicon.gif');
measureIcon = fullfile(matlabroot,'toolbox','matlab','icons','pageicon.gif');
analysisIcon = fullfile(matlabroot,'toolbox','matlab','icons','pageicon.gif');
probeIcon = fullfile(matlabroot,'toolbox','matlab','icons','pageicon.gif');
atlasIcon = fullfile(matlabroot,'toolbox','matlab','icons','pageicon.gif');

% create the tab
	GHandle.Main.Tree.TabGroup = uitabgroup(GHandle.Main.Figure,'Position',position);
	GHandle.Main.Tree.StudyTab = uitab(GHandle.Main.Tree.TabGroup,'Title','Study');
	GHandle.Main.Tree.ProbeTab = uitab(GHandle.Main.Tree.TabGroup,'Title','Probe');
	GHandle.Main.Tree.AtlasTab = uitab(GHandle.Main.Tree.TabGroup,'Title','Atlas');

% create the tree
	GHandle.Main.Tree.StudyTree = uiw.widget.Tree(...
		'Parent',GHandle.Main.Tree.StudyTab,...
		'Label','Database:', ...
		'LabelLocation','top',...
		'LabelHeight',18,...
		'Units', 'normalized', ...
		'Position', [0 0 1 1],...
		'RootVisible', 'false'...
		);
	
	GHandle.Main.Tree.ProbeTree = uiw.widget.Tree(...
		'Parent',GHandle.Main.Tree.ProbeTab,...
		'Label','Database:', ...
		'LabelLocation','top',...
		'LabelHeight',18,...
		'Units', 'normalized', ...
		'Position', [0 0 1 1],...
		'RootVisible', 'false'...
		);

	GHandle.Main.Tree.AtlasTree = uiw.widget.Tree(...
		'Parent',GHandle.Main.Tree.AtlasTab,...
		'Label','Database:', ...
		'LabelLocation','top',...
		'LabelHeight',18,...
		'Units', 'normalized', ...
		'Position', [0 0 1 1],...
		'RootVisible', 'false'...
		);

	GHandle.Main.Tree.StudyTree.MouseClickedCallback = {@clickcallback,GHandle}; 
	GHandle.Main.Tree.ProbeTree.MouseClickedCallback = {@clickcallback,GHandle}; 
	GHandle.Main.Tree.AtlasTree.MouseClickedCallback = {@clickcallback,GHandle}; 
	
	% add the new study right click
	GHandle.Main.Tree.ContextMenu = uicontextmenu('Parent',GHandle.Main.Figure); 
	uimenu(GHandle.Main.Tree.ContextMenu,'Label','AddStudy','callback',{@NewStudy, GHandle});
	set(GHandle.Main.Tree.StudyTree,'UIContextMenu',GHandle.Main.Tree.ContextMenu);
	
	

	%create a node for each study
	for iStudy = 1:GHandle.DataBase.nStudy
		
			% check if htere is a tag 
			if ~isempty(GHandle.DataBase.Study(iStudy).tag)
				tag = GHandle.DataBase.Study(iStudy).tag;
			else
				tag = GBDStudy.id2postfix(GHandle.DataBase.Study(iStudy).id);
			end
			
			GHandle.Main.Tree.Study(iStudy).MainNode = uiw.widget.TreeNode(...
				'Name', tag,...
				'Parent', GHandle.Main.Tree.StudyTree.Root,...
				'Value', GHandle.DataBase.Study(iStudy).id...
				); 
			
			%set his icon
			setIcon(GHandle.Main.Tree.Study(iStudy).MainNode,studyIcon); 
			
			% add right click callback
			GHandle.Main.Tree.Study(iStudy).ContextMenu = uicontextmenu('Parent',GHandle.Main.Figure); 
			
			uimenu(GHandle.Main.Tree.Study(iStudy).ContextMenu,'Label','Add Measure','callback',{@NewMeasure ,GHandle});
			uimenu(GHandle.Main.Tree.Study(iStudy).ContextMenu,'Label','Modify','callback',{@ModifyStudy ,GHandle});
			uimenu(GHandle.Main.Tree.Study(iStudy).ContextMenu,'Label','Delete','callback',{@DeleteStudy ,GHandle});
			
			set(GHandle.Main.Tree.Study(iStudy).MainNode,'UIContextMenu',GHandle.Main.Tree.Study(iStudy).ContextMenu);
	end		
	
	
	%create a node for each measure
	for iMeasure = 1:GHandle.DataBase.nMeasure %for each measure in the study create a new branch
			[~, idxStudy] = GHandle.DataBase.findid(GHandle.DataBase.Measure(iMeasure).studyId);
			
			% check if htere is a tag 
			if ~isempty(GHandle.DataBase.Measure(iMeasure).tag)
				tag = GHandle.DataBase.Measure(iMeasure).tag;
			else
				tag = GDBMeasure.id2postfix(GHandle.DataBase.Measure(iMeasure).id);
			end
			
			GHandle.Main.Tree.Measure(iMeasure).MainNode = uiw.widget.TreeNode(... 
			'Name',tag ,...
			'Value', GHandle.DataBase.Measure(iMeasure).id,...
			'Parent',GHandle.Main.Tree.Study(idxStudy).MainNode...
			);
		
			%set his icon
 			setIcon(GHandle.Main.Tree.Measure(iMeasure).MainNode, measureIcon);%add the measure icon
			
			% add right click callback
			GHandle.Main.Tree.Measure(iMeasure).ContextMenu = uicontextmenu('Parent',GHandle.Main.Figure); % add the new measure right click
			
			uimenu(GHandle.Main.Tree.Measure(iMeasure).ContextMenu,'Label','Add Analysis','callback',{@Newalysis ,GHandle});
			uimenu(GHandle.Main.Tree.Measure(iMeasure).ContextMenu,'Label','Modify','callback',{@ModifyMeasure ,GHandle});
			uimenu(GHandle.Main.Tree.Measure(iMeasure).ContextMenu,'Label','Delete','callback',{@DeleteMeasure ,GHandle});
			
			set(GHandle.Main.Tree.Measure(iMeasure).MainNode,'UIContextMenu',GHandle.Main.Tree.Measure(iMeasure).ContextMenu);
			
	end	
	
	%create a node for each analysis
	for iAnalysis = 1:(GHandle.DataBase.nAnalysis) %for each analysis plus the row one in the measure create a new branch
		[~, idxMeasure] = GHandle.DataBase.findid(GHandle.DataBase.Analysis(iAnalysis).measureId);			

		% check if htere is a tag 
		if ~isempty(GHandle.DataBase.Analysis(iAnalysis).tag)
			tag = GHandle.DataBase.Analysis(iAnalysis).tag;
		else
			tag = GDBAnalysis.id2postfix(GHandle.DataBase.Analysis(iAnalysis).id);
		end
		
		
		GHandle.Main.Tree.Analysis(iAnalysis).MainNode = uiw.widget.TreeNode(... 
					'Name',tag ,...
					'Value',GHandle.DataBase.Analysis(iAnalysis).id ,...
					'Parent',GHandle.Main.Tree.Measure(idxMeasure).MainNode);
		
		%set his icon		
		setIcon(GHandle.Main.Tree.Analysis(iAnalysis).MainNode, analysisIcon);%add the anlysis icon	
		
		% add right click callback
		GHandle.Main.Tree.Analysis(iAnalysis).ContextMenu = uicontextmenu('Parent',GHandle.Main.Figure); 

		uimenu(GHandle.Main.Tree.Analysis(iAnalysis).ContextMenu,'Label','Modify','callback',{@modifyanalysis ,GHandle});
		uimenu(GHandle.Main.Tree.Analysis(iAnalysis).ContextMenu,'Label','Delete','callback',{@deleteanalysis ,GHandle});
		uimenu(GHandle.Main.Tree.Analysis(iAnalysis).ContextMenu,'Label','Develop','callback',{@developanalysis ,GHandle});
		
		set(GHandle.Main.Tree.Analysis(iAnalysis).MainNode,'UIContextMenu',GHandle.Main.Tree.Analysis(iAnalysis).ContextMenu);
			
	end
	
	%create a node for each Atlas
	for iAtlas = 1:GHandle.DataBase.nAtlas
		
		% check if there is a tag 
		if ~isempty(GHandle.DataBase.Atlas(iAtlas).tag)
			tag = GHandle.DataBase.Atlas(iAtlas).tag;
		else
			tag = GBDStudy.id2postfix(GHandle.DataBase.Atlas(iAtlas).id);
		end

		GHandle.Main.Tree.Atlas(iAtlas).MainNode = uiw.widget.TreeNode(...
			'Name', tag,...
			'Parent', GHandle.Main.Tree.AtlasTree.Root,...
			'Value', GHandle.DataBase.Atlas(iAtlas).id...
			); %create a node for each Atlas
		
		%set his icon
		setIcon(GHandle.Main.Tree.Atlas(iAtlas).MainNode,atlasIcon);  

		% add right click callback
		GHandle.Main.Tree.Atlas(iAtlas).ContextMenu = uicontextmenu('Parent',GHandle.Main.Figure); % add the new measure right click
		uimenu(GHandle.Main.Tree.Atlas(iAtlas).ContextMenu,'Label','AddAtlas','callback',{@NewNIRSMeasure ,GHandle});
		set(GHandle.Main.Tree.Atlas(iAtlas).MainNode,'UIContextMenu',GHandle.Main.Tree.Atlas(iAtlas).ContextMenu);
	end	

	%create a node for each Atlas
	for iProbe = 1:GHandle.DataBase.nProbe

		% check if there is a tag 
		if ~isempty(GHandle.DataBase.Probe(iProbe).tag)
			tag = GHandle.DataBase.Probe(iProbe).tag;
		else
			tag = GBDProbe.id2postfix(GHandle.DataBase.Probe(iProbe).id);
		end

		
		GHandle.Main.Tree.Probe(iProbe).MainNode = uiw.widget.TreeNode(...
			'Name', tag,...
			'Parent', GHandle.Main.Tree.ProbeTree.Root,...
			'Value', GHandle.DataBase.Probe(iProbe).id...
			); %create a node for each study

		%set his icon
		setIcon(GHandle.Main.Tree.Probe(iProbe).MainNode,probeIcon);  %set his icon

		% add right click callback
		GHandle.Main.Tree.Probe(iProbe).ContextMenu = uicontextmenu('Parent',GHandle.Main.Figure); % add the new measure right click
		uimenu(GHandle.Main.Tree.Probe(iProbe).ContextMenu,'Label','AddMeasure','callback',{@NewNIRSMeasure ,GHandle});
		set(GHandle.Main.Tree.Probe(iProbe).MainNode,'UIContextMenu',GHandle.Main.Tree.Probe(iProbe).ContextMenu);
		
		
		
	end	
end
	
function clickcallback(~, Event, GHandle) 
		if ~isempty(Event.Nodes) % click on a node 
			switch Event.SelectionType 
				case 'normal' 
					populatedisplay(Event.Nodes.Value, GHandle);
				case 'open' 
					%'doublestudy 
				case 'alt' 
					%'dxstudy	
			end 
		end

end
 



