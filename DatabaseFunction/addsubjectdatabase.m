function DataBase = addsubjectdatabase(Subject,dataBasePath)
%ADDMODIFYSUBJECT add or modify a subject present in the database
	DataBase = loadNIRSdb(dataBasePath);
	
	% generate the new id
	subjectId = [DataBase.ID , 'U' ,num2str(DataBase.nSubjectPersistent,'%.3d')]; 
	
	DataBase.nSubject = DataBase.nSubject + 1;
	DataBase.nSubjectPersistent = DataBase.nSubjectPersistent + 1;	
	
	DataBase.Subject = NirsSubject(Subject,...
						'id', subjectId,...
						'template', false...
						);
					
	savedatabase(DataBase,databasePath)
end

