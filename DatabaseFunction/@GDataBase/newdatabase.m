function DataBase = newdatabase(Database, pathDataBase, pathGnirs)
	
	
	dirFullPath = fullfile(pathDataBase , 'GDataBase'); %create the new path

	if ~exist(dirFullPath, 'dir') %check if there is nota another one
		mkdir(dirFullPath);
	else
		error('the database alredy exist')
	end


	%creo la nuova classe
	DataBase = GDataBase(dirFullPath);
	
	
	filefullPath = fullfile(dirFullPath, 'DataBase');
	save(filefullPath,'DataBase');


	txtPath = fullfile(pathGnirs, 'Path.txt' );
	fid = fopen( txtPath, 'wt' );
	fprintf( fid, '%s', dirFullPath);
	fclose(fid);

end

