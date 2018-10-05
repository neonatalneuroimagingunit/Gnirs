function DBAtlas = substitute(DBAtlas,Atlas)

	if isempty(Atlas.id)
		Atlas.id = DBAtlas.id;
	end
	
	if  strcmp(DBAtlas.id,Atlas.id) 
		save(DBAtlas.path,'Atlas');
	else 
		error('id not match')
	end
	
end

