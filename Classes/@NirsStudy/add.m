function DataBase = add(Study,DataBase)
%ADDMODIFYSUBJECT add a subject present in the database

	if ischar(DataBase)
		DataBase = GDataBase.load(DataBase);
	end
	
	% generate the id
	if ~isempty(Study.name)
		[DBStudy, DataBase] = DataBase.newstudy(Study.name);
	else
		[DBStudy, DataBase] = DataBase.newstudy;
	end
	
	
	% add file to database
	Study.id = DBStudy.id;

	save(DBStudy.path,'Study');
	
	
	%save database				
	DataBase.save;
end

