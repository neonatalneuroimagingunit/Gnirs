function [Find, idx] = findid(DataBase, id)
	lengthDataBaseId = 7;
	lengthStudyId = 11;
	lengthMeasureId = 14;
	lengthAnalysisId = 14;
	lengthSubjectId = 11;
	lengthAtlasId = 11;
	lengthProbeId = 11;
	
	switch id(lengthDataBaseId + 1)
		case 'S'
			idx = DataBase.Study(:).id == id(1:lengthStudyId);
			Find = DataBase.Study(idx);
		case 'M'
			
			idx = DataBase.Measure(:).id == id(1:lengthMeasureId);
			Find = DataBase.Measure(idx);
		case 'A'
			
			idx = DataBase.Anlaysis(:).id == id(1:lengthAnalysisId);
			Find =DataBase.Anlaysis(idx);

		case 'U'
			idx = DataBase.Subject(:).id == id(1:lengthSubjectId);
			Find = DataBase.Subject(idx);
			
		case 'P'
			idx = DataBase.Probe(:).id == id(1:lengthProbeId);
			Find = DataBase.Probe(idx);
			
		case 'T'
			idx = DataBase.Atlas(:).id == id(1:lengthAtlasId);
			Find = DataBase.Atlas(idx);
			
		otherwise
			warning('id not valid')
		
end

