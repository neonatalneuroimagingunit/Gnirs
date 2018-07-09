function substitute(DBSubject,Subject)
%ADDMODIFYSUBJECT add or modify a subject present in the database

	if strcmp(Subject.id,DBSubject.id)
		save(DBSubject.path,'Subject');
		
	else 
		error('id didnt match')
	end
	
end

