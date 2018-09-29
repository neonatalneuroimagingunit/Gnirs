function HandleTextBox= gtextbox(varargin)

 Position = [0 0 1 1];

 Text.BackgroundColor = [0.9000 0.9000 0.9000];
 Text.BusyAction = 'queue';
 Text.ButtonDownFcn = '';               
 Text.Callback = '';
 Text.CreateFcn = '';
 Text.DeleteFcn = '';
 Text.Enable = 'on';
 Text.FontAngle = 'normal';
 Text.FontName = 'Helvetica';
 Text.FontSize = 8;
 Text.FontUnits = 'points';
 Text.FontWeight = 'normal';
 Text.ForegroundColor = [0 0 0];
 Text.HandleVisibility = 'on';
 Text.HorizontalAlignment = 'left';
 Text.Interruptible = 'on';
 Text.KeyPressFcn = '';
 Text.KeyReleaseFcn = '';
 Text.ListboxTop =  1;
%Text.Max = 1
%Text.Min = 0
 Text.Position = [20 20 60 20];
 Text.String = '';
 Text.Tag = '';
 Text.Units = 'normalized';
 Text.UserData = [];
 Text.Visible = 'on';
 
 
 Title.BackgroundColor = [0.9200 0.9200 0.9200];
 Title.BusyAction = 'queue';
 Title.ButtonDownFcn = '';               
 Title.Callback = '';
 Title.CreateFcn = '';
 Title.DeleteFcn = '';
 Title.Enable = 'on';
 Title.FontAngle = 'normal';
 Title.FontName = 'Helvetica';
 Title.FontSize = 8;
 Title.FontUnits = 'points';
 Title.FontWeight = 'normal';
 Title.ForegroundColor = [0 0 0];
 Title.HandleVisibility = 'on';
 Title.HorizontalAlignment = 'left';
 Title.Interruptible = 'on';
 Title.KeyPressFcn = '';
 Title.KeyReleaseFcn = '';
 Title.ListboxTop = 1;
%Title.Max = 1
%Title.Min = 0
 Title.Position = [20 20 60 20];
 Title.String = '';
 Title.Tag = '';
 Title.Units = 'normalized';
 Title.UserData = [];
 Title.Visible = 'on';

for iField = 1 : 2 : nargin
	if (strcmp(varargin{iField},'Position'))
		Position = varargin{iField+1};
	else
		if contains(varargin{iField},'Text')
			Text.(erase(varargin{iField},'Text')) = varargin{iField+1};
		else
			if contains(varargin{iField},'Title')
				Title.(erase(varargin{iField},'Title')) = varargin{iField+1};
			else
				Text.(varargin{iField}) = varargin{iField+1};
				Title.(varargin{iField}) = varargin{iField+1};
			end
		end
	end
end



if any(Position)
	nRow = sum(strfind(Text.String,'\n')) + 1; 
	
	height = Position(4);
	textHeight = nRow * height / (nRow + 1);
	titleHeight = height / (nRow + 1);
	
	Title.Position = [Position(1), (Position(2) + textHeight), Position(3), titleHeight];
	Text.Position = [Position(1), Position(2), Position(3), textHeight];
end	

HandleTextBox.Text = uicontrol('Parent',Text.Parent,...
						'Style','text',...
						'BackgroundColor',Text.BackgroundColor,...
						'BusyAction',Text.BusyAction,...
						'ButtonDownFcn',Text.ButtonDownFcn,...            
						'Callback',Text.Callback,...
						'CreateFcn',Text.CreateFcn,...
						'DeleteFcn',Text.DeleteFcn,...
						'Enable',Text.Enable,...
						'FontAngle',Text.FontAngle,...
						'FontName',Text.FontName,...
						'FontUnits',Text.FontUnits,...
						'FontSize',Text.FontSize,...
						'FontWeight',Text.FontWeight,...
						'ForegroundColor',Text.ForegroundColor,...
						'HandleVisibility',Text.HandleVisibility,...
						'HorizontalAlignment',Text.HorizontalAlignment,...
						'Interruptible',Text.Interruptible,...
						'KeyPressFcn',Text.KeyPressFcn,...
						'KeyReleaseFcn',Text.KeyReleaseFcn,...
						'ListboxTop',Text.ListboxTop,...
						'Units',Text.Units,...
						'Position',Text.Position,...
						'String',Text.String,...
						'Tag',Text.Tag,...
						'UserData',Text.UserData,...
						'Visible', Text.Visible);



HandleTextBox.Title = uicontrol('Parent',Title.Parent,...
						'Style','text',...
						'BackgroundColor',Title.BackgroundColor,...
						'BusyAction',Title.BusyAction,...
						'ButtonDownFcn',Title.ButtonDownFcn,...            
						'Callback',Title.Callback,...
						'CreateFcn',Title.CreateFcn,...
						'DeleteFcn',Title.DeleteFcn,...
						'Enable',Title.Enable,...
						'FontAngle',Title.FontAngle,...
						'FontName',Title.FontName,...
						'FontUnits',Title.FontUnits,...
						'FontSize',Title.FontSize,...
						'FontWeight',Title.FontWeight,...
						'ForegroundColor',Title.ForegroundColor,...
						'HandleVisibility',Title.HandleVisibility,...
						'HorizontalAlignment',Title.HorizontalAlignment,...
						'Interruptible',Title.Interruptible,...
						'KeyPressFcn',Title.KeyPressFcn,...
						'KeyReleaseFcn',Title.KeyReleaseFcn,...
						'ListboxTop',Title.ListboxTop,...
						'String',Title.String,...
						'Tag',Title.Tag,...
						'Units',Title.Units,...
						'Position',Title.Position,...
						'UserData',Title.UserData,...
						'Visible', Title.Visible);
					
	
					
			
					
					
					
					
	set(HandleTextBox.Text,{'FontUnits'},{'normalized'})
	set(HandleTextBox.Title,{'FontUnits'},{'normalized'})
end

