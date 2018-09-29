function [find, n] = finddependence(DataBase, id)
	lengthDataBaseId = 7;

	
	switch id(lengthDataBaseId + 1)
		case 'S'
			find{1} = id;
			
		case 'M'
			DBMeasure = DataBase.findid(id);
			find{1} = DBMeasure.id;
			find{2} = DBMeasure.studyId;
			if ~isempty(DBMeasure.subjectId)
				find = [find, {DBMeasure.subjectId}] ;
			end
			if ~isempty(DBMeasure.probeId)
				find = [find, {DBMeasure.probeId}] ;
			end
			
		case 'A'
			DBAnalysis = DataBase.findid(id);
			find{1} = DBAnalysis.measureId;
			DBMeasure = DataBase.findid(DBAnalysis.measureId);
			find{2} = DBMeasure.studyId;
			if ~isempty(DBMeasure.subjectId)
				find = [find, {DBMeasure.subjectId}] ;
			end
			find = [find, {DBAnalysis.id}]; 
			
		case 'U'
			find{1} = id;
			
		case 'P'
			find{1} = id;
			DBProbe = DataBase.findid(id);
			if ~isempty(DBProbe.altasId)
				find = [find, {DBProbe.altasId}] ;
			end
			
		case 'T'
			find{1} = id;
			
		otherwise
			warning('id not valid')
			
			
	end
	
	n = length(find);
		
end

