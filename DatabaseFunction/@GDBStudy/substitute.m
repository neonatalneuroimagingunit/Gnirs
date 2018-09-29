function DBStudy = substitute(DBStudy,Study)
%ADDMODIFYSUBJECT add or modify a subject present in the database
	if isempty(Study.id)
		Study.id = DBStudy.id;
	end
	
	if  strcmp(DBStudy.id,Study.id) 
		save(DBStudy.path,'Study');
	else 
		error('id not match')
	end
	
end

