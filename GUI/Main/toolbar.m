function [Hmain] = toolbar(Hmain)

	Hmain.Toolbar = uiw.widget.Toolstrip(...
		'Parent',Hmain.mainFigure,... %Normally start with this empty, until later
		'Visible','on',... %Normally start with this 'off'
		'Callback',@button,... %
		'Units','normalized',...
		'Position',[0 0.85 1 0.15]);

	Hmain.Toolbar.addSection('FILES',2);
	Hmain.Toolbar.addButton('folder_24.png','Folder');
	Hmain.Toolbar.addButton('folder_file_24.png','FolderFile');
	Hmain.Toolbar.addButton('folder_file_open_24.png','FolderFileOpen');
	Hmain.Toolbar.addButton('save_24.png','Save');
	Hmain.Toolbar.addButton('save_all_24.png','SaveAll');
	Hmain.Toolbar.addButton('save_as_24.png','SaveAs');


	Hmain.Toolbar.addSection('VISUALIZE',1); %Priority=1: lower gets space first
	Hmain.Toolbar.addButton('play_24.png','Play');
	Hmain.Toolbar.addButton('visualize_24.png','Plot');

	Hmain.Toolbar.addSection('LISTS',3);
	Hmain.Toolbar.addButton('add_24.png','Add');
	Hmain.Toolbar.addButton('check_24.png','Check');
	Hmain.Toolbar.addButton('close_24.png','Close');
	Hmain.Toolbar.addButton('delete_24.png','Delete');
	Hmain.Toolbar.addButton('edit_24.png','Edit');
	Hmain.Toolbar.addButton('report_24.png','Report');
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