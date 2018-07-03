function DataBase = addsubjecttemplatedatabase(field, defolutlValue, DataBase)
%ADDMODIFYSUBJECT add or modify a subject present in the database

	if ischar(DataBase)
		DataBase = loadNIRSdb(DataBase);
	end
	
	
	subjectId = [DataBase.ID , 'U' ,num2str(DataBase.nSubjectPersistent,'%.3d')]; 
	
	DataBase.nSubject = DataBase.nSubject + 1;
	DataBase.nSubjectPersistent = DataBase.nSubjectPersistent + 1;	
	
	SubjectTemplate = NirsSubject(...
						'id', subjectId,...
						'template', true...
						);
	
	for iField = 1 : length(field)

		%search all the field lower case 
		switch lower(field{iField}) 
			% assaign preset value or create the field
			case 'name'				
				SubjectTemplate.name = defolutlValue{iField};

			case 'surname'		
				SubjectTemplate.surName	= defolutlValue{iField};	

			case 'birthday'	
				SubjectTemplate.birtDay = defolutlValue{iField};

			case 'note'	
				SubjectTemplate.note = defolutlValue{iField};

			otherwise
				SubjectTemplate.Info.(field{iField}) = defolutlValue{iField};

		end
		
	end
	
	DataBase.Subject(DataBase.nSubject) = SubjectTemplate;
					
	savedatabase(DataBase,DataBase.dataBasePath)
	
end

