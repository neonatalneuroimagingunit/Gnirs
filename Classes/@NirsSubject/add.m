function DataBase = add(Subject,DataBase)
%ADDMODIFYSUBJECT add a subject present in the database

	if ischar(DataBase)
		DataBase = GDataBase.load(DataBase);
	end
	
	% generate the id
	if ~isempty(Subject.name)
		[DBSubject, DataBase] = DataBase.newsubject(Subject.name);
	else
		[DBSubject, DataBase] = DataBase.newsubject;
	end
	
	
	% add file to database
	Subject.id = DBSubject.id;

	save(DBSubject.path,'Subject');
	
	
	%save database				
	DataBase.save;
end

