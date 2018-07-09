function DBStudy = modify(DBStudy,NewStudy)
%ADDMODIFYSUBJECT add or modify a subject present in the database


	if (strcmp(DBStudy.id,NewStudy.id) || isempty(NewStudy.id))
	
		OldStudy = DBStudy.load;

		Study = NewStudy;
		
		% assign all nonspecify value to the old value
		studyFieldName = fieldnames(NewStudy);
		for iFieldName = 1 : length(studyFieldName)

			if isempty(NewStudy.(studyFieldName{iFieldName}))
				Study.(studyFieldName{iFieldName}) = OldStudy.(studyFieldName{iFieldName});
			end

		end
		
		save(DBStudy.path,'Study');
		
	else 
		error('id not match')
	end
end
