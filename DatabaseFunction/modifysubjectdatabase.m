function DataBase = modifysubjectdatabase(NewSubject,dataBasePath)
%ADDMODIFYSUBJECT add or modify a subject present in the database
	DataBase = loadNIRSdb(dataBasePath);
	
	% found the right study
	subjectId = Subject.id;
	
	[OldSubject, index] = findsubject(subjectId, DataBase);
	
	%template and measure value cannot be change
	NewSubject.template = OldSubject.template;
	NewSubject.measureId = OldSubject.measureId;
	
	
	% assign all nonspecify value to the old value
	if isempty(NewSubject.name)
		NewSubject.name = OldSubject.name;
	end
	if isempty(NewSubject.surName)
		NewSubject.surName = OldSubject.surName;
	end
	
	if isempty(NewSubject.birthDate)
		NewSubject.birthDate = OldSubject.birthDate;
	end
	
	if isempty(NewSubject.note)
		NewSubject.note = OldSubject.note;
	end
	
	if isempty(NewSubject.info)
		NewSubject.info = OldSubject.info;
	else
		% check all the field of the new and assign to the old
		oldFieldNames = fieldnames(OldSubject.info);
		newFieldNames = fieldnames(NewSubject.info);

		oldFieldNames2Save = oldFieldNames(~ismember(oldFieldNames , newFieldNames));
		for iField = 1 : length(oldFieldNames2Save)
			NewSubject.info.(oldFieldNames2Save{iField}) = OldSubject.info(oldFieldNames2Save{iField});
		end
	end
	
	% search and change all the analysis of the subject
	for iMeasure = 1 : length(OldSubject.measureId)
		currentMeasureId = OldSubject.measureId(iMeasure);
		analysisPath = fullfile(databasePath, currentMeasureId )
		
	end
	
	
	
	
	
	% substitute study in the databsa
	DataBase.Subject(index) = NewSubject;
	
	%save the database
	savedatabase(DataBase,databasePath)
end

