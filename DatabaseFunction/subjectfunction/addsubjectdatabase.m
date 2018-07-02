function DataBase = addsubjectdatabase(Subject,DataBase)
%ADDMODIFYSUBJECT add or modify a subject present in the database

	if ischar(DataBase)
		DataBase = loadNIRSdb(DataBase);
	end
	
	% generate the new id
	subjectId = [DataBase.ID , 'U' ,num2str(DataBase.nSubjectPersistent,'%.3d')]; 
	
	DataBase.nSubject = DataBase.nSubject + 1;
	DataBase.nSubjectPersistent = DataBase.nSubjectPersistent + 1;	
	
	DataBase.Subject = NirsSubject(Subject,...
						'id', subjectId,...
						'template', false...
						);
					
	savedatabase(DataBase,DataBase.databasePath)
end

