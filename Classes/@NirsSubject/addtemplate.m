function DataBase = addtemplate(Subject, DataBase)
	
	if ischar(DataBase)
		DataBase = GDataBase.load(DataBase);
	end
	
	% generate the new id
	if isfield(Subject, 'tag')
		[subjectId, DataBase] = DataBase.newsubjecttemplate(Subject.tag);
		Subject = rmfield(Subject , 'tag');
		
	else
		[subjectId, DataBase] = DataBase.newsubjecttemplate;
	end
	
	
	% add file to database
	Subject.id = subjectId;
	
	subjectpostfix = GDBSubject.id2subjectpostfix(subjectId);
	subjectPath = fullfile(DataBase.path, 'Subject',subjectpostfix);
	save(subjectPath,'Subject');
	
	
	%save database				
	DataBase.save;
	
end

