function toolbar(GHandle)

	GHandle.Main.Toolbar = uiw.widget.Toolstrip(...
		'Parent',GHandle.Main.Figure,... %Normally start with this empty, until later
		'Visible','on',... %Normally start with this 'off'
		'Callback',@button,... %
		'Units','normalized',...
		'Position',[0 0.85 1 0.15]);

	GHandle.Main.Toolbar.addSection('FILES',2);
	GHandle.Main.Toolbar.addButton('folder_24.png','Folder');
	GHandle.Main.Toolbar.addButton('folder_file_24.png','FolderFile');
	GHandle.Main.Toolbar.addButton('folder_file_open_24.png','FolderFileOpen');
	GHandle.Main.Toolbar.addButton('save_24.png','Save');
	GHandle.Main.Toolbar.addButton('save_all_24.png','SaveAll');
	GHandle.Main.Toolbar.addButton('save_as_24.png','SaveAs');


	GHandle.Main.Toolbar.addSection('VISUALIZE',1); %Priority=1: lower gets space first
	GHandle.Main.Toolbar.addButton('play_24.png','Play');
	GHandle.Main.Toolbar.addButton('visualize_24.png','Plot');

	GHandle.Main.Toolbar.addSection('LISTS',3);
	GHandle.Main.Toolbar.addButton('add_24.png','Add');
	GHandle.Main.Toolbar.addButton('check_24.png','Check');
	GHandle.Main.Toolbar.addButton('close_24.png','Close');
	GHandle.Main.Toolbar.addButton('delete_24.png','Delete');
	GHandle.Main.Toolbar.addButton('edit_24.png','Edit');
	GHandle.Main.Toolbar.addButton('report_24.png','Report');
end

function button(~ ,event)
	switch event.Interaction
		case 'Folder'
		case 'FolderFile'
		case 'FolderFileOpen'
		case 'Save'
		case 'SaveAll'
		case 'SaveAs'
		case 'Play'
		case 'Plot'
		case 'Add'
		case 'Check'
		case 'Close'
		case 'Delete'
		case 'Edit'
		case 'Report'
	end
end