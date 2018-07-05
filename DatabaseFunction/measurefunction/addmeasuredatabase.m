function DataBase = addmeasuredatabase(Measure,DataBase)

		
	if ischar(DataBase)
		DataBase = loadNIRSdb(DataBase);
	end		


	%% create a new ID 
	if ~isempty(Measure.studyId)
		Study= findstudy('id', Measure.studyId, DataBase);
		% generate the new id
		measureId = [Study.id, 'M' ,num2str(Study.nMeasurePersistent,'%.3d')]; 
		
		
		Study.nMeasurePersistent = Study.nMeasurePersistent + 1;
		
		% add to the study
		idxMeasure = Study.nMeasure+1;
		Study.Measure(idxMeasure) = NirsMeasure(Measure,...
				'id', measureId...
				);
			
		
			modifystudydatabase(Study,DataBase);
		
	else
		error('study id not found'); 
	end		
end

