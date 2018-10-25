function [panelHandle, labelHandle, textHandle] = gtextedit(varargin)


position = [0 0 1 1];
labelString = '';
textString = '';
spacing = 0.1;
sizeratio = 1;
BackgroundColor =  [0.9400    0.9400    0.9400];
configuration = 'vertical';
texttype = 'text';
textHeight = 10;
callback = {};

for i = 1 : 2 : nargin
	switch lower(varargin{i})
		case 'parent'
			parent = varargin{i+1};
		case 'position'
			position = varargin{i+1};
		case 'label'
			labelString = varargin{i+1};
		case 'text'
			textString = varargin{i+1};
		case 'spacing'
			spacing = varargin{i+1};
		case 'callback'
			callback = varargin{i+1};
		case 'sizeratio'
			sizeratio = varargin{i+1};
		case 'configuration'
			configuration = varargin{i+1};
		case 'texttype'
			texttype = varargin{i+1};
		otherwise
			warning(['field ' varargin{i} ' not found'])
	end
end
if length(spacing) == 1
    spacing = [spacing spacing spacing];
end

labelDim = (1 - sum(spacing))/(1 + sizeratio);
textDim = labelDim * sizeratio;

tempParentUnits = parent.Units;
parent.Units = 'points';
pointDim = parent.Position.*position;
textHeight = textHeight./pointDim(4);
parent.Units = tempParentUnits;




if strcmp(configuration, 'horizontal')
	positionLabel = [spacing(1) (0.5 - textHeight) labelDim  textHeight*1.5];
	positionText = [(spacing(1) + spacing(2) + labelDim) (0.5 - textHeight) textDim textHeight*1.5];
elseif strcmp(configuration, 'vertical')
	positionText = [0 spacing(1) 1 labelDim ];
	positionLabel = [0 (spacing(1) + spacing(2) + labelDim) 1 textDim ];
else
	warning('style not found')
end


panelHandle = uipanel(...
    'Parent', parent,...
    'Units', 'normalize', ...
    'BorderType', 'none', ...
    'Position', position);


labelHandle = uicontrol('Style', 'text',...
	'Parent', panelHandle, ...
	'String', labelString,...
	'BackgroundColor',BackgroundColor,...
	'Visible','on',...
	'Units', 'normalize', ...
	'HorizontalAlignment', 'left', ...
	'Position',positionLabel);

textHandle = uicontrol('Style', texttype,...
	'Parent', panelHandle, ...
	'String', textString,...
	'BackgroundColor',BackgroundColor,...
	'Visible','on',...
	'Callback',callback,...
	'Units', 'normalize', ...
	'HorizontalAlignment', 'left', ...
	'Position',positionText);


end