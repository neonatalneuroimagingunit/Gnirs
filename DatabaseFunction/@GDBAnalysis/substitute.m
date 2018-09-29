function DBAnalysis = substitute(DBAnalysis,Analysis)
%ADDMODIFYSUBJECT add or modify a subject present in the database
	if isempty(Analysis.id)
		Analysis.id = DBAnalysis.id;
	end
	
	if  strcmp(DBAnalysis.id,Analysis.id) 
		save(DBAnalysis.path,'Analysis');
	else 
		error('id not match')
	end
	
end

