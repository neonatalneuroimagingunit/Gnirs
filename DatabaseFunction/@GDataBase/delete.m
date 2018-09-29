function DataBase = delete(DataBase, id)

ObjToDelete = DataBase.findid(id);

switch class(ObjToDelete)
	case 'GDataBase'
		rmdir(ObjToDelete.path, 's');
		% store the path
		pathDataBase = fileparts(DataBase.path);
		% reset the database 
		DataBase = GDataBase.create(pathDataBase);

		
	case 'GDBStudy'
		% find all measure
		idMeasure = cellstr(ObjToDelete.measureId);
		[~, idxMeasure] = DataBase.findid(idMeasure);
		idxMeasure = find(idxMeasure);
		% delete all the analysis
		for iiMeasure = idxMeasure
			idAnalysis = cellstr(DataBase.Measure(iiMeasure).analysisId);
			[~, idxAnalysis] = DataBase.findid(idAnalysis);
			DataBase.Analysis(idxAnalysis) = [];
		end
		% delete all measure
		DataBase.Measure(idxMeasure) = [];
		% delete the data in the study
		rmdir([ObjToDelete.path 'Measure'], 's')
		delete([ObjToDelete.path '.mat'])
		% delete the study
		DataBase.Study(DataBase.Study == ObjToDelete) = [];
		
	case 'GDBMeasure'
		% remove the measure from the study
		[DBStudy, idxStudy] = DataBase.findid(ObjToDelete.studyId);
		idMeasure = cellstr(DBStudy.measureId);
		idxMeasure = strcmp(idMeasure, id);
		DataBase.Study(idxStudy).measureId(idxMeasure,:) = [];
		% find and delete the anlysis
		idAnalysis = cellstr(ObjToDelete.analysisId);
		[~, idxAnalysis] = DataBase.findid(idAnalysis);
		DataBase.Analysis(idxAnalysis) = [];
		% delete the data in the measure
		rmdir([ObjToDelete.path 'Analysis'], 's')
		delete([ObjToDelete.path '.mat'])
		% delete the measure
		DataBase.Measure(DataBase.Measure == ObjToDelete) = [];
		
	case 'GDBAnalysis'
		%  remothe the anlysis from the measure 
		[DBMeasure, idxMeasure] = DataBase.findid(ObjToDelete.measureId);
		idAnalysis = cellstr(DBMeasure.analysisId);
		idxAnalysis = strcmp(idAnalysis, id);
		DataBase.Measure(idxMeasure).analysisId(idxAnalysis,:) = [];
		% delete the data in the analysis 
		delete([ObjToDelete.path '.mat'])
		% delete the anlysis 
		DataBase.Analysis(DataBase.Analysis == ObjToDelete) = [];
end
	
%save the change
DataBase.save;
	
end

