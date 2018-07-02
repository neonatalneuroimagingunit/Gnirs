function AnalysisList = findanalysis(analysisID,DataBase)

%FINDAnalysis find a analysis in the database
%argument the analysisID and the database
%add feature for more complicate search


	measureID = analysisID(1 : end - 4);
	
	
	MeasureArray = findmeasure(measureID, DataBase);

	for iMeasure = 1 : length(MeasureArray) % sistemare
			CurrentMeasure = MeasureArray(iMeasure);
			AnalysisList = CurrentMeasure.Analysis(contains({CurrentMeasure.Analysis.ID},analysisID));
	end
end


