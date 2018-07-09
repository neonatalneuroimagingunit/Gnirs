function DBMeasure = substitute(DBMeasure,Measure)
%ADDMODIFYSUBJECT add or modify a subject present in the database
	if isempty(Measure.id)
		Measure.id = DBMeasure.id;
	end
	
	if  strcmp(DBMeasure.id,Measure.id) 
		save(DBMeasure.path,'Measure');
	else 
		error('id not match')
	end
	
end

