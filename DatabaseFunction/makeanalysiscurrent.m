function makeanalysiscurrent(GHandle, analysisId)

if ~isempty(analysisId)
	DBAnalysis = GHandle.DataBase.findid(analysisId);
	GHandle.ActualMeasure.Analysis = DBAnalysis.load;
	
	measureId = DBAnalysis.measureId;
	if ~isempty(measureId)
		DBMeasure = GHandle.DataBase.findid(measureId);
		GHandle.ActualMeasure.Measure = DBMeasure.load;
		
		studyId = DBMeasure.studyId;
		if ~isempty(studyId)
			DBStudy = GHandle.DataBase.findid(studyId);
			GHandle.ActualMeasure.Study = DBStudy.load;
		end
		
		subjectId = DBMeasure.subjectId;
		if ~isempty(subjectId)
			DBSubject = GHandle.DataBase.findid(subjectId);
			GHandle.ActualMeasure.Subject = DBSubject.load;
		end

		probeId = DBMeasure.probeId;
		if ~isempty(probeId)
			DBProbe = GHandle.DataBase.findid(probeId);	
			GHandle.ActualMeasure.Probe = DBProbe.load;
		end		
	end
   
	GHandle.ActualMeasure.Data = DBAnalysis.loaddata;
else
	error('invalid analysis id')
end


end
