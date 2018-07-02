function DataBase = addstudydatabase(Study,databasePath)
%ADDSTUDYDATABASE  add a study to the database 
%arguments Study to add and the databse path

	DataBase = loadNIRSdb(databasePath);

	% generate the new id
	studyID = [DataBase.ID , 'S' ,num2str(DataBase.nStudyPersistent,'%.3d')]; 
	
	DataBase.nStudy = DataBase.nStudy + 1;
	DataBase.nStudyPersistent = DataBase.nStudyPersistent + 1;	 
	
	
	Study.id = studyID;
	
	if isempty(Study.name)
		Study.name = studyID;
	end
	
	if isempty(Study.date)
		Study.date = datetime;
	end
	
	
	if isempty(Study.nMeasurePersistent)
		Study.nMeasure = 0;
		Study.nGroups = 0;
		Study.nMeasurePersistent = 0;
		Study.nGroupsPersistent = 0;
	end
		
	
	
	DataBase.Study = [DataBase.Study; Study];
	
	%crea la nuova cartella del db
	studyPath = fullfile(DataBase.Path,studyID);
	mkdir(studyPath);
	
	saveDBPath = fullfile(databasePath ,'NIRSDataBase.mat');
	save(saveDBPath,'DataBase');



end

