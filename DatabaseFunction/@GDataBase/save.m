function save(DataBase)
%SAVE Summary of this function goes here
%   Detailed explanation goes here
		filefullPath = fullfile(DataBase.path, 'DataBase');
		save(filefullPath,'DataBase');
end

