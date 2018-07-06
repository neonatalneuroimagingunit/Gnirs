function AnalysisList = findanalysis(~,analysisID,DataBase)

%FINDAnalysis find a analysis in the database
%argument the analysisID and the database
%add feature for more complicate search


	measureID = analysisID(1 : 15);
	
	
	MeasureArray = findmeasure('id',measureID, DataBase);

	for iMeasure = 1 : length(MeasureArray) % sistemare
			CurrentMeasure = MeasureArray(iMeasure);
			AnalysisList = [];
	end
end


