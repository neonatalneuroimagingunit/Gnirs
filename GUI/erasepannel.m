function HandlePannel = erasepannel(HandlePannel)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% creo le caselle di testo non editabili	
	set(HandlePannel.Pannel,...
		'Visible', 'on',...
		'Title', ''...
		);
	
	
	
	for iColumn = 1 : HandlePannel.nTextColumn   
		for iRow = 1 : HandlePannel.nTextRow
			
			set(HandlePannel.TextBox(iColumn,iRow),...
				'Label', '',...
				'Value', '',...
				'Visible', 'off'...
				);	
			
			set(HandlePannel.TextBoxEditable(iColumn, iRow),...
				'Label', '',...
				'Value', '',...
				'Visible', 'off'...
				);	
		end
	end



		
	set(HandlePannel.ToggleButton,...
				'Visible', 'off'...
				);	 

	set(HandlePannel.PlotSubPannel,...
				'Visible', 'off'...
				);	
	


end



	















