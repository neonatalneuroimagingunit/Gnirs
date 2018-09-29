function DBSubject = substitute(DBSubject,Subject)
%ADDMODIFYSUBJECT add or modify a subject present in the database
	if isempty(Subject.id)
		Subject.id = DBSubject.id;
	end
	if  strcmp(DBSubject.id,Subject.id)
		save(DBSubject.path,'Subject');
		
	else 
		error('id not match')
	end
	
end

