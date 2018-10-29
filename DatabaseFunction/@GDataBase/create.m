	function DataBase = create(pathDataBase)


		dirFullPath = fullfile(pathDataBase , 'GDataBase'); %create the new path
		
		%check if there is nota another one
		if ~exist(dirFullPath, 'dir')
			% create the directory
			mkdir(dirFullPath);
			
			mkdir(dirFullPath,'Study');
			mkdir(dirFullPath,'Probe');
			mkdir(dirFullPath,'Subject');
			mkdir(dirFullPath,'Atlas');


			%create new classes
			DataBase = GDataBase(dirFullPath);


			filefullPath = fullfile(DataBase.path, 'DataBase');
			save(filefullPath,'DataBase');

		else
			error('the database alredy exist')
		end
	end


