function resizecheck(Figure,~,GHandle)

	set(Figure,'Units','centimeters')
	GHandle.Preference.Font.sizeS = floor(Figure.Position(4)/2.5);
	GHandle.Preference.Font.sizeM = floor(Figure.Position(4)/2);
	GHandle.Preference.Font.sizeL = floor(Figure.Position(4)/1.75);
	
	set(Figure,'units','pixels')
	GHandle.Preference.Figure.size = Figure.Position;

end

