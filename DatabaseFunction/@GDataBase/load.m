function DataBase = load(pathDataBase)
	pathDataBase = fullfile(pathDataBase, 'DataBase.mat');
	temp = load(pathDataBase ,'DataBase');
	DataBase = temp.DataBase;
end

