function DBSubject = substitute(DBSubject,Subject)
%ADDMODIFYSUBJECT add or modify a subject present in the database

	if  (strcmp(DBSubject.id,Subject.id) || isempty(Subject.id))
		save(DBSubject.path,'Subject');
		
	else 
		error('id not match')
	end
	
end

