function MeasureList = findmeasure(measureID,DataBase)
%FINDMeasure find ameasure in the database
%argument the measureID and the database
%add feature for more complicate search
	
	studyID = measureID(1:11);
	StudyArray = findstudy(studyID, DataBase);

	for iStudy = 1 : length(StudyArray) % sistemare
			CurrentStudy = StudyArray(iStudy);
			MeasureList =CurrentStudy.Measure(contains({CurrentStudy.Measure.ID},measureID));
	end
end
