function DataBase = modifysubjectdatabase(NewSubject,DataBase)
%ADDMODIFYSUBJECT add or modify a subject present in the database

	% if is a link load it
	if ischar(DataBase)
		DataBase = loadNIRSdb(DataBase);
	end
	% found the right study
	subjectId = NewSubject.id;
	
	[OldSubject, index] = findsubject('id', subjectId, DataBase);
	
	Subject = NewSubject;
	
	%template and measure value cannot be change
	Subject.template = OldSubject.template;
	Subject.measureId = OldSubject.measureId;
	
	
	% assign all nonspecify value to the old value
	if isempty(NewSubject.name)
		Subject.name = OldSubject.name;
	end
	if isempty(NewSubject.surName)
		Subject.surName = OldSubject.surName;
	end
	
	if isempty(NewSubject.birthDate)
		Subject.birthDate = OldSubject.birthDate;
	end
	
	if isempty(NewSubject.note)
		Subject.note = OldSubject.note;
	end
	
	if isempty(NewSubject.info)
		Subject.info = OldSubject.info;
	else
		% check all the field of the new and assign to the old
		oldFieldNames = fieldnames(OldSubject.info);
		newFieldNames = fieldnames(NewSubject.info);

		oldFieldNames2Save = oldFieldNames(~ismember(oldFieldNames , newFieldNames));
		for iField = 1 : length(oldFieldNames2Save)
			Subject.info.(oldFieldNames2Save{iField}) = OldSubject.info(oldFieldNames2Save{iField});
		end
	end
	
	% search and change all the analysis of the subject and saveit
	for iMeasure = 1 : length(OldSubject.measureId)
		currentMeasureId = OldSubject.measureId(iMeasure);
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
	savedatabase(DataBase,databasePath)
end

