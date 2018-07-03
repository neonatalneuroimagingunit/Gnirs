function DataBase = addstudydatabase(Study,DataBase)
%ADDSTUDYDATABASE  add a study to the database 
%arguments Study to add and the databse path



	if ischar(DataBase)
		DataBase = loadNIRSdb(DataBase);
	end
	
	
	% generate the new id
	studyId = [DataBase.ID , 'S' ,num2str(DataBase.nStudyPersistent,'%.3d')]; 
	
	DataBase.nStudy = DataBase.nStudy + 1;
	DataBase.nStudyPersistent = DataBase.nStudyPersistent + 1;	 
	
	% add to database
	DataBase.Study(DataBase.nStudy) = NirsStudy(Study,...
				'id', studyId...
				);
	
			
	%crea la nuova cartella del db
	studyPath = fullfile(DataBase.dataBasePath,studyId);
	mkdir(studyPath);
	
	%save database
	savedatabase(DataBase,DataBase.dataBasePath)



end

