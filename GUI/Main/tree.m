function tree(GHandle)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


studyIcon = fullfile(matlabroot,'toolbox','matlab','icons','pagesicon.gif');
measureIcon = fullfile(matlabroot,'toolbox','matlab','icons','pageicon.gif');
analysisIcon = fullfile(matlabroot,'toolbox','matlab','icons','pageicon.gif');
probeIcon = fullfile(matlabroot,'toolbox','matlab','icons','pageicon.gif');
atlasIcon = fullfile(matlabroot,'toolbox','matlab','icons','pageicon.gif');



selectedTabIdx = 1;
if isfield(GHandle.Main,'Tree')
    selectedTabIdx =  GHandle.Main.Tree.TabGroup.SelectedTab == GHandle.Main.Tree.TabGroup.Children;
end


% create the tree
GHandle.Main.Tree.StudyTree = uiw.widget.Tree(...
    'Parent',GHandle.Main.Tree.StudyTab,...
    'BackgroundColor', GHandle.Preference.Theme.backgroundColor, ...
    'ForegroundColor', GHandle.Preference.Theme.foregroundColor, ...
    'LabelForegroundColor', GHandle.Preference.Theme.foregroundColor, ...
    'TreeBackgroundColor', GHandle.Preference.Theme.backgroundColor, ...
    'TreePaneBackgroundColor', GHandle.Preference.Theme.backgroundColor, ...
    'Label','Database:', ...
    'LabelLocation','top',...
    'LabelHeight',18,...
    'Units', 'normalized', ...
    'Position', [0 0 1 1],...
    'RootVisible', 'false'...
    );

GHandle.Main.Tree.ProbeTree = uiw.widget.Tree(...
    'Parent',GHandle.Main.Tree.ProbeTab,...
    'BackgroundColor', GHandle.Preference.Theme.backgroundColor, ...
    'ForegroundColor', GHandle.Preference.Theme.foregroundColor, ...
    'LabelForegroundColor', GHandle.Preference.Theme.foregroundColor, ...
    'TreeBackgroundColor', GHandle.Preference.Theme.backgroundColor, ...
    'TreePaneBackgroundColor', GHandle.Preference.Theme.backgroundColor, ...
    'Label','Database:', ...
    'LabelLocation','top',...
    'LabelHeight',18,...
    'Units', 'normalized', ...
    'Position', [0 0 1 1],...
    'RootVisible', 'false'...
    );

GHandle.Main.Tree.AtlasTree = uiw.widget.Tree(...
    'Parent',GHandle.Main.Tree.AtlasTab,...
    'BackgroundColor', GHandle.Preference.Theme.backgroundColor, ...
    'ForegroundColor', GHandle.Preference.Theme.foregroundColor, ...
    'LabelForegroundColor', GHandle.Preference.Theme.foregroundColor, ...
    'TreeBackgroundColor', GHandle.Preference.Theme.backgroundColor, ...
    'TreePaneBackgroundColor', GHandle.Preference.Theme.backgroundColor, ...
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
GHandle.Main.Tree.StudyContextMenu = uicontextmenu('Parent',GHandle.Main.Figure);
uimenu(GHandle.Main.Tree.StudyContextMenu,'Label','AddStudy','callback',{@newstudy, GHandle});
set(GHandle.Main.Tree.StudyTree,'UIContextMenu',GHandle.Main.Tree.StudyContextMenu);

% add the new probe right click
GHandle.Main.Tree.ProbeContextMenu = uicontextmenu('Parent',GHandle.Main.Figure);
uimenu(GHandle.Main.Tree.ProbeContextMenu,'Label','AddProbe','callback',{@newprobe, GHandle});
set(GHandle.Main.Tree.ProbeTree,'UIContextMenu',GHandle.Main.Tree.ProbeContextMenu);

% add the new atlas right click
GHandle.Main.Tree.AtlasContextMenu = uicontextmenu('Parent',GHandle.Main.Figure);
uimenu(GHandle.Main.Tree.AtlasContextMenu,'Label','AddAtlas','callback',{@newatlas, GHandle});
set(GHandle.Main.Tree.AtlasTree,'UIContextMenu',GHandle.Main.Tree.AtlasContextMenu);


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
    
    uimenu(GHandle.Main.Tree.Study(iStudy).ContextMenu,...
        'Label','Add Measure',....
        'callback',{@newmeasure ,GHandle});
    uimenu(GHandle.Main.Tree.Study(iStudy).ContextMenu,...
        'Label','Modify',...
        'callback',{@modifystudy ,GHandle});
    uimenu(GHandle.Main.Tree.Study(iStudy).ContextMenu,...
        'Label','Delete',...
        'tag', GHandle.DataBase.Study(iStudy).id,...
        'callback',{@delete_callback ,GHandle});
    
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
    
    uimenu(GHandle.Main.Tree.Measure(iMeasure).ContextMenu,...
        'Label','Add Analysis',...
        'callback',{@new_analysis ,GHandle});
    uimenu(GHandle.Main.Tree.Measure(iMeasure).ContextMenu,...
        'Label','Modify',...
        'callback',{@modify ,GHandle});
    uimenu(GHandle.Main.Tree.Measure(iMeasure).ContextMenu,...
        'Label','Delete',...
        'tag', GHandle.DataBase.Measure(iMeasure).id,...
        'callback',{@delete_callback ,GHandle});
    
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
    
    uimenu(GHandle.Main.Tree.Analysis(iAnalysis).ContextMenu,...
        'Label','Modify','callback',{@modifyanalysis ,GHandle});
    uimenu(GHandle.Main.Tree.Analysis(iAnalysis).ContextMenu,...
        'Label','Delete',....
        'tag', GHandle.DataBase.Analysis(iAnalysis).id,...
        'callback',{@delete_callback ,GHandle});
    uimenu(GHandle.Main.Tree.Analysis(iAnalysis).ContextMenu,...
        'Label','Develop',...
        'callback',{@develop_analysis ,GHandle});
    
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
    %uimenu(GHandle.Main.Tree.Atlas(iAtlas).ContextMenu,'Label','AddAtlas','callback',{@newmeasure ,GHandle});
    uimenu(GHandle.Main.Tree.Atlas(iAtlas).ContextMenu, 'Label','Delete','tag', GHandle.DataBase.Atlas(iAtlas).id,'callback',{@delete_callback ,GHandle});
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
    uimenu(GHandle.Main.Tree.Probe(iProbe).ContextMenu, 'Label','Delete','tag', GHandle.DataBase.Probe(iProbe).id,'callback',{@delete_callback ,GHandle});
   uimenu(GHandle.Main.Tree.Probe(iProbe).ContextMenu, 'Label','Forward Simulation','tag', GHandle.DataBase.Probe(iProbe).id,'callback',{@probe_simulation ,GHandle});
    set(GHandle.Main.Tree.Probe(iProbe).MainNode,'UIContextMenu',GHandle.Main.Tree.Probe(iProbe).ContextMenu);
    
end



GHandle.Main.Tree.TabGroup.SelectedTab = GHandle.Main.Tree.TabGroup.Children(selectedTabIdx );
end

function clickcallback(~, Event, GHandle)
if ~isempty(Event.Nodes) % click on a node
    switch Event.SelectionType
        
        case 'normal'
            populatedisplay(Event.Nodes.Value, GHandle);
            
        case 'open'
            if idtype(Event.Nodes.Value, 'Analysis')
                makeanalysiscurrent(GHandle, Event.Nodes.Value);
                viewer2(GHandle);
            end
            
        case 'alt'
            %'dxstudy
    end
end

end

function delete_callback (handle, ~, GHandle)
id = handle.Tag;
GHandle.DataBase = GHandle.DataBase.delete(id);
tree(GHandle);
end

function develop_analysis(~, ~, GHandle)
analysisId = GHandle.Main.Tree.StudyTree.SelectedNodes.Value;
makeanalysiscurrent(GHandle, analysisId)
methodPath = fullfile(GHandle.Preference.Path.currentPath, 'Method', 'MethodList.mat');
GHandle.MethodWindow = load(methodPath); % it wipes out also the field
GHandle.MethodWindow = MetodWW(GHandle.MethodWindow.MethodList);
end

function new_analysis (~, ~, GHandle)
measureId = GHandle.Main.Tree.StudyTree.SelectedNodes.Value;
DBMeasure = GHandle.DataBase.findid(measureId);
analysisId = DBMeasure.analysisId(1,:);
makeanalysiscurrent(GHandle, analysisId);
methodwindow(GHandle)
end

function modify(~, ~, GHandle)
    id = GHandle.Main.Tree.StudyTree.SelectedNodes.Value;
    populatedisplay(id, GHandle, true)
end

function probe_simulation(handle, ~, GHandle)
id = handle.Tag;
DBProbe = GHandle.DataBase.findid(id);
GHandle.CurrentDataSet.Probe = DBProbe.load;
probesimulationwindow(GHandle);
end






