function DataBase = anonymize(Subject, DataBase, field)
%AanonimizeSUBJECT add or modify a subject present in the database

	% if is a link load it
	if ischar(DataBase)
		DataBase = loadNIRSdb(DataBase);
	end
	% found the right study
	
	subjectId = Subject.id;
	
	%found the position in the database
	[~, index] = findsubject('id', subjectId, DataBase);
	
	
	% check what elemnts 
	if any(strcmpi(field,'name'))
		Subject.name = [];
	end
	if any(strcmpi(field,'surname'))
		Subject.surName = [];
	end
	
	if any(strcmpi(field,'birthdate'))
		Subject.birthDate = [];
	end
	
	if any(strcmpi(field,'note'))
		Subject.note = [];
	end
	
	if any(strcmpi(field,'info'))
		Subject.info = [];
	else
		% check all the field of the study to erase
		fieldNames = fieldnames(Subject.Info);

		fieldNames2Erase = fieldNames(~ismember(fieldNames , field));
		for iField = 1 : length(fieldNames2Erase)
			Subject.Info.(fieldNames2Erase{iField}) = [];
		end
	end
	
	% search and change all the analysis of the subject and saveit
	for iMeasure = 1 : length(Subject.measureId)
		currentMeasureId = Subject.measureId(iMeasure);
		studyID = id2studyid(currentMeasureId);
		
		ListAnalysis = findanalysis('measureid',currentMeasureId,DataBase);
		
		for iAnalysis = 1 : length(ListAnalysis)
			analysisPath = fullfile(databasePath,...
									studyID,...	
									currentMeasureId,...
									ListAnalysis(iAnalysis));
			save(analysisPath,'Subject');
		end
	end
	
	
	
	
	
	% substitute study in the databsa
	DataBase.Subject(index) = Subject;
	
	%save the database
	savedatabase(DataBase,DataBase.dataBasePath)
end
