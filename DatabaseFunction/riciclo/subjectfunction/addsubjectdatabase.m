function DataBase = addsubjectdatabase(Subject,DataBase)
%ADDMODIFYSUBJECT add or modify a subject present in the database

	if ischar(DataBase)
		DataBase = loadNIRSdb(DataBase);
	end
	
	% generate the new id
	subjectId = [DataBase.ID , 'U' ,num2str(DataBase.nSubjectPersistent,'%.3d')]; 
	
	DataBase.nSubject = DataBase.nSubject + 1;
	DataBase.nSubjectPersistent = DataBase.nSubjectPersistent + 1;	
	
	% add to database
	DataBase.Subject(DataBase.nSubject) = NirsSubject(Subject,...
						'id', subjectId,...
						'template', false...
						);
	
	%save database				
	savedatabase(DataBase,DataBase.dataBasePath)
end

