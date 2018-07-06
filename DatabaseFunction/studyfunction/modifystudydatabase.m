function DataBase = modifystudydatabase(NewStudy,DataBase)
%ADDMODIFYSTUDY modify a study present in the database

	% if is a link load it
	if ischar(DataBase)
		DataBase = loadNIRSdb(DataBase);
	end
	% found the right study
	studyId = NewStudy.id;
	
	[OldStudy, index] = findstudy('id', studyId, DataBase);
	
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
	
	
	
	
	
	% substitute study in the databsa
	DataBase.Study(index) = Study;
	
	%save the database
	savedatabase(DataBase,DataBase.dataBasePath)
end

