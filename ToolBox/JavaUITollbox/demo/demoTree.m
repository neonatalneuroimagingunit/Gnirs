%% Tree
%   Copyright 2012-2018 The MathWorks, Inc.

%% Create the widget

close all 
clearvars

MainFigure = figure(...
    'Toolbar','none',...
    'MenuBar','none',...
    'NumberTitle','off',...
    'Units','pixels',...
    'Position',[100 100 220 320]);
movegui(MainFigure,[100 -100])

MainTree = uiw.widget.Tree(...
    'Parent',MainFigure,...
    'SelectionChangeFcn',@(h,e)disp(e),...
	'NodeExpandedCallback', @(a,d)warning('ciao'),...
    'Label','Tree:', ...
    'LabelLocation','top',...
    'LabelHeight',18,...
    'Units', 'pixels', ...
    'Position', [10 10 200 300]);

topNode =  uiw.widget.TreeNode('Name','TopNode','Parent',MainTree.Root );
branchA = uiw.widget.TreeNode('Name','BranchA','Parent',MainTree.Root);
branchB = uiw.widget.TreeNode('Name','BranchB','Parent',MainTree.Root);

for idx = 1:5
    nodesA(idx) = uiw.widget.TreeNode('Name',sprintf('NodeA %d',idx),'Parent',branchA); %#ok<SAGROW>
    nodesB(idx) = uiw.widget.TreeNode('Name',sprintf('NodeB %d',idx),'Parent',branchB); %#ok<SAGROW>
end


%% Expand branches

branchA.expand();
branchB.expand();


%% Hide the root

MainTree.RootVisible = false;


%% Change selection mode

MainTree.SelectionType = 'discontiguous';
MainTree.SelectionChangeFcn = @(h,e)disp({h.SelectedNodes.Name}');


%% Select nodes programmatically

MainTree.SelectedNodes = [nodesA(2) nodesB(4)];



%% Change some node properties

% Rename a node
topNode.Name = 'TopNode (renamed)';

% Set an icon
branchIcon = fullfile(matlabroot,'toolbox','matlab','icons','pagesicon.gif');
nodeIcon = fullfile(matlabroot,'toolbox','matlab','icons','pageicon.gif');
setIcon(branchA,branchIcon);
setIcon(topNode,nodeIcon);






%% Add context menus

% For the whole tree
treeContextMenu = uicontextmenu('Parent',MainFigure);
uimenu(treeContextMenu,'Label','Refresh','callback',@(h,e)disp('sadfhgjk'));
set(MainTree,'UIContextMenu',treeContextMenu)

% For nodesA only
nodesAContextMenu = uicontextmenu('Parent',MainFigure);
uimenu(nodesAContextMenu,'Label','Node1');
set(nodesA,'UIContextMenu',nodesAContextMenu)




