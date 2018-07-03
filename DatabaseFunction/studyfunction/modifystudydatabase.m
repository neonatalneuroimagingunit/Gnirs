function DataBase = modifystudydatabase(NewStudy,DataBase)
%ADDMODIFYSUBJECT add or modify a subject present in the database

	% if is a link load it
	if ischar(DataBase)
		DataBase = loadNIRSdb(DataBase);
	end
	% found the right study
	studyId = NewStudy.id;
	
	[OldStudy, index] = findstudy('id', studyId, DataBase);
	
	Study = NewStudy;
	
	%value that cannot be changed
	Study.Measure = OldStudy.Measure ;
	Study.Groups = OldStudy.Groups;
	Study.dateFirstMeasure = OldStudy.dateFirstMeasure;
	Study.dateLastMeasure = OldStudy.dateLastMeasure;
	Study.nMeasurePersistent = OldStudy.nMeasurePersistent;
    Study.nGroupsPersistent = OldStudy.nGroupsPersistent;
	Study.dateFirstAnalysis = OldStudy.dateFirstAnalysis;
    Study.dateLastAnalysis = OldStudy.dateLastAnalysis;
	
	
	% assign all nonspecify value to the old value
	if isempty(NewStudy.name)
		Study.name = OldStudy.name;
	end

	if isempty(NewStudy.date)
		Study.date = OldStudy.date;
	end
	
	if isempty(NewStudy.note)
		Study.note = OldStudy.note;
	end
	
	
 	% search and change all the analysis of the study and save it
	for iMeasure = 1 : OldStudy.nMeasure
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
	
	
	
	
	
	% substitute study in the databsa
	DataBase.Study(index) = Study;
	
	%save the database
	savedatabase(DataBase,DataBase.dataBasePath)
end

