function savedatabase(DataBase,databasePath)
%SAVEDATABASE Summary of this function goes here
%   Detailed explanation goes here

	if  ~isempty(DataBase)
		saveDBPath = fullfile(databasePath ,'NIRSDataBase.mat');
		save(saveDBPath,'DataBase');
	else 
		error('Database is empty')
	end
end

