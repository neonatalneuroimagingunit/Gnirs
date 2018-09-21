function [Find, idx] = findid(DataBase, id)
	lengthDataBaseId = 7;
	
	
	
	
	
	if iscell(id)
		firstId = id{1};
	else 
		firstId = id;
	end
	if (length(firstId) > lengthDataBaseId)
		typeIdentifier = firstId(lengthDataBaseId + 1);
	else
		typeIdentifier = firstId(1);
	end
	
	switch typeIdentifier
		case 'D'
			if strcmp(DataBase.id,id)
				idx = 1;
				Find = DataBase;
			else
				idx = [];
				Find = [];
			end
			
		case 'S'
			idx = contains({DataBase.Study(:).id}, id);
			Find = DataBase.Study(idx);
			
		case 'M'
			idx = contains({DataBase.Measure(:).id}, id);
			Find = DataBase.Measure(idx);
			
		case 'A'
			idx = contains({DataBase.Analysis(:).id}, id);
			Find = DataBase.Analysis(idx);

		case 'U'
			idx = contains({DataBase.Subject(:).id}, id);
			Find = DataBase.Subject(idx);
			
		case 'P'
			idx = contains({DataBase.Probe(:).id}, id);
			
		case 'T'
			idx = contains({DataBase.Atlas(:).id}, id);
			Find = DataBase.Atlas(idx);
			
		otherwise
			warning('id not valid')
		
end

