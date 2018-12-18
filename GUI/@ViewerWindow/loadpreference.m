function loadpreference(obj)
% Set color theme
obj.Preference.figurePosition = obj.GHandle.Preference.Figure.sizeLarge;
obj.Preference.backgroundColor = obj.GHandle.Preference.Theme.backgroundColor;
obj.Preference.foregroundColor = obj.GHandle.Preference.Theme.foregroundColor;
obj.Preference.highlightColor = obj.GHandle.Preference.Theme.highlightColor;
obj.Preference.textForegroundColor = [1 1 1];
obj.Preference.sourceColor = 'r';
obj.Preference.detectorColor = 'b';
obj.Preference.channelColor = 'k';

% Set font
obj.Preference.defaultFontName = obj.GHandle.Preference.Font.name;
obj.Preference.defaultFontSize = obj.GHandle.Preference.Font.sizeM;
end
