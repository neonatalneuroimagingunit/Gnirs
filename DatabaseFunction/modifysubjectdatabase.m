function DataBase = modifysubjectdatabase(Subject,dataBasePath)
%ADDMODIFYSUBJECT add or modify a subject present in the database
	DataBase = loadNIRSdb(dataBasePath);
	
	% found the right study
	subjectId = [DataBase.ID , 'U' ,num2str(DataBase.nSubjectPersistent,'%.3d')]; 
	
	substitute study in the databsa
	DataBase.Subject = Subject;
	
	
	
	
	%save the database
	saveDBPath = fullfile(databasePath ,'NIRSDataBase.mat');
	save(saveDBPath,'DataBase');
end

