function methodboxplot(~, Evnt, GHandle)
%METHODBOXPLOT Summary of this function goes here
%   Detailed explanation goes here

	fontSize = GHandle.Preference.Font.sizeL;
	EdgeColor = 'k';
	BackGroundColor = 'g';
	LineWidth = 3;

MethodList = Evnt.AffectedObject.listMethod;
	
	
% erase old tab
fieldNames = fields(GHandle.MethodWindow.EventsTextBox);
for iField = 1 : length(fieldNames)
	delete(GHandle.MethodWindow.EventsTextBox.(fieldNames{iField}))
end

fieldNames = fields(GHandle.MethodWindow.EventsArrow);
for iField = 1 : length(fieldNames)
	delete(GHandle.MethodWindow.EventsArrow.(fieldNames{iField}))
end

nMethod = length(MethodList);
deltaPos = min([0.1 , (0.9/(nMethod + 2)) ]);


	pos = [0.3 0.90 0.3 deltaPos*0.7];

	GHandle.MethodWindow.EventsTextBox.Input =...
		 annotation(GHandle.MethodWindow.mainFigure, 'textbox',...
		 'FontSize',fontSize,...
		 'EdgeColor', EdgeColor,...
		 'LineWidth', LineWidth,...
		 'BackGroundColor', BackGroundColor,...
		 'String', 'Input',...
		 'Units', 'normalized', ...
		 'Position',pos...
		);

	pos = [0.45 0.90 0 -deltaPos*0.3];
	GHandle.MethodWindow.EventsArrow.Input =...
		 annotation( GHandle.MethodWindow.mainFigure,'arrow', ...
		  'Units', 'normalized', ...
		 'Position',pos...
		);


for iMethod = 1 : (nMethod)
	
	currentMethod = MethodList(iMethod);
	posy = 0.90 - deltaPos * iMethod;
	pos = [0.3 posy 0.3 deltaPos*0.7];

	GHandle.MethodWindow.EventsTextBox.(currentMethod.tag) =...
		 annotation(GHandle.MethodWindow.mainFigure, 'textbox',...
		 'FontSize',fontSize,...
		 'EdgeColor', EdgeColor,...
		 'LineWidth', LineWidth,...
		 'BackGroundColor', BackGroundColor,...
		 'String', currentMethod.name,...
		 'Units', 'normalized', ...
		 'Position',pos...
		);

	pos = [0.45 posy 0 -deltaPos*0.3];
	GHandle.MethodWindow.EventsArrow.(currentMethod.tag) =...
		 annotation( GHandle.MethodWindow.mainFigure,'arrow', ...
		  'Units', 'normalized', ...
		 'Position',pos...
		);
	
end

	pos = [0.3 (0.90-deltaPos*(nMethod+1)) 0.3 deltaPos*0.7];

	GHandle.MethodWindow.EventsTextBox.Output =...
		 annotation(GHandle.MethodWindow.mainFigure, 'textbox',...
		 'FontSize',fontSize,...
		 'EdgeColor', EdgeColor,...
		 'LineWidth', LineWidth,...
		 'BackGroundColor', BackGroundColor,...
		 'String', 'Output',...
		 'Units', 'normalized', ...
		 'Position',pos...
		);

end
