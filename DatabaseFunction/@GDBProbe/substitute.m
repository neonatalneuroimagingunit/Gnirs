function DBProbe = substitute(DBProbe,Probe)
%ADDMODIFYSUBJECT add or modify a subject present in the database
	if isempty(Probe.id)
		Probe.id = DBProbe.id;
	end
	
	if  strcmp(DBProbe.id,Probe.id) 
		save(DBProbe.path,'Probe');
	else 
		error('id not match')
	end
	
end

