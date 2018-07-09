function DBStudy = modify(DBStudy,NewStudy)
%ADDMODIFYSUBJECT add or modify a subject present in the database


	if (strcmp(DBStudy.id,NewStudy.id) || isempty(NewStudy.id))
	
		OldStudy = DBStudy.load;
	

		Study = NewStudy;


		% assign all nonspecify value to the old value
		studyFieldName = fieldnames(NewStudy);
		for iFieldName = 1 : length(studyFieldName)

			if isempty(NewStudy.(studyFieldName{iFieldName}))
				Study.(studyFieldName{iFieldName}) = OldStudy.(studyFieldName{iFieldName});
			end

		end


		% search and change all the analysis of the study and save it
		for iMeasure = 1 : OldStudy.nMeasure
			if ~(OldStudy.Measure(iMeasure).id == Study.Measure(iMeasure).id)
				currentMeasureId = OldStudy.Measure(iMeasure).id;

				ListAnalysis = findanalysis('measureid',currentMeasureId,DataBase);

				for iAnalysis = 1 : length(ListAnalysis)
					analysisPath = fullfile(databasePath,...
											Study.id,...	
											currentMeasureId,...
											ListAnalysis(iAnalysis));
					save(analysisPath,'Study');
				end
			end
		end
		
		save(DBStudy.path,'Subject');
		
	else 
		error('id not match')
	end
end
