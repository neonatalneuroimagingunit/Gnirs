function DataBase = addmeasuredatabase(Measure,Data,DataBase)

		
	if ischar(DataBase)
		DataBase = loadNIRSdb(DataBase);
	end		


	%% create a new ID 
	if ~isempty(Measure.studyId)
		Study= findstudy('id', Measure.studyId, DataBase);
		% generate the new id
		measureId = [Study.id, 'M' ,num2str(Study.nMeasurePersistent,'%.3d')]; 
		if ~isempty(Measure.subjectId)
			Subject = findsubject('id', subjectId);
			Subject.measureId = {Subject.measureId{:} ;measureId};
			modifysubjectdatabase(Subject,DataBase)
		end
		 
% 		if ~isempty(Measure.probeId)
% 			Probe = findprobe('id', probeId);
% 			Probe.measureId = {Probe.measureId{:} ;measureId};
% 			modifyprobedatabase(Probe,DataBase)
% 		end
		Study.nMeasurePersistent = Study.nMeasurePersistent + 1;
		
		% add to the study
		idxMeasure = Study.nMeasure+1;
		Study.Measure(idxMeasure) = NirsMeasure(Measure,...
				'id', measureId...
				);
		
		%create the new directory in the database
		measurePath = fullfile(DataBase.dataBasePath,Measure.studyId,measureId);
		mkdir(measurePath);
		DataBase = modifystudydatabase(Study,DataBase);
		
		
		
	else
		error('study id not found'); 
	end		
end

