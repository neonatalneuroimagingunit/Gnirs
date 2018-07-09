function idDatabase = id2databaseid(id)
%ID2IDDATABASE Summary of this function goes here
%   Detailed explanation goes here
sizeDataBaseId = 7;


	if (ischar(id) && length(id)>=sizeDataBaseId)
		idDatabase = id(1:sizeDataBaseId);
	else
		error('in not valid')
	end
end

